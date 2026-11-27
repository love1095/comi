import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../../widgets/restaurant_card.dart';
import '../cart/cart.dart';
import '../discovery/discovery_repository.dart';
import 'item_sheet.dart';
import '../booking/at_table.dart' show sendTableOrder;

const _weekdayShort = {1: 'T2', 2: 'T3', 3: 'T4', 4: 'T5', 5: 'T6', 6: 'T7', 0: 'CN'};

/// `T2–T6 10:00–14:00, 17:00–22:00 · T7, CN 10:00–23:00` (days with identical hours are merged).
String hoursSummary(List<OpeningHoursDto> hours) {
  if (hours.isEmpty) return 'Chưa có giờ mở cửa';
  final byDay = <int, String>{};
  for (final d in [1, 2, 3, 4, 5, 6, 0]) {
    final ranges = hours
        .where((h) => h.weekday == d)
        .map((h) => '${formatMinute(h.openMinute.toInt())}–${formatMinute(h.closeMinute.toInt())}')
        .join(', ');
    byDay[d] = ranges.isEmpty ? 'nghỉ' : ranges;
  }
  final groups = <(List<int>, String)>[];
  for (final d in [1, 2, 3, 4, 5, 6, 0]) {
    if (groups.isNotEmpty && groups.last.$2 == byDay[d]) {
      groups.last.$1.add(d);
    } else {
      groups.add(([d], byDay[d]!));
    }
  }
  String days(List<int> ds) =>
      ds.length > 2 ? '${_weekdayShort[ds.first]}–${_weekdayShort[ds.last]}' : ds.map((d) => _weekdayShort[d]).join(', ');
  return groups.map((g) => '${days(g.$1)} ${g.$2}').join(' · ');
}

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key, required this.slug, this.tableBookingId});
  final String slug;

  /// Set when a seated guest orders more (§8.5): the cart goes to the kitchen, not to a new booking.
  final String? tableBookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(restaurantProvider(slug));
    return detail.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(ApiError.from(e).userMessage),
              TextButton(onPressed: () => ref.invalidate(restaurantProvider(slug)), child: const Text('Thử lại')),
            ],
          ),
        ),
      ),
      data: (r) => _RestaurantBody(restaurant: r, tableBookingId: tableBookingId),
    );
  }
}

class _RestaurantBody extends ConsumerWidget {
  const _RestaurantBody({required this.restaurant, this.tableBookingId});
  final RestaurantDetailDto restaurant;
  final String? tableBookingId;

  bool get _atTable => tableBookingId != null;

  RestaurantRef get _ref => (id: restaurant.id, slug: restaurant.slug, name: restaurant.name);

