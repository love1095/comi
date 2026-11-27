import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:uuid/uuid.dart';

import '../../data/api_error.dart';
import '../../data/session.dart';
import '../cart/cart.dart';
import '../discovery/discovery_repository.dart';
import 'bookings_repository.dart';
import 'table_picker_screen.dart';

typedef SlotQuery = ({String restaurantId, String date, int partySize});

final slotsProvider = FutureProvider.autoDispose.family<List<SlotDto>, SlotQuery>(
  (ref, q) => ref.watch(discoveryRepositoryProvider).availability(q.restaurantId, q.date, q.partySize),
);

/// Choose day, party size and time; review the pre-order; confirm (pay at the restaurant for now, §8.2).
class BookingScreen extends ConsumerWidget {
  const BookingScreen({super.key, required this.slug});
  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) => ref
      .watch(restaurantProvider(slug))
      .when(
        loading: () => Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Scaffold(
          appBar: AppBar(),
          body: Center(child: Text(ApiError.from(e).userMessage)),
        ),
        data: (r) => _BookingForm(restaurant: r),
      );
}

class _BookingForm extends ConsumerStatefulWidget {
  const _BookingForm({required this.restaurant});
  final RestaurantDetailDto restaurant;

  @override
  ConsumerState<_BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends ConsumerState<_BookingForm> {
  late String _date = vietnamDate();
  var _party = 2;
  SlotDto? _slotValue;
  HeldTables? _held;

  /// Changing the time (or party size, which clears it) drops a table hold made for the old time.
  SlotDto? get _slot => _slotValue;
  set _slot(SlotDto? v) {
    if (v?.time != _slotValue?.time) _held = null;
    _slotValue = v;
  }

  var _serveStyle = CreateBookingDtoServeStyleEnum.BY_COURSE;
  var _ageConfirmed = false;
  final _note = TextEditingController();

  /// One key per checkout: a retry after a network drop returns the same booking (§8.2).
  final _idempotencyKey = const Uuid().v4();
  var _submitting = false;

  RestaurantDetailDto get r => widget.restaurant;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  List<String> get _days => [for (var i = 0; i < 14; i++) vietnamDate(days: i)];

  static String dayChip(String date, int index) {
    final d = DateTime.parse(date);
    const names = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
    final label = index == 0
        ? 'Hôm nay'
        : index == 1
        ? 'Mai'
        : names[d.weekday - 1];
    return '$label\n${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';
  }

  Future<void> _confirm(CartState cart) async {
    final slot = _slot;
    if (slot == null) return;
    final session = await ref.read(sessionProvider.future);
    if (!mounted) return;
    if (!session.loggedIn) {
      final ok = await context.push<bool>('/login');
      if (ok != true || !mounted) return;
    }
    setState(() => _submitting = true);
    try {
      final b = await ref
          .read(bookingsRepositoryProvider)
          .create(
            CreateBookingDto(
              restaurantId: r.id,
              arrivalAt: slot.time,
              holdId: _held != null && _held!.expiresAt.isAfter(DateTime.now()) ? _held!.holdId : null,
              partySize: _party,
              paymentMode: CreateBookingDtoPaymentModeEnum.COD,
              serveStyle: cart.isEmpty ? null : _serveStyle,
              note: _note.text.trim().isEmpty ? null : _note.text.trim(),
              ageConfirmed: cart.hasAlcohol ? _ageConfirmed : null,
              items: cart.isEmpty ? null : [for (final l in cart.lines) l.toDto()],
            ),
            idempotencyKey: _idempotencyKey,
          );
      ref.read(cartProvider.notifier).clear();
      ref.invalidate(myBookingsProvider);
      if (mounted) context.go('/bookings/${b.id}?new=1');
    } catch (e) {
      final err = ApiError.from(e);
      if (!mounted) return;
      if (err.code == 'SLOT_TAKEN' || err.code == 'SLOT_INVALID') {
        setState(() => _slot = null);
        ref.invalidate(slotsProvider);
      }
      if (err.code == 'HOLD_INVALID' || err.code == 'TABLE_TAKEN') setState(() => _held = null);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.userMessage)));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartAll = ref.watch(cartProvider);
    final cart = cartAll.restaurantId == r.id ? cartAll : const CartState();
    final slots = ref.watch(slotsProvider((restaurantId: r.id, date: _date, partySize: _party)));
    final bigGroup = _party > r.confirmGroupsOver;
    final blocked = _slot == null || (cart.hasAlcohol && !_ageConfirmed) || _submitting;

