import 'package:dio/dio.dart';

/// Every API error is `{ error: { code, message, details } }` (§21). Apps translate `code`.
class ApiError {
  const ApiError(this.code, this.message, [this.details = const {}]);

  final String code;
  final String message;
  final Map<String, dynamic> details;

  static ApiError from(Object e) {
    if (e is ApiError) return e;
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map && data['error'] is Map) {
        final err = data['error'] as Map;
        return ApiError(
          '${err['code'] ?? 'UNKNOWN'}',
          '${err['message'] ?? ''}',
          (err['details'] as Map?)?.cast<String, dynamic>() ?? const {},
        );
      }
      return switch (e.type) {
        DioExceptionType.connectionError || DioExceptionType.connectionTimeout => const ApiError('OFFLINE', 'Không có mạng, thử lại sau'),
        DioExceptionType.receiveTimeout || DioExceptionType.sendTimeout => const ApiError('TIMEOUT', 'Mạng chậm, thử lại'),
        _ => ApiError('HTTP_${e.response?.statusCode ?? 0}', e.message ?? 'Lỗi mạng'),
      };
    }
    return ApiError('UNKNOWN', e.toString());
  }

  /// Short Vietnamese text for diners.
  String get userMessage => switch (code) {
    'UNAUTHORIZED' => 'Vui lòng đăng nhập lại',
    'SLOT_TAKEN' => 'Giờ này vừa hết bàn — chọn giờ khác nhé',
    'TABLE_TAKEN' => 'Bàn vừa có người đặt — chọn bàn khác',
    'HOLD_INVALID' => 'Hết thời gian giữ bàn, chọn lại',
    'PARTY_TOO_LARGE' => 'Nhóm đông quá — quán nhận tối đa ${details['max'] ?? ''} người',
    'AGE_CONFIRMATION_REQUIRED' => 'Đơn có đồ uống có cồn: xác nhận bạn đủ 18 tuổi',
    'ITEM_UNAVAILABLE' => 'Có món vừa hết, kiểm tra lại giỏ',
    'CANCEL_TOO_LATE' => 'Đã quá giờ huỷ online — gọi quán để huỷ',
    'COD_NOT_ALLOWED' => 'Quán này chỉ nhận thanh toán trước (sắp có)',
    'OPTIONS_INVALID' => 'Tuỳ chọn món chưa hợp lệ, chọn lại',
    'SLOT_INVALID' => 'Giờ này không còn nhận đặt, chọn giờ khác',
    'USER_BLOCKED' => 'Tài khoản đang bị khoá, liên hệ comi',
    'RESTAURANT_NOT_AVAILABLE' => 'Quán đang tạm ngưng nhận đặt',
    'REQUEST_IN_PROGRESS' => 'Đang xử lý đơn trước, đợi chút',
    'PREPAY_REQUIRED' => 'Tài khoản cần trả trước do vắng mặt nhiều lần',
    'NOT_FOUND' => 'Không tìm thấy',
    'OFFLINE' || 'TIMEOUT' => message,
    _ => message.isEmpty ? 'Có lỗi xảy ra ($code)' : message,
  };

  @override
  String toString() => '$code: $message';
}