  Future<void> _add(BuildContext context, WidgetRef ref, PublicMenuItemDto item) async {
    final cart = ref.read(cartProvider.notifier);
    if (cart.belongsToOther(restaurant.id)) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Đổi quán?'),
          content: Text('Giỏ đang có món của ${ref.read(cartProvider).restaurantName}. Bỏ giỏ cũ để đặt quán này?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Giữ giỏ cũ')),
            FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Đặt quán này')),
          ],
        ),
      );
      if (ok != true || !context.mounted) return;
    }
    if (item.optionGroups.isEmpty) {
      cart.add(_ref, CartLine(item: item, quantity: 1));
      return;
    }
    final line = await showModalBottomSheet<CartLine>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ItemSheet(item: item),
    );
    if (line != null) cart.add(_ref, line);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final r = restaurant;
    final menu = ref.watch(menuProvider(r.id));
    final cart = ref.watch(cartProvider);
    final myCart = cart.restaurantId == r.id ? cart : const CartState();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: r.coverPhotoUrl == null ? null : 220,
            title: Text(r.name),
            flexibleSpace: r.coverPhotoUrl == null
                ? null
                : FlexibleSpaceBar(
                    background: CoverImage(url: r.coverPhotoUrl, radius: 0, aspectRatio: 16 / 9),
                  ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r.name, style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text(
                    [
                      if (r.ratingCount > 0) '★ ${r.ratingAvg.toStringAsFixed(1).replaceAll('.', ',')} (${r.ratingCount})',
                      '₫' * r.priceLevel.toInt(),
                      ...r.cuisineTags.take(3),
                    ].join(' · '),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.circle, size: 10, color: r.isOpenNow ? Colors.green : theme.colorScheme.outline),
                      const SizedBox(width: 6),
                      Text(r.isOpenNow ? 'Đang mở' : 'Đang đóng', style: theme.textTheme.labelLarge),
                    ],
                  ),
                  Text(hoursSummary(r.openingHours), style: theme.textTheme.bodySmall),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.place_outlined, size: 18),
                      const SizedBox(width: 6),
                      Expanded(child: Text(r.address)),
                    ],
                  ),
                  for (final c in r.closures)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Nghỉ ${_dm(c.startsAt)}–${_dm(c.endsAt)}${c.reason == null ? '' : ': ${c.reason}'}',
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ),
                  if (r.description != null) ...[const SizedBox(height: 12), Text(r.description!)],
                  const SizedBox(height: 16),
                  if (_atTable)
                    Card(
                      color: theme.colorScheme.primaryContainer,
                      child: const ListTile(
                        leading: Icon(Icons.table_restaurant),
                        title: Text('Gọi thêm món cho bàn của bạn'),
                        subtitle: Text('Món gửi thẳng vào bếp, tính vào hoá đơn của bàn.'),
                      ),
                    )
                  else ...[
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () => context.push('/r/${r.slug}/book'),
                            icon: const Icon(Icons.event_seat_outlined),
                            label: const Text('Đặt bàn'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Chọn món trước để vừa đến là có đồ ăn — hoặc chỉ đặt bàn.', style: theme.textTheme.bodySmall),
                  ],
                ],
              ),
            ),
          ),
          ...menu.when(
            loading: () => [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
            error: (e, _) => [
              SliverToBoxAdapter(
                child: Padding(padding: const EdgeInsets.all(16), child: Text(ApiError.from(e).userMessage)),
              ),
            ],
            data: (cats) => [
              for (final c in cats) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: Text(c.name, style: theme.textTheme.titleLarge),
                  ),
                ),
                SliverList.separated(
                  itemCount: c.items.length,
                  separatorBuilder: (_, _) => const Divider(height: 1, indent: 16, endIndent: 16),
                  itemBuilder: (_, i) => DishCard(
                    item: c.items[i],
                    quantity: myCart.quantityOf(c.items[i].id),
                    atTable: _atTable,
                    onAdd: () => _add(context, ref, c.items[i]),
                    onRemove: () => ref.read(cartProvider.notifier).removeOne(c.items[i].id),
                  ),
                ),
              ],
              const SliverToBoxAdapter(child: SizedBox(height: 96)),
            ],
          ),
        ],
      ),
      bottomNavigationBar: myCart.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: FilledButton(
                  style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                  onPressed: () async {
                    if (!_atTable) {
                      context.push('/r/${r.slug}/book');
                    } else if (await sendTableOrder(context, ref, tableBookingId!) && context.mounted) {
                      Navigator.of(context).maybePop();
                    }
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: theme.colorScheme.onPrimary,
                        child: Text('${myCart.count}', style: TextStyle(color: theme.colorScheme.primary, fontSize: 13)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(_atTable ? 'Gửi món vào bếp' : 'Đặt bàn với món đã chọn')),
                      Text(formatVnd(myCart.total)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  static String _dm(String iso) {
    final t = toVietnamTime(DateTime.parse(iso));
    return '${t.day}/${t.month}';
  }
}

/// Dish with a big 4:3 photo when there is one (§16 — food sells by photo).
class DishCard extends StatelessWidget {
  const DishCard({
    super.key,
    required this.item,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    this.atTable = false,
  });
  final bool atTable;
  final PublicMenuItemDto item;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canOrder = item.isAvailable && (item.isPreorderable || atTable);
    final url = item.photos.isEmpty ? null : photoUrl(item.photos.first.publicId, width: 900);
    final note = [
      if (!item.isAvailable) 'Hết món hôm nay',
      if (item.isAvailable && !item.isPreorderable && !atTable) 'Gọi khi đến quán',
      if (item.leadHours > 0) 'Đặt trước ${item.leadHours} giờ',
      if (item.isAlcohol) '18+',
      ...item.tags,
    ];

    return Opacity(
      opacity: item.isAvailable ? 1 : 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (url != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => ColoredBox(color: theme.colorScheme.surfaceContainerHighest),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name, style: theme.textTheme.titleMedium),
                      if (item.translated != PublicMenuItemDtoTranslatedEnum.none)
                        Text(item.originalName, style: theme.textTheme.bodySmall),
                      if (item.description != null)
                        Text(item.description!, style: theme.textTheme.bodySmall, maxLines: 3, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(formatVnd(item.price), style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.primary)),
                      if (note.isNotEmpty)
                        Text(note.join(' · '), style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline)),
                    ],
                  ),
                ),
                if (canOrder)
                  quantity == 0
                      ? IconButton.filled(tooltip: 'Thêm ${item.name}', onPressed: onAdd, icon: const Icon(Icons.add))
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton.outlined(tooltip: 'Bớt ${item.name}', onPressed: onRemove, icon: const Icon(Icons.remove)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text('$quantity', style: theme.textTheme.titleMedium),
                            ),
                            IconButton.filled(tooltip: 'Thêm ${item.name}', onPressed: onAdd, icon: const Icon(Icons.add)),
                          ],
                        ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
