import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/session.dart';

/// Thin wrapper so screens can be tested with a fake.
abstract class TablesRepository {
  Future<List<AreaSummaryDto>> listAreas();
  Future<AreaSummaryDto> createArea({required String name, int? cols, int? rows, int? floor});
  Future<AreaLayoutDto> getLayout(String areaId);
  Future<AreaLayoutDto> saveLayout(String areaId, SaveLayoutDto dto);
}

class ApiTablesRepository implements TablesRepository {
  ApiTablesRepository(this._api, this._restaurantId);
  final RestaurantTablesApi _api;
  final String _restaurantId;

  @override
  Future<List<AreaSummaryDto>> listAreas() async => (await _api.tablesListAreas(xRestaurantId: _restaurantId)).data ?? const [];

  @override
  Future<AreaSummaryDto> createArea({required String name, int? cols, int? rows, int? floor}) async => (await _api.tablesCreateArea(
    xRestaurantId: _restaurantId,
    areaDto: AreaDto(name: name, gridCols: cols, gridRows: rows, floor: floor),
  )).data!;

  @override
  Future<AreaLayoutDto> getLayout(String areaId) async => (await _api.tablesGetLayout(id: areaId, xRestaurantId: _restaurantId)).data!;

  @override
  Future<AreaLayoutDto> saveLayout(String areaId, SaveLayoutDto dto) async =>
      (await _api.tablesSaveLayout(id: areaId, xRestaurantId: _restaurantId, saveLayoutDto: dto)).data!;
}

final tablesRepositoryProvider = Provider<TablesRepository>(
  (ref) => ApiTablesRepository(ref.watch(apiProvider).getRestaurantTablesApi(), ref.watch(restaurantIdProvider)),
);

final areasProvider = FutureProvider.autoDispose<List<AreaSummaryDto>>((ref) async {
  final areas = await ref.watch(tablesRepositoryProvider).listAreas();
  return [...areas]..sort((a, b) => a.floor != b.floor ? a.floor.compareTo(b.floor) : a.sortOrder.compareTo(b.sortOrder));
});
