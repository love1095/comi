import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  Module,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  Put,
  Res,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiBody, ApiConsumes, ApiOkResponse, ApiParam, ApiProduces, ApiTags } from '@nestjs/swagger';
import {
  AvailabilityResultDto,
  ImportPreviewDto,
  ImportResultDto,
  MenuCategoryResponseDto,
  MenuPhotoDto,
  StaffMenuCategoryDto,
  StaffMenuItemDto,
} from '../../common/responses';
import { Response } from 'express';
import { AppError } from '../../common/errors/app-error';
import { buildTemplate, parseMenuRows, readSheet } from './menu-import';

const IMPORT_MAX_BYTES = 2 * 1024 * 1024;
import { Perm } from '../../common/auth/auth.types';
import { RestaurantId, RestaurantRoles } from '../../common/auth/decorators';
import {
  AddPhotoDto,
  AvailabilityDto,
  CategoryDto,
  CONTENT_LOCALES,
  MenuItemDto,
  ReorderDto,
  TranslationDto,
  TranslationParams,
  UpdateCategoryDto,
  UpdateMenuItemDto,
} from './menu.dto';
import { MenuService } from './menu.service';

const uuid = new ParseUUIDPipe();

@ApiTags('restaurant / menu')
@Controller('restaurant/menu')
export class MenuController {
  constructor(private readonly menu: MenuService) {}

  @RestaurantRoles(...Perm.KITCHEN)
  @Get()
  @ApiOkResponse({ type: [StaffMenuCategoryDto] })
  get(@RestaurantId() rid: string) {
    return this.menu.getMenu(rid);
  }

  // categories
  @RestaurantRoles(...Perm.MENU_TABLES)
  @Post('categories')
  @ApiOkResponse({ type: MenuCategoryResponseDto })
  createCategory(@RestaurantId() rid: string, @Body() dto: CategoryDto) {
    return this.menu.createCategory(rid, dto);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Put('categories/order')
  @HttpCode(204)
  reorderCategories(@RestaurantId() rid: string, @Body() dto: ReorderDto) {
    return this.menu.reorderCategories(rid, dto.ids);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Patch('categories/:id')
  @ApiOkResponse({ type: MenuCategoryResponseDto })
  updateCategory(@RestaurantId() rid: string, @Param('id', uuid) id: string, @Body() dto: UpdateCategoryDto) {
    return this.menu.updateCategory(rid, id, dto);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Delete('categories/:id')
  @HttpCode(204)
  deleteCategory(@RestaurantId() rid: string, @Param('id', uuid) id: string) {
    return this.menu.deleteCategory(rid, id);
  }

  // items
  @RestaurantRoles(...Perm.MENU_TABLES)
  @Post('items')
  @ApiOkResponse({ type: StaffMenuItemDto })
  createItem(@RestaurantId() rid: string, @Body() dto: MenuItemDto) {
    return this.menu.createItem(rid, dto);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Put('items/order')
  @HttpCode(204)
  reorderItems(@RestaurantId() rid: string, @Body() dto: ReorderDto) {
    return this.menu.reorderItems(rid, dto.ids);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Patch('items/:id')
  @ApiOkResponse({ type: StaffMenuItemDto })
  updateItem(@RestaurantId() rid: string, @Param('id', uuid) id: string, @Body() dto: UpdateMenuItemDto) {
    return this.menu.updateItem(rid, id, dto);
  }

  /** Sold-out switch — cashiers can flip it during service too. */
  @RestaurantRoles(...Perm.BOOKINGS)
  @Patch('items/:id/availability')
  @ApiOkResponse({ type: AvailabilityResultDto })
  availability(@RestaurantId() rid: string, @Param('id', uuid) id: string, @Body() dto: AvailabilityDto) {
    return this.menu.setAvailability(rid, id, dto.isAvailable);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Delete('items/:id')
  @HttpCode(204)
  deleteItem(@RestaurantId() rid: string, @Param('id', uuid) id: string) {
    return this.menu.deleteItem(rid, id);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Put('items/:id/translations/:locale')
  @ApiParam({ name: 'id', format: 'uuid' })
  @ApiParam({ name: 'locale', enum: CONTENT_LOCALES })
  translation(@RestaurantId() rid: string, @Param() p: TranslationParams, @Body() dto: TranslationDto) {
    return this.menu.putTranslation(rid, p.id, p.locale, dto);
  }

  // Excel / CSV import: download template → fill → preview → confirm (same file again)
  @RestaurantRoles(...Perm.MENU_TABLES)
  @Get('import/template')
  @ApiProduces('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
  async template(@Res() res: Response) {
    res
      .type('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
      .setHeader('Content-Disposition', 'attachment; filename="comi-thuc-don.xlsx"')
      .send(await buildTemplate());
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Post('import/preview')
  @HttpCode(200)
  @ApiConsumes('multipart/form-data')
  @ApiBody({ schema: { type: 'object', properties: { file: { type: 'string', format: 'binary' } } } })
  @UseInterceptors(FileInterceptor('file', { limits: { fileSize: IMPORT_MAX_BYTES } }))
  @ApiOkResponse({ type: ImportPreviewDto })
  async importPreview(@UploadedFile() file?: Express.Multer.File) {
    return this.parseUpload(file);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Post('import/confirm')
  @ApiConsumes('multipart/form-data')
  @ApiBody({ schema: { type: 'object', properties: { file: { type: 'string', format: 'binary' } } } })
  @UseInterceptors(FileInterceptor('file', { limits: { fileSize: IMPORT_MAX_BYTES } }))
  @ApiOkResponse({ type: ImportResultDto })
  async importConfirm(@RestaurantId() rid: string, @UploadedFile() file?: Express.Multer.File) {
    const parsed = await this.parseUpload(file);
    if (parsed.errors.length) throw new AppError('VALIDATION_FAILED', 'Fix the errors in the file first', { errors: parsed.errors });
    if (!parsed.items.length) throw new AppError('VALIDATION_FAILED', 'The file has no dishes');
    return this.menu.importItems(rid, parsed.items);
  }

  private async parseUpload(file?: Express.Multer.File) {
    if (!file) throw new AppError('VALIDATION_FAILED', 'Upload a file in field "file"');
    if (!/\.(xlsx|csv)$/i.test(file.originalname)) throw new AppError('VALIDATION_FAILED', 'Only .xlsx or .csv files');
    let sheet: { header: string[]; rows: string[][] };
    try {
      sheet = await readSheet(file.buffer, file.originalname);
    } catch {
      throw new AppError('VALIDATION_FAILED', 'Could not read the file');
    }
    return parseMenuRows(sheet.header, sheet.rows);
  }

  // photos
  @RestaurantRoles(...Perm.MENU_TABLES)
  @Post('items/:id/photos')
  @ApiOkResponse({ type: MenuPhotoDto })
  addPhoto(@RestaurantId() rid: string, @Param('id', uuid) id: string, @Body() dto: AddPhotoDto) {
    return this.menu.addPhoto(rid, id, dto);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Put('items/:id/photos/order')
  @HttpCode(204)
  reorderPhotos(@RestaurantId() rid: string, @Param('id', uuid) id: string, @Body() dto: ReorderDto) {
    return this.menu.reorderPhotos(rid, id, dto.ids);
  }

  @RestaurantRoles(...Perm.MENU_TABLES)
  @Delete('photos/:photoId')
  @HttpCode(204)
  deletePhoto(@RestaurantId() rid: string, @Param('photoId', uuid) photoId: string) {
    return this.menu.deletePhoto(rid, photoId);
  }
}

@Module({ controllers: [MenuController], providers: [MenuService] })
export class MenuModule {}
