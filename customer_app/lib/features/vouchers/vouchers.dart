import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/session.dart';

/// Voucher preview at checkout (§12). The booking re-checks it under a lock.
abstract class VouchersRepository {
  Future<VoucherCheckResultDto> check(String code, String restaurantId, List<CartLineDto> items);
}

class ApiVouchersRepository implements VouchersRepository {
  ApiVouchersRepository(this._api);
  final CustomerVouchersApi _api;

  @override
  Future<VoucherCheckResultDto> check(String code, String restaurantId, List<CartLineDto> items) async => (await _api.customerVouchersCheck(
    voucherCheckDto: VoucherCheckDto(code: code, restaurantId: restaurantId, items: items),
  )).data!;
}

final vouchersRepositoryProvider = Provider<VouchersRepository>(
  (ref) => ApiVouchersRepository(ref.watch(apiProvider).getCustomerVouchersApi()),
);

String voucherProblemText(String? problem) => switch (problem) {
  'NOT_FOUND' => 'Không có mã này',
  'INACTIVE' || 'EXPIRED' => 'Mã đã hết hạn',
  'NOT_STARTED' => 'Mã chưa bắt đầu',
  'WRONG_RESTAURANT' => 'Mã dùng cho quán khác',
  'MIN_ORDER' => 'Chưa đủ giá trị tối thiểu (không tính đồ uống có cồn)',
  'SOLD_OUT' => 'Mã đã hết lượt',
  'ALREADY_USED' => 'Bạn đã dùng mã này',
  'FIRST_ORDER_ONLY' => 'Mã chỉ cho lần đầu đặt',
  _ => 'Mã không dùng được',
};
