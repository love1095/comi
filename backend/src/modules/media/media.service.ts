import { Inject, Injectable } from '@nestjs/common';
import { v2 as cloudinary } from 'cloudinary';
import { AppError } from '../../common/errors/app-error';
import { Clock } from '../../common/clock';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';

export type MediaKind = 'menu_item' | 'cover' | 'area_background' | 'review';

/** Photo rules §16.2. */
export const PHOTO_RULES: Record<MediaKind, { ratio?: number; minW: number; minH: number }> = {
  menu_item: { ratio: 4 / 3, minW: 1200, minH: 900 },
  cover: { ratio: 16 / 9, minW: 1600, minH: 900 },
  area_background: { minW: 800, minH: 600 },
  review: { minW: 800, minH: 800 },
};

export interface UploadSignature {
  cloudName: string;
  apiKey: string;
  timestamp: number;
  folder: string;
  signature: string;
}

@Injectable()
export class MediaService {
  constructor(
    @Inject(ENV) private readonly env: Env,
    private readonly clock: Clock,
  ) {
    if (this.configured) {
      cloudinary.config({
        cloud_name: env.CLOUDINARY_CLOUD_NAME,
        api_key: env.CLOUDINARY_API_KEY,
        api_secret: env.CLOUDINARY_API_SECRET,
        secure: true,
      });
    }
  }

  get configured(): boolean {
    return !!(this.env.CLOUDINARY_CLOUD_NAME && this.env.CLOUDINARY_API_KEY && this.env.CLOUDINARY_API_SECRET);
  }

  /** Folder per environment / owner / kind. Saved photos must live inside it. */
  folderFor(ownerId: string, kind: MediaKind): string {
    return `comi/${this.env.NODE_ENV}/${ownerId}/${kind}`;
  }

  /** §16.1: app uploads straight to Cloudinary with these signed params. */
  sign(ownerId: string, kind: MediaKind): UploadSignature {
    if (!this.configured) throw new AppError('SERVICE_UNAVAILABLE', 'Photo upload is not configured');
    const timestamp = Math.floor(this.clock.now().getTime() / 1000);
    const folder = this.folderFor(ownerId, kind);
    const signature = cloudinary.utils.api_sign_request({ timestamp, folder }, this.env.CLOUDINARY_API_SECRET!);
    return { cloudName: this.env.CLOUDINARY_CLOUD_NAME!, apiKey: this.env.CLOUDINARY_API_KEY!, timestamp, folder, signature };
  }

  /**
   * Confirm an uploaded image belongs to the owner's folder and meets the photo rules.
   * Returns its real size from Cloudinary (never trust the client).
   */
  async verifyUpload(
    ownerId: string,
    kind: MediaKind,
    publicId: string,
    devSize?: { width?: number; height?: number },
  ): Promise<{ width: number; height: number }> {
    const folder = this.folderFor(ownerId, kind);
    if (!publicId.startsWith(`${folder}/`)) throw new AppError('FORBIDDEN', 'Photo is not in your upload folder');

    let width: number;
    let height: number;
    if (this.configured) {
      try {
        const res = (await cloudinary.api.resource(publicId)) as { width: number; height: number };
        ({ width, height } = res);
      } catch {
        throw new AppError('NOT_FOUND', 'Uploaded photo not found');
      }
    } else if (this.env.NODE_ENV !== 'production' && devSize?.width && devSize?.height) {
      ({ width, height } = devSize as { width: number; height: number });
    } else {
      throw new AppError('SERVICE_UNAVAILABLE', 'Photo upload is not configured');
    }

    checkPhotoRules(kind, width, height);
    return { width, height };
  }

  async destroy(publicId: string) {
    if (this.configured) await cloudinary.uploader.destroy(publicId).catch(() => undefined);
  }
}

export function checkPhotoRules(kind: MediaKind, width: number, height: number) {
  const rule = PHOTO_RULES[kind];
  if (width < rule.minW || height < rule.minH) {
    throw new AppError('VALIDATION_FAILED', `Photo must be at least ${rule.minW}×${rule.minH}`, { width, height });
  }
  if (rule.ratio && Math.abs(width / height - rule.ratio) > 0.02) {
    throw new AppError('VALIDATION_FAILED', 'Photo has the wrong aspect ratio', { width, height, expected: rule.ratio });
  }
}
