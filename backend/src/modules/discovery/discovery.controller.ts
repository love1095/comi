import { Controller, Get, Headers, Module, Param, ParseUUIDPipe, Query } from '@nestjs/common';
import { ApiHeader, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { HomeDto, MapPinDto, PublicMenuCategoryDto, RestaurantDetailDto, RestaurantPageDto, SuggestDto } from '../../common/customer-responses';
import { Public } from '../../common/auth/decorators';
import { pickLocale } from '../../common/i18n';
import { HomeQuery, MapQuery, NearbyQuery, SuggestQuery } from './discovery.dto';
import { DiscoveryService } from './discovery.service';

const LANG = { name: 'Accept-Language', required: false, description: 'vi | en | ko | zh | ja (fallback → en → vi)' };

@ApiTags('customer / discovery')
@Public()
@Controller()
export class DiscoveryController {
  constructor(private readonly discovery: DiscoveryService) {}

  @Get('home')
  @ApiHeader(LANG)
  @ApiOkResponse({ type: HomeDto })
  home(@Query() q: HomeQuery, @Headers('accept-language') lang?: string) {
    return this.discovery.home(q.lat, q.lng, pickLocale(lang));
  }

  @Get('restaurants')
  @ApiHeader(LANG)
  @ApiOkResponse({ type: RestaurantPageDto })
  nearby(@Query() q: NearbyQuery, @Headers('accept-language') lang?: string) {
    return this.discovery.nearby(q, pickLocale(lang));
  }

  @Get('restaurants/map')
  @ApiOkResponse({ type: [MapPinDto] })
  map(@Query() q: MapQuery) {
    return this.discovery.map(q.bbox);
  }

  @Get('search/suggest')
  @ApiOkResponse({ type: SuggestDto })
  suggest(@Query() q: SuggestQuery) {
    return this.discovery.suggest(q.q);
  }

  @Get('restaurants/:id/menu')
  @ApiHeader(LANG)
  @ApiOkResponse({ type: [PublicMenuCategoryDto] })
  menu(@Param('id', ParseUUIDPipe) id: string, @Headers('accept-language') lang?: string) {
    return this.discovery.menu(id, pickLocale(lang));
  }

  /** Declared last so "map" is not taken as a slug. */
  @Get('restaurants/:slug')
  @ApiHeader(LANG)
  @ApiOkResponse({ type: RestaurantDetailDto })
  detail(@Param('slug') slug: string, @Headers('accept-language') lang?: string) {
    return this.discovery.detail(slug, pickLocale(lang));
  }
}

@Module({ controllers: [DiscoveryController], providers: [DiscoveryService] })
export class DiscoveryModule {}