    return Scaffold(
      appBar: AppBar(title: Text('Đặt bàn · ${r.name}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Ngày', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          SizedBox(
            height: 64,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final (i, d) in _days.indexed)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(dayChip(d, i), textAlign: TextAlign.center),
                      selected: d == _date,
                      onSelected: (_) => setState(() {
                        _date = d;
                        _slot = null;
                      }),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Text('Số người', style: theme.textTheme.titleMedium)),
              IconButton.outlined(
                tooltip: 'Bớt người',
                onPressed: _party > 1
                    ? () => setState(() {
                        _party--;
                        _slot = null;
                      })
                    : null,
                icon: const Icon(Icons.remove),
              ),
              SizedBox(
                width: 48,
                child: Text('$_party', textAlign: TextAlign.center, style: theme.textTheme.titleLarge),
              ),
              IconButton.outlined(
                tooltip: 'Thêm người',
                onPressed: _party < r.maxGroupSize
                    ? () => setState(() {
                        _party++;
                        _slot = null;
                      })
                    : null,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          if (bigGroup)
            Card(
              color: ComiColors.held.withValues(alpha: 0.15),
              child: ListTile(
                leading: const Icon(Icons.groups),
                title: Text('Nhóm trên ${r.confirmGroupsOver} người'),
                subtitle: const Text('Quán sẽ xác nhận trong vòng 2 giờ. Bạn sẽ nhận thông báo.'),
              ),
            ),
          const SizedBox(height: 16),
          Text('Giờ đến', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          slots.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Text(ApiError.from(e).userMessage, style: TextStyle(color: theme.colorScheme.error)),
            data: (list) {
              final open = list.where((s) => s.available).toList();
              if (list.isEmpty) return const Text('Quán không nhận đặt ngày này');
              if (open.isEmpty) return const Text('Hết bàn cho số người này — thử ngày khác hoặc bớt người');
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final s in list)
                    ChoiceChip(
                      label: Text(s.local),
                      selected: _slot?.time == s.time,
                      onSelected: s.available ? (_) => setState(() => _slot = s) : null,
                    ),
                ],
              );
            },
          ),
          if (_slot != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Giữ bàn khoảng ${_slot!.diningMinutes} phút', style: theme.textTheme.bodySmall),
            ),
          if (_slot != null && r.allowTableChoice)
            Card(
              margin: const EdgeInsets.only(top: 12),
              child: ListTile(
                leading: const Icon(Icons.table_restaurant_outlined),
                title: Text(_held == null ? 'Chọn bàn trên sơ đồ' : 'Bàn ${_held!.codes.join(' + ')}'),
                subtitle: Text(
                  _held == null
                      ? 'Không bắt buộc — quán sẽ xếp bàn phù hợp'
                      : 'Giữ đến ${formatLocalTime(_held!.expiresAt)} — đặt trước giờ này',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  final held = await Navigator.of(context).push<HeldTables>(
                    MaterialPageRoute(
                      builder: (_) =>
                          TablePickerScreen(restaurantId: r.id, arrivalAt: _slot!.time, partySize: _party, slotLabel: _slot!.local),
                    ),
                  );
                  if (held != null && mounted) setState(() => _held = held);
                },
              ),
            ),
          const Divider(height: 32),
          Row(
            children: [
              Expanded(
                child: Text(cart.isEmpty ? 'Chưa chọn món trước' : 'Món đặt trước (${cart.count})', style: theme.textTheme.titleMedium),
              ),
              TextButton(onPressed: () => context.pop(), child: Text(cart.isEmpty ? 'Chọn món' : 'Thêm món')),
            ],
          ),
          if (cart.isEmpty) Text('Không bắt buộc. Đặt món trước để vừa ngồi là có đồ ăn.', style: theme.textTheme.bodySmall),
          for (final MapEntry(key: course, value: lines) in cart.byCourse.entries) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Text(courseName(course), style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary)),
            ),
            for (final l in lines) _CartRow(line: l),
          ],
          if (!cart.isEmpty) ...[
            const SizedBox(height: 8),
            SegmentedButton<CreateBookingDtoServeStyleEnum>(
              segments: const [
                ButtonSegment(value: CreateBookingDtoServeStyleEnum.BY_COURSE, label: Text('Lên theo thứ tự')),
                ButtonSegment(value: CreateBookingDtoServeStyleEnum.ALL_TOGETHER, label: Text('Lên cùng lúc')),
              ],
              selected: {_serveStyle},
              onSelectionChanged: (s) => setState(() => _serveStyle = s.first),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Expanded(child: Text('Tạm tính', style: theme.textTheme.titleMedium)),
                  Text(formatVnd(cart.total), style: theme.textTheme.titleMedium),
                ],
              ),
            ),
          ],
          if (cart.hasAlcohol)
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _ageConfirmed,
              onChanged: (v) => setState(() => _ageConfirmed = v!),
              title: const Text('Tôi đủ 18 tuổi'),
              subtitle: const Text('Đơn có đồ uống có cồn. Quán có thể kiểm tra giấy tờ.'),
            ),
          const Divider(height: 32),
          TextField(
            controller: _note,
            maxLength: 500,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Ghi chú cho quán',
              hintText: 'Có em bé, cần ghế cao…',
              border: OutlineInputBorder(),
            ),
          ),
          Text('Thanh toán', style: theme.textTheme.titleMedium),
          const ListTile(
            leading: Icon(Icons.radio_button_checked),
            contentPadding: EdgeInsets.zero,
            title: Text('Trả tại quán'),
            subtitle: Text('Tiền mặt hoặc chuyển khoản khi ăn xong'),
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            enabled: false,
            leading: Icon(Icons.lock_clock),
            title: Text('Trả trước online (MoMo, VNPay…)'),
            subtitle: Text('Sắp có'),
          ),
          Text('Huỷ miễn phí trước giờ đến ${r.cancelCutoffMinutes} phút.', style: theme.textTheme.bodySmall),
          const SizedBox(height: 80),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
            onPressed: blocked ? null : () => _confirm(cart),
            child: Text(
              _submitting
                  ? 'Đang đặt…'
                  : _slot == null
                  ? 'Chọn giờ đến'
                  : 'Đặt bàn ${_slot!.local} · $_party người${cart.isEmpty ? '' : ' · ${formatVnd(cart.total)}'}',
            ),
          ),
        ),
      ),
    );
  }
}

class _CartRow extends ConsumerWidget {
  const _CartRow({required this.line});
  final CartLine line;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final extras = [...line.options.map((o) => o.name), if (line.note != null) '“${line.note}”'];
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(line.item.name),
              if (extras.isNotEmpty) Text(extras.join(' · '), style: theme.textTheme.bodySmall),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Bớt',
          visualDensity: VisualDensity.compact,
          onPressed: () => ref.read(cartProvider.notifier).setQuantity(line.key, line.quantity - 1),
          icon: const Icon(Icons.remove_circle_outline),
        ),
        Text('${line.quantity}'),
        IconButton(
          tooltip: 'Thêm',
          visualDensity: VisualDensity.compact,
          onPressed: () => ref.read(cartProvider.notifier).setQuantity(line.key, line.quantity + 1),
          icon: const Icon(Icons.add_circle_outline),
        ),
        SizedBox(width: 88, child: Text(formatVnd(line.total), textAlign: TextAlign.right)),
      ],
    );
  }
}
