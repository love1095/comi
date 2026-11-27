import 'package:comi_api/comi_api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/api_error.dart';
import '../../data/location.dart';
import '../../widgets/restaurant_card.dart';
import 'discovery_repository.dart';

/// Map tiles. Goong / own tiles in production (`--dart-define=MAP_TILE_URL=...`); OSM for development only.
const mapTileUrl = String.fromEnvironment('MAP_TILE_URL', defaultValue: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png');

/// Restaurant list with filter chips (§14), paging, and a map view.
class ListScreen extends ConsumerStatefulWidget {
  const ListScreen({super.key, required this.initial, this.title});
  final SearchFilters initial;
  final String? title;

  @override
  ConsumerState<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends ConsumerState<ListScreen> {
  late var _filters = widget.initial;
  final _items = <RestaurantCardDto>[];
  int? _next;
  var _loading = false;
  var _showMap = false;
  Object? _error;
  var _generation = 0;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    final gen = ++_generation;
    setState(() {
      _items.clear();
      _next = null;
      _error = null;
    });
    await _load(gen);
  }

  Future<void> _load(int gen, {int? cursor}) async {
    setState(() => _loading = true);
    try {
      final at = await ref.read(locationProvider.future);
      final page = await ref.read(discoveryRepositoryProvider).nearby(at, _filters, cursor: cursor);
      if (!mounted || gen != _generation) return;
      setState(() {
        _items.addAll(page.items);
        _next = page.nextCursor?.toInt();
      });
    } catch (e) {
      if (mounted && gen == _generation) setState(() => _error = e);
    } finally {
      if (mounted && gen == _generation) setState(() => _loading = false);
    }
  }

  void _set(SearchFilters f) {
    _filters = f;
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    final f = _filters;
    final chips = <(String, bool, SearchFilters Function())>[
      ('Cơm trưa', f.mode == 'lunch', () => f.mode == 'lunch' ? f.copyWith(clearMode: true) : f.copyWith(mode: 'lunch')),
      ('Quán nhậu', f.mode == 'nhau', () => f.mode == 'nhau' ? f.copyWith(clearMode: true) : f.copyWith(mode: 'nhau')),
      ('Dưới 60k', f.under60k, () => f.copyWith(under60k: !f.under60k)),
      ('Trong 500 m', f.within500m, () => f.copyWith(within500m: !f.within500m)),
      ('Nhóm 10+', f.groups10, () => f.copyWith(groups10: !f.groups10)),
      ('Đang mở', f.openNow, () => f.copyWith(openNow: !f.openNow)),
      ('Mở khuya', f.openLate, () => f.copyWith(openLate: !f.openLate)),
      ('Điểm cao', f.sortByRating, () => f.copyWith(sortByRating: !f.sortByRating)),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? (f.q == null ? 'Quán gần bạn' : '"${f.q}"')),
        actions: [
          IconButton(
            tooltip: _showMap ? 'Xem danh sách' : 'Xem bản đồ',
            onPressed: () => setState(() => _showMap = !_showMap),
            icon: Icon(_showMap ? Icons.list : Icons.map_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              children: [
                for (final (label, selected, next) in chips)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(label: Text(label), selected: selected, onSelected: (_) => _set(next())),
                  ),
              ],
            ),
          ),
          Expanded(child: _showMap ? _map() : _list()),
        ],
      ),
    );
  }

  Widget _list() {
    if (_error != null && _items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(ApiError.from(_error!).userMessage),
            TextButton(onPressed: _reload, child: const Text('Thử lại')),
          ],
        ),
      );
    }
    if (_items.isEmpty && _loading) return const Center(child: CircularProgressIndicator());
    if (_items.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text('Không có quán phù hợp. Thử bỏ bớt bộ lọc.', textAlign: TextAlign.center),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _reload,
      child: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          if (n.metrics.extentAfter < 400 && _next != null && !_loading) _load(_generation, cursor: _next);
          return false;
        },
        child: ListView.separated(
          itemCount: _items.length + (_next != null ? 1 : 0),
          separatorBuilder: (_, _) => const Divider(height: 1, indent: 140),
          itemBuilder: (_, i) => i == _items.length
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                )
              : RestaurantTile(restaurant: _items[i], onTap: () => context.push('/r/${_items[i].slug}')),
        ),
      ),
    );
  }

  Widget _map() {
    final at = ref.watch(locationProvider).value ?? fallbackLocation;
    final scheme = Theme.of(context).colorScheme;
    return FlutterMap(
      options: MapOptions(initialCenter: LatLng(at.lat, at.lng), initialZoom: 15),
      children: [
        TileLayer(urlTemplate: mapTileUrl, userAgentPackageName: 'vn.comi.customer_app'),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(at.lat, at.lng),
              width: 18,
              height: 18,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
              ),
            ),
            for (final r in _items)
              Marker(
                point: LatLng(r.lat.toDouble(), r.lng.toDouble()),
                width: 140,
                height: 40,
                child: GestureDetector(
                  onTap: () => context.push('/r/${r.slug}'),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: scheme.primary, borderRadius: BorderRadius.circular(16)),
                      child: Text(
                        r.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: scheme.onPrimary, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const RichAttributionWidget(attributions: [TextSourceAttribution('© OpenStreetMap')]),
      ],
    );
  }
}
