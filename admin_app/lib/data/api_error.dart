import 'package:dio/dio.dart';

/// Every API error is `{ error: { code, message, details } }` (§21).
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
        DioExceptionType.connectionError || DioExceptionType.connectionTimeout => const ApiError('OFFLINE', 'Không kết nối được máy chủ'),
        DioExceptionType.receiveTimeout || DioExceptionType.sendTimeout => const ApiError('TIMEOUT', 'Máy chủ phản hồi chậm, thử lại'),
        _ => ApiError('HTTP_${e.response?.statusCode ?? 0}', e.message ?? 'Lỗi mạng'),
      };
    }
    return ApiError('UNKNOWN', e.toString());
  }

  /// Short Vietnamese text for admins.
  String get userMessage => switch (code) {
    'UNAUTHORIZED' || 'INVALID_CREDENTIALS' => 'Email hoặc mật khẩu không đúng',
    'MFA_CODE_REQUIRED' => 'Nhập mã 6 số từ ứng dụng xác thực',
    'MFA_CODE_INVALID' => 'Mã xác thực sai hoặc đã dùng',
    'MFA_REQUIRED' => 'Cần đăng nhập lại bằng mã xác thực',
    'INVALID_STATUS' => 'Trạng thái đã thay đổi, tải lại trang',
    'FORBIDDEN' => 'Bạn không có quyền làm việc này',
    'LAYOUT_INVALID' => 'Sơ đồ còn lỗi, kiểm tra lại các bàn',
    'CONFLICT' => 'Đã tồn tại (trùng mã?)',
    'NOT_FOUND' => 'Không tìm thấy',
    _ => message.isEmpty ? 'Có lỗi xảy ra ($code)' : message,
  };

  @override
  String toString() => '$code: $message';
}
