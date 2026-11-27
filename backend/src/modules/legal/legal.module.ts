import { Controller, Get, Header, Module, Param, Query } from '@nestjs/common';
import { ApiOkResponse, ApiParam, ApiProperty, ApiQuery, ApiTags } from '@nestjs/swagger';
import { Public } from '../../common/auth/decorators';
import { notFound } from '../../common/errors/app-error';
import { LEGAL, TERMS_VERSION, legalHtml } from './legal-texts';

export { TERMS_VERSION };

class LegalInfoDto {
  @ApiProperty({ example: '2026-12' }) termsVersion: string;
  @ApiProperty() privacyPath: string;
  @ApiProperty() termsPath: string;
}

@ApiTags('public / legal')
@Public()
@Controller('legal')
export class LegalController {
  /** Current version: apps ask for consent again when it differs from the user's. */
  @Get()
  @ApiOkResponse({ type: LegalInfoDto })
  info() {
    return { termsVersion: TERMS_VERSION, privacyPath: '/api/v1/legal/privacy', termsPath: '/api/v1/legal/terms' };
  }

  @Get(':doc')
  @Header('Content-Type', 'text/html; charset=utf-8')
  @Header('Cache-Control', 'public, max-age=3600')
  @ApiParam({ name: 'doc', enum: ['privacy', 'terms'] })
  @ApiQuery({ name: 'lang', required: false, enum: ['vi', 'en'] })
  page(@Param('doc') doc: string, @Query('lang') lang?: string) {
    if (doc !== 'privacy' && doc !== 'terms') throw notFound('Document');
    return legalHtml(doc, lang === 'en' ? 'en' : 'vi');
  }
}

@Module({ controllers: [LegalController] })
export class LegalModule {}

export { LEGAL };
