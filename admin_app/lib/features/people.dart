import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../data/admin_repository.dart';
import '../data/api_error.dart';
import 'common.dart';

final userQueryProvider = NotifierProvider<_Query, String>(_Query.new);

class _Query extends Notifier<String> {
  @override
  String build() => '';
  void set(String q) => state = q;
}

final adminUsersProvider = FutureProvider.autoDispose<List<AdminUserDto>>((ref) {
  final q = ref.watch(userQueryProvider);
  return ref.watch(adminRepositoryProvider).users(q.isEmpty ? null : q);
});

/// Guests: search by phone / email / name, block, clear no-shows, see their bookings.
class UsersPage extends ConsumerStatefulWidget {
  const UsersPage({super.key});

  @override
  ConsumerState<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends ConsumerState<UsersPage> {
  final _q = TextEditingController();

  @override
  void dispose() {
    _q.dispose();
    super.dispose();
  }

  Future<void> _block(AdminUserDto u) async {
    final repo = ref.read(adminRepositoryProvider);
    if (u.status == AdminUserDtoStatusEnum.BLOCKED) {
      if (await runAction(context, () => repo.block(u.id, blocked: false), done: 'Đã mở khoá')) ref.invalidate(adminUsersProvider);
      return;
    }
    final reason = await askText(context, title: 'Khoá ${u.name ?? u.phone ?? 'khách'}?', label: 'Lý do (lưu trong nhật ký)', ok: 'Khoá');
    if (reason == null || !mounted) return;
    if (await runAction(context, () => repo.block(u.id, blocked: true, reason: reason), done: 'Đã khoá — khách bị đăng xuất')) {
      ref.invalidate(adminUsersProvider);
    }
  }

  Future<void> _resetNoShow(AdminUserDto u) async {
    if (!await confirm(context, 'Xoá số lần vắng mặt?', 'Khách sẽ không còn phải trả trước. Dùng khi khiếu nại được giải quyết.')) return;
    if (!mounted) return;
    if (await runAction(context, () => ref.read(adminRepositoryProvider).resetNoShow(u.id), done: 'Đã xoá số lần vắng mặt')) {
      ref.invalidate(adminUsersProvider);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const PageHeader('Khách'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: TextField(
          controller: _q,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Số điện thoại, email hoặc tên',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (v) => ref.read(userQueryProvider.notifier).set(v.trim()),
        ),
      ),
      const SizedBox(height: 8),
      Expanded(
        child: AsyncPage(
          value: ref.watch(adminUsersProvider),
          onRetry: () => ref.invalidate(adminUsersProvider),
          data: (rows) => rows.isEmpty
              ? const Center(child: Text('Không tìm thấy khách'))
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: rows.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final u = rows[i];
                    final blocked = u.status == AdminUserDtoStatusEnum.BLOCKED;
                    final deleted = u.status == AdminUserDtoStatusEnum.DELETED;
                    return ListTile(
                      leading: Icon(blocked ? Icons.block : (deleted ? Icons.person_off_outlined : Icons.person_outline)),
                      title: Text(u.name ?? (deleted ? '(đã xoá tài khoản)' : '(chưa có tên)')),
                      subtitle: Text(
                        [
                          u.phone,
                          u.email,
                          '${u.bookings} đơn',
                          if (u.noShowCount > 0) 'vắng ${u.noShowCount} lần',
                          if (u.mustPrepay) 'phải trả trước',
                          'từ ${date(u.createdAt)}',
                        ].whereType<String>().join(' · '),
                      ),
                      onTap: () => showDialog<void>(
                        context: context,
                        builder: (_) => BookingsDialog(title: u.name ?? u.phone ?? 'Khách', userId: u.id),
                      ),
                      trailing: deleted
                          ? null
                          : Wrap(
                              spacing: 4,
                              children: [
                                if (u.noShowCount > 0) TextButton(onPressed: () => _resetNoShow(u), child: const Text('Xoá vắng mặt')),
                                TextButton(onPressed: () => _block(u), child: Text(blocked ? 'Mở khoá' : 'Khoá')),
                              ],
                            ),
                    );
                  },
                ),
        ),
      ),
    ],
  );
}

const bookingStatusLabel = {
  'PENDING': 'Chờ xác nhận',
  'CONFIRMED': 'Đã xác nhận',
  'CHECKED_IN': 'Đang ở quán',
  'COMPLETED': 'Hoàn tất',
  'CANCELLED': 'Đã huỷ',
  'NO_SHOW': 'Vắng mặt',
  'EXPIRED': 'Hết hạn',
};

class BookingTile extends StatelessWidget {
  const BookingTile(this.b, {super.key});
  final AdminBookingDto b;

  @override
  Widget build(BuildContext context) => ListTile(
    title: Text('${b.code} · ${b.restaurantName}'),
    subtitle: Text(
      [
        dateTime(b.arrivalAt),
        '${b.partySize} người',
        bookingStatusLabel[b.status] ?? b.status,
        b.paymentMode == 'PREPAID' ? 'trả trước' : 'trả tại quán',
        if (b.total != null) formatVnd(b.total!),
        if (b.guestPhone != null) b.guestPhone!,
      ].join(' · '),
    ),
  );
}

