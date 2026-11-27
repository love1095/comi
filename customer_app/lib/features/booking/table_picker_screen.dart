import 'dart:async';

import 'package:comi_api/comi_api.dart' as api;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../../data/session.dart';

/// Table map + 5-minute holds (§8.6), like picking an airline seat.
abstract class TableHoldRepository {
  Future<api.TableMapDto> tableMap(String restaurantId, {required String arrivalAt, required int partySize, String? areaId});
  Future<api.HoldDto> hold(String restaurantId, {required List<String> tableIds, required String arrivalAt, required int partySize});
  Future<void> release(String holdId);
}

class ApiTableHoldRepository implements TableHoldRepository {
  ApiTableHoldRepository(this._api);
  final api.CustomerAvailabilityApi _api;

  @override
  Future<api.TableMapDto> tableMap(String restaurantId, {required String arrivalAt, required int partySize, String? areaId}) async =>
      (await _api.availabilityTableMap(id: restaurantId, arrivalAt: arrivalAt, partySize: partySize, areaId: areaId)).data!;

  @override
  Future<api.HoldDto> hold(
    String restaurantId, {
    required List<String> tableIds,
    required String arrivalAt,
    required int partySize,
  }) async => (await _api.availabilityHold(
    id: restaurantId,
    createHoldDto: api.CreateHoldDto(tableIds: tableIds, arrivalAt: arrivalAt, partySize: partySize),
  )).data!;

  @override
  Future<void> release(String holdId) => _api.availabilityRelease(holdId: holdId);
}

final tableHoldRepositoryProvider = Provider<TableHoldRepository>(
  (ref) => ApiTableHoldRepository(ref.watch(apiProvider).getCustomerAvailabilityApi()),
);

/// What the picker hands back to the booking form.
class HeldTables {
  const HeldTables({required this.holdId, required this.codes, required this.expiresAt});
  final String holdId;
  final List<String> codes;
  final DateTime expiresAt;
}

MapTableState stateFromApi(api.MapTableStateDtoStateEnum s) => switch (s) {
  api.MapTableStateDtoStateEnum.available => MapTableState.available,
  api.MapTableStateDtoStateEnum.booked => MapTableState.booked,
  api.MapTableStateDtoStateEnum.held => MapTableState.held,
  api.MapTableStateDtoStateEnum.mine => MapTableState.mine,
  api.MapTableStateDtoStateEnum.unfit => MapTableState.unfit,
  api.MapTableStateDtoStateEnum.unavailable => MapTableState.unavailable,
};

TableShape _shape(api.TableShape s) => switch (s) {
  api.TableShape.RECT => TableShape.rect,
  api.TableShape.ROUND => TableShape.round,
  api.TableShape.SQUARE => TableShape.square,
  api.TableShape.BOOTH => TableShape.booth,
  api.TableShape.BAR_SEAT => TableShape.barSeat,
};

MapElementKind? _element(api.MapElementType t) {
  final name = t.value.toLowerCase().replaceAllMapped(RegExp('_([a-z])'), (m) => m[1]!.toUpperCase());
  return MapElementKind.values.where((k) => k.name == name).firstOrNull;
}

/// `4:59`.
String countdown(Duration d) {
  final s = d.isNegative ? 0 : d.inSeconds;
  return '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';
}

/// Tables that seat the party together: one table, or tables of the same join group.
bool selectionFits(List<api.MapTableStateDto> chosen, int party) {
  if (chosen.isEmpty) return false;
  if (chosen.length == 1) return party >= chosen.first.minSeats && party <= chosen.first.maxSeats;
  final group = chosen.first.joinGroup;
  if (group == null || chosen.any((t) => t.joinGroup != group)) return false;
  return chosen.fold<num>(0, (s, t) => s + t.maxSeats) >= party;
}

class TablePickerScreen extends ConsumerStatefulWidget {
  const TablePickerScreen({super.key, required this.restaurantId, required this.arrivalAt, required this.partySize, this.slotLabel});
  final String restaurantId;
  final String arrivalAt;
  final int partySize;
  final String? slotLabel;

  @override
  ConsumerState<TablePickerScreen> createState() => _TablePickerScreenState();
}

class _TablePickerScreenState extends ConsumerState<TablePickerScreen> {
  api.TableMapDto? _map;
  String? _areaId;
  final _selected = <String>{};
  api.HoldDto? _hold;
  Object? _error;
  var _busy = false;
  Timer? _tick;

  TableHoldRepository get _repo => ref.read(tableHoldRepositoryProvider);

