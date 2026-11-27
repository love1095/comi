import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/location.dart';
import '../../data/session.dart';

/// Filters for the restaurant list (§14). Chips map 1:1 to API query params.
class SearchFilters {
  const SearchFilters({
    this.q,
    this.mode,
    this.under60k = false,
    this.within500m = false,
    this.groups10 = false,
    this.openLate = false,
    this.openNow = false,
    this.sortByRating = false,
  });

  final String? q;
  final String? mode; // lunch | nhau
  final bool under60k;
  final bool within500m;
  final bool groups10;
  final bool openLate;
  final bool openNow;
  final bool sortByRating;

  SearchFilters copyWith({
    String? q,
    String? mode,
    bool clearMode = false,
    bool? under60k,
    bool? within500m,
    bool? groups10,
    bool? openLate,
    bool? openNow,
    bool? sortByRating,
  }) => SearchFilters(
    q: q ?? this.q,
    mode: clearMode ? null : (mode ?? this.mode),
    under60k: under60k ?? this.under60k,
    within500m: within500m ?? this.within500m,
    groups10: groups10 ?? this.groups10,
    openLate: openLate ?? this.openLate,
    openNow: openNow ?? this.openNow,
    sortByRating: sortByRating ?? this.sortByRating,
  );

  @override
  bool operator ==(Object other) =>
      other is SearchFilters &&
      other.q == q &&
      other.mode == mode &&
      other.under60k == under60k &&
      other.within500m == within500m &&
      other.groups10 == groups10 &&
      other.openLate == openLate &&
      other.openNow == openNow &&
      other.sortByRating == sortByRating;

  @override
  int get hashCode => Object.hash(q, mode, under60k, within500m, groups10, openLate, openNow, sortByRating);
}

abstract class DiscoveryRepository {
  Future<HomeDto> home(LatLngPoint at);
  Future<RestaurantPageDto> nearby(LatLngPoint at, SearchFilters f, {int? cursor});
  Future<SuggestDto> suggest(String q, LatLngPoint at);
  Future<RestaurantDetailDto> detail(String slug);
  Future<List<PublicMenuCategoryDto>> menu(String restaurantId);
  Future<List<SlotDto>> availability(String restaurantId, String date, int partySize);
  Future<List<MapPinDto>> pins(double minLng, double minLat, double maxLng, double maxLat);
}

class ApiDiscoveryRepository implements DiscoveryRepository {
  ApiDiscoveryRepository(this._api, this._availability, this._lang);
  final CustomerDiscoveryApi _api;
  final CustomerAvailabilityApi _availability;
  final String _lang;

  @override
  Future<HomeDto> home(LatLngPoint at) async => (await _api.discoveryHome(lat: at.lat, lng: at.lng, acceptLanguage: _lang)).data!;

  @override
  Future<RestaurantPageDto> nearby(LatLngPoint at, SearchFilters f, {int? cursor}) async => (await _api.discoveryNearby(
    lat: at.lat,
    lng: at.lng,
    acceptLanguage: _lang,
    radius: f.within500m ? 500 : null,
    q: f.q,
    mode: f.mode,
    maxMainPrice: f.under60k ? 60000 : null,
    groupSize: f.groups10 ? 10 : null,
    openLate: f.openLate ? true : null,
    openNow: f.openNow ? true : null,
    sort: f.sortByRating ? 'rating' : null,
    cursor: cursor,
  )).data!;

  @override
  Future<SuggestDto> suggest(String q, LatLngPoint at) async => (await _api.discoverySuggest(q: q, lat: at.lat, lng: at.lng)).data!;

  @override
  Future<RestaurantDetailDto> detail(String slug) async => (await _api.discoveryDetail(slug: slug, acceptLanguage: _lang)).data!;

  @override
  Future<List<PublicMenuCategoryDto>> menu(String restaurantId) async =>
      (await _api.discoveryMenu(id: restaurantId, acceptLanguage: _lang)).data ?? const [];

  @override
  Future<List<SlotDto>> availability(String restaurantId, String date, int partySize) async =>
      (await _availability.availabilityGet(id: restaurantId, date: date, partySize: partySize)).data ?? const [];

  @override
  Future<List<MapPinDto>> pins(double minLng, double minLat, double maxLng, double maxLat) async =>
      (await _api.discoveryMap(bbox: '$minLng,$minLat,$maxLng,$maxLat')).data ?? const [];
}

final discoveryRepositoryProvider = Provider<DiscoveryRepository>((ref) {
  final api = ref.watch(apiProvider);
  return ApiDiscoveryRepository(api.getCustomerDiscoveryApi(), api.getCustomerAvailabilityApi(), ref.watch(contentLocaleProvider));
});

final homeProvider = FutureProvider.autoDispose<HomeDto>((ref) async {
  final at = await ref.watch(locationProvider.future);
  return ref.watch(discoveryRepositoryProvider).home(at);
});

final restaurantProvider = FutureProvider.autoDispose.family<RestaurantDetailDto, String>(
  (ref, slug) => ref.watch(discoveryRepositoryProvider).detail(slug),
);

final menuProvider = FutureProvider.autoDispose.family<List<PublicMenuCategoryDto>, String>(
  (ref, restaurantId) => ref.watch(discoveryRepositoryProvider).menu(restaurantId),
);

/// Home section titles (keys from GET /home).
String sectionTitle(String key) => switch (key) {
  'lunch_near_you' => 'Cơm trưa gần bạn',
  'under_60k' => 'Dưới 60k',
  'tonight_groups' => 'Tối nay đi nhóm',
  'open_late' => 'Mở khuya',
  'top_rated' => 'Được khen nhiều',
  'menus_in_your_language' => 'Thực đơn có bản dịch',
  _ => key,
};

/// `350 m` / `1,2 km`.
String formatDistance(num meters) =>
    meters < 1000 ? '${meters.round()} m' : '${(meters / 1000).toStringAsFixed(1).replaceAll('.', ',')} km';
