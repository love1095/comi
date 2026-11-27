import { Module } from '@nestjs/common';
import { DiningRulesController } from './dining-rules.controller';
import { GoongService } from './goong.service';
import { AdminRestaurantsController, RestaurantController } from './restaurants.controller';
import { RestaurantsService } from './restaurants.service';

@Module({
  controllers: [RestaurantController, AdminRestaurantsController, DiningRulesController],
  providers: [RestaurantsService, GoongService],
  exports: [RestaurantsService],
})
export class RestaurantsModule {}