final userBookingsProvider = FutureProvider.autoDispose.family<List<AdminBookingDto>, String>(
  (ref, userId) => ref.watch(adminRepositoryProvider).bookings(userId: userId),
);

class BookingsDialog extends ConsumerWidget {
  const BookingsDialog({super.key, required this.title, required this.userId});
  final String title;
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) => AlertDialog(
    title: Text('Đơn của $title'),
    content: SizedBox(
      width: 640,
      height: 420,
      child: AsyncPage(
        value: ref.watch(userBookingsProvider(userId)),
        onRetry: () => ref.invalidate(userBookingsProvider(userId)),
        data: (rows) =>
            rows.isEmpty ? const Center(child: Text('Chưa có đơn')) : ListView(children: [for (final b in rows) BookingTile(b)]),
      ),
    ),
    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Đóng'))],
  );
}

/// Booking lookup by code (support calls: "mã CM-8K2P").
class BookingLookupPage extends ConsumerStatefulWidget {
  const BookingLookupPage({super.key});

  @override
  ConsumerState<BookingLookupPage> createState() => _BookingLookupPageState();
}

class _BookingLookupPageState extends ConsumerState<BookingLookupPage> {
  final _code = TextEditingController();
  Future<List<AdminBookingDto>>? _result;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  void _search() {
    final c = _code.text.trim();
    if (c.isEmpty) return;
    final result = ref.read(adminRepositoryProvider).bookings(code: c);
    setState(() {
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const PageHeader('Tra cứu đơn'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _code,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(labelText: 'Mã đơn', border: OutlineInputBorder()),
                onSubmitted: (_) => _search(),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(onPressed: _search, child: const Text('Tìm')),
          ],
        ),
      ),
      Expanded(
        child: _result == null
            ? const SizedBox.shrink()
            : FutureBuilder<List<AdminBookingDto>>(
                future: _result,
                builder: (_, s) {
                  if (s.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
                  if (s.hasError) return Center(child: Text(ApiError.from(s.error!).userMessage));
                  final rows = s.data!;
                  return rows.isEmpty
                      ? const Center(child: Text('Không có đơn với mã này'))
                      : ListView(children: [for (final b in rows) BookingTile(b)]);
                },
              ),
      ),
    ],
  );
}

final auditFilterProvider = NotifierProvider<_AuditFilter, ({String? entity, String? entityId})>(_AuditFilter.new);

class _AuditFilter extends Notifier<({String? entity, String? entityId})> {
  @override
  ({String? entity, String? entityId}) build() => (entity: null, entityId: null);
  void set(String? entity, String? entityId) => state = (entity: entity, entityId: entityId);
}

final auditProvider = FutureProvider.autoDispose<List<AuditEntryDto>>((ref) {
  final f = ref.watch(auditFilterProvider);
  return ref.watch(adminRepositoryProvider).audit(entity: f.entity, entityId: f.entityId);
});

/// Who did what (§23): every status change, refund, block… with the actor.
class AuditPage extends ConsumerStatefulWidget {
  const AuditPage({super.key});

  @override
  ConsumerState<AuditPage> createState() => _AuditPageState();
}

class _AuditPageState extends ConsumerState<AuditPage> {
  String? _entity;
  final _id = TextEditingController();

  @override
  void dispose() {
    _id.dispose();
    super.dispose();
  }

  void _apply() => ref.read(auditFilterProvider.notifier).set(_entity, _id.text.trim().isEmpty ? null : _id.text.trim());

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const PageHeader('Nhật ký'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            DropdownButton<String?>(
              value: _entity,
              hint: const Text('Tất cả'),
              items: const [
                DropdownMenuItem(value: null, child: Text('Tất cả')),
                DropdownMenuItem(value: 'Booking', child: Text('Đơn')),
                DropdownMenuItem(value: 'Restaurant', child: Text('Quán')),
                DropdownMenuItem(value: 'User', child: Text('Khách')),
                DropdownMenuItem(value: 'StaffUser', child: Text('Nhân viên')),
                DropdownMenuItem(value: 'Statement', child: Text('Phí')),
                DropdownMenuItem(value: 'Refund', child: Text('Hoàn tiền')),
              ],
              onChanged: (v) {
                setState(() => _entity = v);
                _apply();
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _id,
                decoration: const InputDecoration(isDense: true, labelText: 'ID (không bắt buộc)', border: OutlineInputBorder()),
                onSubmitted: (_) => _apply(),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: AsyncPage(
          value: ref.watch(auditProvider),
          onRetry: () => ref.invalidate(auditProvider),
          data: (rows) => ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: rows.length,
            itemBuilder: (_, i) {
              final a = rows[i];
              return ListTile(
                dense: true,
                title: Text('${a.action} · ${a.entity} ${a.entityId.length > 8 ? a.entityId.substring(0, 8) : a.entityId}'),
                subtitle: Text(
                  '${dateTime(a.createdAt)} · ${a.actorType}${a.actorId == null ? '' : ' ${a.actorId!.substring(0, 8)}'}${a.data == null || a.data!.isEmpty ? '' : ' · ${a.data}'}',
                ),
              );
            },
          ),
        ),
      ),
    ],
  );
}
