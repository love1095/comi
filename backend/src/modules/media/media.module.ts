import { Controller, Get, Global, Module, Query } from '@nestjs/common';
import { ApiOkResponse, ApiQuery, ApiTags } from '@nestjs/swagger';
import { UploadSignatureDto } from '../../common/responses';
import { IsIn } from 'class-validator';
import { Perm } from '../../common/auth/auth.types';
import { RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import { MediaKind, MediaService } from './media.service';

class SignatureQuery {
  @IsIn(['menu_item', 'cover', 'area_background'])
  kind: Exclude<MediaKind, 'review'>;
}

@ApiTags('media')
@Controller('media')
export class MediaController {
  constructor(private readonly media: MediaService) {}

  /** Restaurant photos. Review photos (customers) come with reviews in Phase 5. */
  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get('upload-signature')
  @ApiQuery({ name: 'kind', enum: ['menu_item', 'cover', 'area_background'] })
  @ApiOkResponse({ type: UploadSignatureDto })
  signature(@RestaurantId() rid: string, @Query() q: SignatureQuery) {
    return this.media.sign(rid, q.kind);
  }
}

@Global()
@Module({ controllers: [MediaController], providers: [MediaService], exports: [MediaService] })
export class MediaModule {}
