import 'package:comi_api/src/model/add_photo_dto.dart';
import 'package:comi_api/src/model/area_brief_dto.dart';
import 'package:comi_api/src/model/area_dto.dart';
import 'package:comi_api/src/model/area_layout_dto.dart';
import 'package:comi_api/src/model/area_summary_dto.dart';
import 'package:comi_api/src/model/availability_dto.dart';
import 'package:comi_api/src/model/availability_result_dto.dart';
import 'package:comi_api/src/model/bill_dto.dart';
import 'package:comi_api/src/model/bill_round_dto.dart';
import 'package:comi_api/src/model/board_booking_dto.dart';
import 'package:comi_api/src/model/board_order_dto.dart';
import 'package:comi_api/src/model/board_order_item_dto.dart';
import 'package:comi_api/src/model/board_table_dto.dart';
import 'package:comi_api/src/model/board_user_dto.dart';
import 'package:comi_api/src/model/booking_detail_dto.dart';
import 'package:comi_api/src/model/booking_detail_order_dto.dart';
import 'package:comi_api/src/model/booking_restaurant_dto.dart';
import 'package:comi_api/src/model/booking_table_dto.dart';
import 'package:comi_api/src/model/cancel_dto.dart';
import 'package:comi_api/src/model/capacity_rule_dto.dart';
import 'package:comi_api/src/model/capacity_rule_input.dart';
import 'package:comi_api/src/model/capacity_rules_dto.dart';
import 'package:comi_api/src/model/cart_line_dto.dart';
import 'package:comi_api/src/model/category_dto.dart';
import 'package:comi_api/src/model/check_in_dto.dart';
import 'package:comi_api/src/model/checklist_dto.dart';
import 'package:comi_api/src/model/close_bill_dto.dart';
import 'package:comi_api/src/model/closure_dto.dart';
import 'package:comi_api/src/model/closure_info_dto.dart';
import 'package:comi_api/src/model/create_booking_dto.dart';
import 'package:comi_api/src/model/create_hold_dto.dart';
import 'package:comi_api/src/model/create_table_dto.dart';
import 'package:comi_api/src/model/customer_booking_dto.dart';
import 'package:comi_api/src/model/customer_exchange_dto.dart';
import 'package:comi_api/src/model/customer_order_dto.dart';
import 'package:comi_api/src/model/depart_dto.dart';
import 'package:comi_api/src/model/depart_result_dto.dart';
import 'package:comi_api/src/model/device_token_dto.dart';
import 'package:comi_api/src/model/dining_rule_dto.dart';
import 'package:comi_api/src/model/favorite_dto.dart';
import 'package:comi_api/src/model/fire_dto.dart';
import 'package:comi_api/src/model/fire_result_dto.dart';
import 'package:comi_api/src/model/geocode_result_dto.dart';
import 'package:comi_api/src/model/group_guest_dto.dart';
import 'package:comi_api/src/model/group_item_dto.dart';
import 'package:comi_api/src/model/group_items_dto.dart';
import 'package:comi_api/src/model/group_member_dto.dart';
import 'package:comi_api/src/model/group_restaurant_dto.dart';
import 'package:comi_api/src/model/group_view_dto.dart';
import 'package:comi_api/src/model/guest_key_dto.dart';
import 'package:comi_api/src/model/hold_dto.dart';
import 'package:comi_api/src/model/home_dto.dart';
import 'package:comi_api/src/model/home_section_dto.dart';
import 'package:comi_api/src/model/import_error_dto.dart';
import 'package:comi_api/src/model/import_preview_dto.dart';
import 'package:comi_api/src/model/import_result_dto.dart';
import 'package:comi_api/src/model/imported_item_dto.dart';
import 'package:comi_api/src/model/join_group_dto.dart';
import 'package:comi_api/src/model/kitchen_item_dto.dart';
import 'package:comi_api/src/model/kitchen_queue_dto.dart';
import 'package:comi_api/src/model/kitchen_status_dto.dart';
import 'package:comi_api/src/model/layout_table_dto.dart';
import 'package:comi_api/src/model/map_area_dto.dart';
import 'package:comi_api/src/model/map_area_with_elements_dto.dart';
import 'package:comi_api/src/model/map_element_dto.dart';
import 'package:comi_api/src/model/map_element_response_dto.dart';
import 'package:comi_api/src/model/map_pin_dto.dart';
import 'package:comi_api/src/model/map_table_state_dto.dart';
import 'package:comi_api/src/model/mark_paid_dto.dart';
import 'package:comi_api/src/model/me_dto.dart';
import 'package:comi_api/src/model/membership_dto.dart';
import 'package:comi_api/src/model/menu_category_response_dto.dart';
import 'package:comi_api/src/model/menu_item_dto.dart';
import 'package:comi_api/src/model/menu_option_response_dto.dart';
import 'package:comi_api/src/model/menu_photo_dto.dart';
import 'package:comi_api/src/model/menu_translation_dto.dart';
import 'package:comi_api/src/model/move_table_dto.dart';
import 'package:comi_api/src/model/my_bookings_page_dto.dart';
import 'package:comi_api/src/model/my_hold_dto.dart';
import 'package:comi_api/src/model/opening_hours_dto.dart';
import 'package:comi_api/src/model/opening_hours_item_dto.dart';
import 'package:comi_api/src/model/option_dto.dart';
import 'package:comi_api/src/model/option_group_dto.dart';
import 'package:comi_api/src/model/option_group_response_dto.dart';
import 'package:comi_api/src/model/option_snapshot_dto.dart';
import 'package:comi_api/src/model/preferences_dto.dart';
import 'package:comi_api/src/model/public_menu_category_dto.dart';
import 'package:comi_api/src/model/public_menu_item_dto.dart';
import 'package:comi_api/src/model/public_option_dto.dart';
import 'package:comi_api/src/model/public_option_group_dto.dart';
import 'package:comi_api/src/model/public_photo_dto.dart';
import 'package:comi_api/src/model/refresh_dto.dart';
import 'package:comi_api/src/model/register_restaurant_dto.dart';
import 'package:comi_api/src/model/reject_dto.dart';
import 'package:comi_api/src/model/reorder_draft_dto.dart';
import 'package:comi_api/src/model/reorder_dto.dart';
import 'package:comi_api/src/model/reorder_line_dto.dart';
import 'package:comi_api/src/model/replace_opening_hours_dto.dart';
import 'package:comi_api/src/model/restaurant_cancel_dto.dart';
import 'package:comi_api/src/model/restaurant_card_dto.dart';
import 'package:comi_api/src/model/restaurant_detail_dto.dart';
import 'package:comi_api/src/model/restaurant_page_dto.dart';
import 'package:comi_api/src/model/restaurant_profile_dto.dart';
import 'package:comi_api/src/model/restaurant_summary_dto.dart';
import 'package:comi_api/src/model/round_result_dto.dart';
import 'package:comi_api/src/model/save_layout_dto.dart';
import 'package:comi_api/src/model/save_split_dto.dart';
import 'package:comi_api/src/model/saved_order_dto.dart';
import 'package:comi_api/src/model/service_request_create_dto.dart';
import 'package:comi_api/src/model/service_request_dto.dart';
import 'package:comi_api/src/model/slot_dto.dart';
import 'package:comi_api/src/model/split_dto.dart';
import 'package:comi_api/src/model/split_guest_dto.dart';
import 'package:comi_api/src/model/staff_login_dto.dart';
import 'package:comi_api/src/model/staff_menu_category_dto.dart';
import 'package:comi_api/src/model/staff_menu_item_dto.dart';
import 'package:comi_api/src/model/staff_register_dto.dart';
import 'package:comi_api/src/model/start_group_dto.dart';
import 'package:comi_api/src/model/suggest_dish_dto.dart';
import 'package:comi_api/src/model/suggest_dto.dart';
import 'package:comi_api/src/model/suggest_restaurant_dto.dart';
import 'package:comi_api/src/model/table_dto.dart';
import 'package:comi_api/src/model/table_map_dto.dart';
import 'package:comi_api/src/model/table_order_dto.dart';
import 'package:comi_api/src/model/token_pair_dto.dart';
import 'package:comi_api/src/model/translation_dto.dart';
import 'package:comi_api/src/model/unavailable_line_dto.dart';
import 'package:comi_api/src/model/update_area_dto.dart';
import 'package:comi_api/src/model/update_category_dto.dart';
import 'package:comi_api/src/model/update_me_dto.dart';
import 'package:comi_api/src/model/update_menu_item_dto.dart';
import 'package:comi_api/src/model/update_profile_dto.dart';
import 'package:comi_api/src/model/update_settings_dto.dart';
import 'package:comi_api/src/model/update_table_dto.dart';
import 'package:comi_api/src/model/upload_signature_dto.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

  ReturnType deserialize<ReturnType, BaseType>(dynamic value, String targetType, {bool growable= true}) {
      switch (targetType) {
        case 'String':
          return '$value' as ReturnType;
        case 'int':
          return (value is int ? value : int.parse('$value')) as ReturnType;
        case 'bool':
          if (value is bool) {
            return value as ReturnType;
          }
          final valueString = '$value'.toLowerCase();
          return (valueString == 'true' || valueString == '1') as ReturnType;
        case 'double':
          return (value is double ? value : double.parse('$value')) as ReturnType;
        case 'AddPhotoDto':
          return AddPhotoDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AreaBriefDto':
          return AreaBriefDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AreaDto':
          return AreaDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AreaLayoutDto':
          return AreaLayoutDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AreaSummaryDto':
          return AreaSummaryDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AvailabilityDto':
          return AvailabilityDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AvailabilityResultDto':
          return AvailabilityResultDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BillDto':
          return BillDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BillRoundDto':
          return BillRoundDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BoardBookingDto':
          return BoardBookingDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BoardOrderDto':
          return BoardOrderDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BoardOrderItemDto':
          return BoardOrderItemDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BoardTableDto':
          return BoardTableDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BoardUserDto':
          return BoardUserDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BookingDetailDto':
          return BookingDetailDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BookingDetailOrderDto':
          return BookingDetailOrderDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BookingRestaurantDto':
          return BookingRestaurantDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BookingStatus':
          
          
        case 'BookingTableDto':
          return BookingTableDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CancelDto':
          return CancelDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CapacityRuleDto':
          return CapacityRuleDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CapacityRuleInput':
          return CapacityRuleInput.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CapacityRulesDto':
          return CapacityRulesDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CartLineDto':
          return CartLineDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CategoryDto':
          return CategoryDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CheckInDto':
          return CheckInDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ChecklistDto':
          return ChecklistDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CloseBillDto':
          return CloseBillDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ClosureDto':
          return ClosureDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ClosureInfoDto':
          return ClosureInfoDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Course':
          
          
        case 'CreateBookingDto':
          return CreateBookingDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateHoldDto':
          return CreateHoldDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateTableDto':
          return CreateTableDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CustomerBookingDto':
          return CustomerBookingDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CustomerExchangeDto':
          return CustomerExchangeDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CustomerOrderDto':
          return CustomerOrderDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DepartDto':
          return DepartDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DepartResultDto':
          return DepartResultDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DeviceTokenDto':
          return DeviceTokenDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DiningRuleDto':
          return DiningRuleDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FavoriteDto':
          return FavoriteDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FireDto':
          return FireDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FireResultDto':
          return FireResultDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GeocodeResultDto':
          return GeocodeResultDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GroupGuestDto':
          return GroupGuestDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GroupItemDto':
          return GroupItemDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GroupItemsDto':
          return GroupItemsDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GroupMemberDto':
          return GroupMemberDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GroupRestaurantDto':
          return GroupRestaurantDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GroupViewDto':
          return GroupViewDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GuestKeyDto':
          return GuestKeyDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'HoldDto':
          return HoldDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'HomeDto':
          return HomeDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'HomeSectionDto':
          return HomeSectionDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ImportErrorDto':
          return ImportErrorDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ImportPreviewDto':
          return ImportPreviewDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ImportResultDto':
          return ImportResultDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ImportedItemDto':
          return ImportedItemDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ItemKind':
          
          
        case 'JoinGroupDto':
          return JoinGroupDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'KitchenItemDto':
          return KitchenItemDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'KitchenQueueDto':
          return KitchenQueueDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'KitchenStatus':
          
          
        case 'KitchenStatusDto':
          return KitchenStatusDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'LayoutTableDto':
          return LayoutTableDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MapAreaDto':
          return MapAreaDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MapAreaWithElementsDto':
          return MapAreaWithElementsDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MapElementDto':
          return MapElementDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MapElementResponseDto':
          return MapElementResponseDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MapElementType':
          
          
        case 'MapPinDto':
          return MapPinDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MapTableStateDto':
          return MapTableStateDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MarkPaidDto':
          return MarkPaidDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MeDto':
          return MeDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MembershipDto':
          return MembershipDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MenuCategoryResponseDto':
          return MenuCategoryResponseDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MenuItemDto':
          return MenuItemDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MenuOptionResponseDto':
          return MenuOptionResponseDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MenuPhotoDto':
          return MenuPhotoDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MenuTranslationDto':
          return MenuTranslationDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MoveTableDto':
          return MoveTableDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MyBookingsPageDto':
          return MyBookingsPageDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MyHoldDto':
          return MyHoldDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OpeningHoursDto':
          return OpeningHoursDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OpeningHoursItemDto':
          return OpeningHoursItemDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OptionDto':
          return OptionDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OptionGroupDto':
          return OptionGroupDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OptionGroupResponseDto':
          return OptionGroupResponseDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OptionSnapshotDto':
          return OptionSnapshotDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderStatus':
          
          
        case 'PaymentMode':
          
          
        case 'PreferencesDto':
          return PreferencesDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PublicMenuCategoryDto':
          return PublicMenuCategoryDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PublicMenuItemDto':
          return PublicMenuItemDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PublicOptionDto':
          return PublicOptionDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PublicOptionGroupDto':
          return PublicOptionGroupDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PublicPhotoDto':
          return PublicPhotoDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RefreshDto':
          return RefreshDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RegisterRestaurantDto':
          return RegisterRestaurantDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RejectDto':
          return RejectDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ReorderDraftDto':
          return ReorderDraftDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ReorderDto':
          return ReorderDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ReorderLineDto':
          return ReorderLineDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ReplaceOpeningHoursDto':
          return ReplaceOpeningHoursDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RestaurantCancelDto':
          return RestaurantCancelDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RestaurantCardDto':
          return RestaurantCardDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RestaurantDetailDto':
          return RestaurantDetailDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RestaurantPageDto':
          return RestaurantPageDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RestaurantProfileDto':
          return RestaurantProfileDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RestaurantStatus':
          
          
        case 'RestaurantSummaryDto':
          return RestaurantSummaryDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RoundResultDto':
          return RoundResultDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SaveLayoutDto':
          return SaveLayoutDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SaveSplitDto':
          return SaveSplitDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SavedOrderDto':
          return SavedOrderDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ServeStyle':
          
          
        case 'ServiceRequestCreateDto':
          return ServiceRequestCreateDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ServiceRequestDto':
          return ServiceRequestDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ServiceType':
          
          
        case 'SlotDto':
          return SlotDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SplitDto':
          return SplitDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SplitGuestDto':
          return SplitGuestDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SplitMode':
          
          
        case 'StaffLoginDto':
          return StaffLoginDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'StaffMenuCategoryDto':
          return StaffMenuCategoryDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'StaffMenuItemDto':
          return StaffMenuItemDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'StaffRegisterDto':
          return StaffRegisterDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'StaffRole':
          
          
        case 'StartGroupDto':
          return StartGroupDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SuggestDishDto':
          return SuggestDishDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SuggestDto':
          return SuggestDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SuggestRestaurantDto':
          return SuggestRestaurantDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'TableDto':
          return TableDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'TableMapDto':
          return TableMapDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'TableOrderDto':
          return TableOrderDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'TableShape':
          
          
        case 'TokenPairDto':
          return TokenPairDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'TranslationDto':
          return TranslationDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UnavailableLineDto':
          return UnavailableLineDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateAreaDto':
          return UpdateAreaDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateCategoryDto':
          return UpdateCategoryDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateMeDto':
          return UpdateMeDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateMenuItemDto':
          return UpdateMenuItemDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateProfileDto':
          return UpdateProfileDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateSettingsDto':
          return UpdateSettingsDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateTableDto':
          return UpdateTableDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UploadSignatureDto':
          return UploadSignatureDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        default:
          RegExpMatch? match;

          if (value is List && (match = _regList.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toList(growable: growable) as ReturnType;
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toSet() as ReturnType;
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
            targetType = match![1]!.trim(); // ignore: parameter_assignments
            return Map<String, BaseType>.fromIterables(
              value.keys as Iterable<String>,
              value.values.map((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable)),
            ) as ReturnType;
          }
          break;
    }
    throw Exception('Cannot deserialize');
  }