  @override
  void initState() {
    super.initState();
    _load();
    _tick = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_hold != null && mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  Duration get _left => _hold == null ? Duration.zero : DateTime.parse(_hold!.expiresAt).difference(DateTime.now());

  Future<void> _load() async {
    setState(() => _error = null);
    try {
      final m = await _repo.tableMap(widget.restaurantId, arrivalAt: widget.arrivalAt, partySize: widget.partySize, areaId: _areaId);
      if (!mounted) return;
      setState(() {
        _map = m;
        _areaId = m.area.id;
        _selected.removeWhere((id) => !m.tables.any((t) => t.id == id && t.state == api.MapTableStateDtoStateEnum.available));
      });
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  void _tap(MapTable t) {
    if (t.state != MapTableState.available && t.state != MapTableState.mine) {
      final msg = switch (t.state) {
        MapTableState.booked => 'Bàn ${t.code} đã có người đặt giờ này',
        MapTableState.held => 'Bàn ${t.code} đang được người khác giữ',
        MapTableState.unfit => 'Bàn ${t.code} có ${t.minSeats}–${t.maxSeats} chỗ, không hợp ${widget.partySize} người',
        _ => 'Bàn ${t.code} không nhận chọn trước',
      };
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      return;
    }
    setState(() => _selected.contains(t.id) ? _selected.remove(t.id) : _selected.add(t.id));
  }

  Future<void> _holdSelected() async {
    final session = await ref.read(sessionProvider.future);
    if (!mounted) return;
    if (!session.loggedIn) {
      final ok = await context.push<bool>('/login');
      if (ok != true || !mounted) return;
    }
    setState(() => _busy = true);
    try {
      final h = await _repo.hold(
        widget.restaurantId,
        tableIds: _selected.toList(),
        arrivalAt: widget.arrivalAt,
        partySize: widget.partySize,
      );
      if (mounted) setState(() => _hold = h);
      await _load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ApiError.from(e).userMessage)));
      await _load();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _use() {
    final h = _hold!;
    final codes = [
      for (final t in _map!.tables)
        if (h.tableIds.contains(t.id)) t.code,
    ];
    Navigator.pop(context, HeldTables(holdId: h.holdId, codes: codes, expiresAt: DateTime.parse(h.expiresAt)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = _map;
    final held = _hold != null && _left > Duration.zero;
    final chosen = [
      if (m != null)
        for (final t in m.tables)
          if (_selected.contains(t.id)) t,
    ];
    final fits = selectionFits(chosen, widget.partySize);

    return Scaffold(
      appBar: AppBar(title: Text('Chọn bàn${widget.slotLabel == null ? '' : ' · ${widget.slotLabel}'} · ${widget.partySize} người')),
      body: m == null
          ? Center(
              child: _error == null
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(ApiError.from(_error!).userMessage),
                        TextButton(onPressed: _load, child: const Text('Thử lại')),
                      ],
                    ),
            )
          : Column(
              children: [
                if (m.areas.length > 1)
                  SizedBox(
                    height: 52,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                      children: [
                        for (final a in m.areas)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(a.name),
                              selected: a.id == _areaId,
                              onSelected: (_) {
                                setState(() => _areaId = a.id);
                                _load();
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: _Legend()),
                Expanded(
                  child: InteractiveViewer(
                    maxScale: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: TableMap(
                        cols: m.area.gridCols.toInt(),
                        rows: m.area.gridRows.toInt(),
                        tables: [
                          for (final t in m.tables)
                            if (t.posX != null && t.posY != null)
                              MapTable(
                                id: t.id,
                                code: t.code,
                                minSeats: t.minSeats.toInt(),
                                maxSeats: t.maxSeats.toInt(),
                                x: t.posX!.toInt(),
                                y: t.posY!.toInt(),
                                width: t.width.toInt(),
                                height: t.height.toInt(),
                                rotation: t.rotation.toInt(),
                                shape: _shape(t.shape),
                                features: t.features,
                                joinGroup: t.joinGroup,
                                selectable: t.isSelectable,
                                state: stateFromApi(t.state),
                              ),
                        ],
                        elements: [
                          for (final e in m.area.elements)
                            if (_element(e.type) case final kind?)
                              MapElement(
                                kind: kind,
                                x: e.x.toInt(),
                                y: e.y.toInt(),
                                width: e.width.toInt(),
                                height: e.height.toInt(),
                                rotation: e.rotation.toInt(),
                                label: e.label,
                              ),
                        ],
                        selectedIds: held ? {} : _selected,
                        onTableTap: held ? null : _tap,
                      ),
                    ),
                  ),
                ),
                if (chosen.isNotEmpty && !fits && !held)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      chosen.length > 1
                          ? 'Chỉ ghép được các bàn cùng nhóm, đủ chỗ cho ${widget.partySize} người'
                          : 'Bàn này không vừa ${widget.partySize} người',
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ),
              ],
            ),
      bottomNavigationBar: m == null
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: held
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Đang giữ bàn — còn ${countdown(_left)}', style: theme.textTheme.titleSmall),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () async {
                                    await _repo.release(_hold!.holdId).catchError((_) {});
                                    setState(() => _hold = null);
                                    _load();
                                  },
                                  child: const Text('Chọn lại'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: FilledButton(
                                  style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                                  onPressed: _use,
                                  child: const Text('Dùng bàn này'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : FilledButton(
                        style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                        onPressed: fits && !_busy ? _holdSelected : null,
                        child: Text(
                          _busy
                              ? 'Đang giữ bàn…'
                              : chosen.isEmpty
                              ? 'Chạm vào bàn trống để chọn'
                              : 'Giữ bàn ${chosen.map((t) => t.code).join(' + ')} trong 5 phút',
                        ),
                      ),
              ),
            ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    Widget dot(Color c, String label) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
    return Wrap(
      spacing: 12,
      runSpacing: 4,
      children: [
        dot(TableTile.colorFor(MapTableState.available, scheme), 'Trống'),
        dot(ComiColors.selected, 'Đang chọn'),
        dot(TableTile.colorFor(MapTableState.held, scheme), 'Người khác giữ'),
        dot(TableTile.colorFor(MapTableState.booked, scheme), 'Đã đặt'),
        dot(TableTile.colorFor(MapTableState.unfit, scheme), 'Không vừa'),
      ],
    );
  }
}
