import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/session.dart';

/// Restaurant profile + setup steps (§22.2). Register works before a restaurant is selected.
abstract class OnboardingRepository {
  Future<RestaurantProfileDto> register(RegisterRestaurantDto dto);
  Future<RestaurantProfileDto> profile(String restaurantId);
  Future<RestaurantProfileDto> updateProfile(String restaurantId, UpdateProfileDto dto);
  Future<List<GeocodeResultDto>> geocode(String query);
  Future<List<OpeningHoursDto>> setOpeningHours(String restaurantId, List<OpeningHoursItemDto> items);
  Future<ChecklistDto> checklist(String restaurantId);
  Future<RestaurantProfileDto> submit(String restaurantId);
  Future<RestaurantProfileDto> updateSettings(String restaurantId, UpdateSettingsDto dto);
}

class ApiOnboardingRepository implements OnboardingRepository {
  ApiOnboardingRepository(this._api);
  final RestaurantApi _api;

  @override
  Future<RestaurantProfileDto> register(RegisterRestaurantDto dto) async =>
      (await _api.restaurantRegister(registerRestaurantDto: dto)).data!;

  @override
  Future<RestaurantProfileDto> profile(String rid) async => (await _api.restaurantProfile(xRestaurantId: rid)).data!;

  @override
  Future<RestaurantProfileDto> updateProfile(String rid, UpdateProfileDto dto) async =>
      (await _api.restaurantUpdateProfile(xRestaurantId: rid, updateProfileDto: dto)).data!;

  @override
  Future<List<GeocodeResultDto>> geocode(String query) async => (await _api.restaurantGeocode(q: query)).data ?? const [];

  @override
  Future<List<OpeningHoursDto>> setOpeningHours(String rid, List<OpeningHoursItemDto> items) async =>
      (await _api.restaurantOpeningHours(
        xRestaurantId: rid,
        replaceOpeningHoursDto: ReplaceOpeningHoursDto(items: items),
      )).data ??
      const [];

  @override
  Future<ChecklistDto> checklist(String rid) async => (await _api.restaurantChecklist(xRestaurantId: rid)).data!;

  @override
  Future<RestaurantProfileDto> submit(String rid) async => (await _api.restaurantSubmit(xRestaurantId: rid)).data!;

  @override
  Future<RestaurantProfileDto> updateSettings(String rid, UpdateSettingsDto dto) async =>
      (await _api.restaurantUpdateSettings(xRestaurantId: rid, updateSettingsDto: dto)).data!;
}

final onboardingRepositoryProvider = Provider<OnboardingRepository>(
  (ref) => ApiOnboardingRepository(ref.watch(apiProvider).getRestaurantApi()),
);

final profileProvider = FutureProvider.autoDispose<RestaurantProfileDto>(
  (ref) => ref.watch(onboardingRepositoryProvider).profile(ref.watch(restaurantIdProvider)),
);

final checklistProvider = FutureProvider.autoDispose<ChecklistDto>(
  (ref) => ref.watch(onboardingRepositoryProvider).checklist(ref.watch(restaurantIdProvider)),
);

/// Launch provinces first (§ launch district open decision); code = official province code.
const provinces = [('79', 'TP. Hồ Chí Minh'), ('01', 'Hà Nội'), ('48', 'Đà Nẵng'), ('31', 'Hải Phòng'), ('92', 'Cần Thơ')];

const cuisineOptions = ['cơm văn phòng', 'bún / phở', 'quán nhậu', 'lẩu', 'nướng', 'hải sản', 'chay', 'cà phê', 'món Hàn', 'món Nhật'];

String priceLevelLabel(int level) => switch (level) {
  1 => 'Dưới 60k/người',
  2 => '60k–150k/người',
  3 => '150k–400k/người',
  _ => 'Trên 400k/người',
};
