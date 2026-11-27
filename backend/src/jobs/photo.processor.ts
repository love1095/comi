import { Inject, Injectable, Logger } from '@nestjs/common';
import { encode } from 'blurhash';
import sharp from 'sharp';
import { ENV } from '../config/config.module';
import { Env } from '../config/env';
import { PrismaService } from '../prisma/prisma.service';

/**
 * photo-process (§16.1): download a small thumbnail from Cloudinary and compute its blurhash,
 * shown by the apps while the real photo loads. Idempotent.
 */
@Injectable()
export class PhotoProcessor {
  private readonly logger = new Logger(PhotoProcessor.name);

  constructor(
    private readonly prisma: PrismaService,
    @Inject(ENV) private readonly env: Env,
  ) {}

  async process(photoId: string): Promise<void> {
    const photo = await this.prisma.menuItemPhoto.findUnique({ where: { id: photoId } });
    if (!photo || photo.blurhash) return;
    if (!this.env.CLOUDINARY_CLOUD_NAME) {
      this.logger.warn(`Cloudinary not configured, skipping blurhash for ${photoId}`);
      return;
    }
    const url = `https://res.cloudinary.com/${this.env.CLOUDINARY_CLOUD_NAME}/image/upload/c_fill,ar_4:3,w_64,q_auto,f_png/${photo.publicId}`;
    const res = await fetch(url, { signal: AbortSignal.timeout(10_000) });
    if (!res.ok) throw new Error(`Thumbnail download failed: ${res.status}`);
    const blurhash = await computeBlurhash(Buffer.from(await res.arrayBuffer()));
    await this.prisma.menuItemPhoto.update({ where: { id: photoId }, data: { blurhash } });
  }
}

/** 4×3 components fit the 4:3 dish photos. */
export async function computeBlurhash(image: Buffer): Promise<string> {
  const { data, info } = await sharp(image).resize(32, 24, { fit: 'cover' }).ensureAlpha().raw().toBuffer({ resolveWithObject: true });
  return encode(new Uint8ClampedArray(data), info.width, info.height, 4, 3);
}
