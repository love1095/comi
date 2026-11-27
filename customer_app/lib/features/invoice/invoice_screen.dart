import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../../data/session.dart';

/// Vietnamese tax code (MST): 10 digits, branches add -XXX (§13).
final taxCodeRe = RegExp(r'^\d{10}(-\d{3})?$');

abstract class InvoiceRepository {
  /// null when nothing was requested yet.
  Future<InvoiceRequestDto?> forBooking(String bookingId);
  Future<List<InvoiceProfileDto>> profiles();
  Future<InvoiceRequestDto> request(String bookingId, InvoiceRequestCreateDto dto);
}

class ApiInvoiceRepository implements InvoiceRepository {
  ApiInvoiceRepository(this._api);
  final CustomerVATInvoiceApi _api;

  @override
  Future<InvoiceRequestDto?> forBooking(String bookingId) async {
    try {
      return (await _api.customerInvoiceGet(id: bookingId)).data;
    } catch (e) {
      if (ApiError.from(e).code == 'NOT_FOUND') return null;
      rethrow;
    }
  }

  @override
  Future<List<InvoiceProfileDto>> profiles() async => (await _api.customerInvoiceProfiles()).data ?? const [];

  @override
  Future<InvoiceRequestDto> request(String bookingId, InvoiceRequestCreateDto dto) async =>
      (await _api.customerInvoiceRequest(id: bookingId, invoiceRequestCreateDto: dto)).data!;
}

final invoiceRepositoryProvider = Provider<InvoiceRepository>(
  (ref) => ApiInvoiceRepository(ref.watch(apiProvider).getCustomerVATInvoiceApi()),
);

String invoiceStatusText(InvoiceRequestDtoStatusEnum s) => switch (s) {
  InvoiceRequestDtoStatusEnum.REQUESTED || InvoiceRequestDtoStatusEnum.SENT_TO_RESTAURANT => 'Đã gửi quán, chờ xuất hoá đơn',
  InvoiceRequestDtoStatusEnum.ISSUED || InvoiceRequestDtoStatusEnum.EMAILED => 'Quán đã xuất hoá đơn',
  InvoiceRequestDtoStatusEnum.REJECTED => 'Quán từ chối — liên hệ quán',
};

/// "Request VAT invoice" (§13): company, MST, address, email; optionally saved for next time.
class InvoiceScreen extends ConsumerStatefulWidget {
  const InvoiceScreen({super.key, required this.bookingId});
  final String bookingId;

  @override
  ConsumerState<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends ConsumerState<InvoiceScreen> {
  final _form = GlobalKey<FormState>();
  final _company = TextEditingController();
  final _tax = TextEditingController();
  final _address = TextEditingController();
  final _email = TextEditingController();
  var _save = true;
  var _loading = true;
  var _busy = false;
  InvoiceRequestDto? _existing;
  Object? _error;

  InvoiceRepository get _repo => ref.read(invoiceRepositoryProvider);

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final existing = await _repo.forBooking(widget.bookingId);
      final profiles = existing == null ? await _repo.profiles() : const <InvoiceProfileDto>[];
      if (profiles.isNotEmpty) {
        final p = profiles.first;
        _company.text = p.companyName;
        _tax.text = p.taxCode;
        _address.text = p.address;
        _email.text = p.email;
      }
      if (mounted) setState(() => _existing = existing);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    for (final c in [_company, _tax, _address, _email]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      final r = await _repo.request(
        widget.bookingId,
        InvoiceRequestCreateDto(
          companyName: _company.text.trim(),
          taxCode: _tax.text.trim(),
          address: _address.text.trim(),
          email: _email.text.trim(),
          saveProfile: _save,
        ),
      );
      if (mounted) setState(() => _existing = r);
    } catch (e) {
      final err = ApiError.from(e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err.code == 'INVALID_STATUS' ? 'Chỉ yêu cầu được trong bữa ăn hoặc trong 24 giờ sau đó' : err.userMessage),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Hoá đơn VAT')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(ApiError.from(_error!).userMessage))
          : _existing != null
          ? ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.receipt_long),
                    title: Text(invoiceStatusText(_existing!.status)),
                    subtitle: Text(
                      '${_existing!.companyName}\nMST ${_existing!.taxCode} · ${formatVnd(_existing!.amount)}'
                      '${_existing!.invoiceNo == null ? '' : '\nSố hoá đơn: ${_existing!.invoiceNo}'}',
                    ),
                    isThreeLine: true,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Hoá đơn điện tử do nhà hàng xuất và gửi tới ${_existing!.email}.', style: theme.textTheme.bodySmall),
              ],
            )
          : Form(
              key: _form,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text('Nhà hàng sẽ xuất hoá đơn trên hệ thống của quán và gửi qua email.', style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _company,
                    decoration: const InputDecoration(labelText: 'Tên công ty', border: OutlineInputBorder()),
                    validator: (v) => (v ?? '').trim().length < 2 ? 'Nhập tên công ty' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _tax,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Mã số thuế', hintText: '0312345678', border: OutlineInputBorder()),
                    validator: (v) => taxCodeRe.hasMatch((v ?? '').trim()) ? null : 'MST gồm 10 số (chi nhánh: 10 số-3 số)',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _address,
                    decoration: const InputDecoration(labelText: 'Địa chỉ công ty', border: OutlineInputBorder()),
                    validator: (v) => (v ?? '').trim().length < 5 ? 'Nhập địa chỉ' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email nhận hoá đơn', border: OutlineInputBorder()),
                    validator: (v) => RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch((v ?? '').trim()) ? null : 'Email chưa đúng',
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _save,
                    onChanged: (v) => setState(() => _save = v!),
                    title: const Text('Lưu cho lần sau'),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                    onPressed: _busy ? null : _submit,
                    child: Text(_busy ? 'Đang gửi…' : 'Gửi yêu cầu'),
                  ),
                ],
              ),
            ),
    );
  }
}
