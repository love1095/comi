// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_done_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RefundDoneDtoCWProxy {
  RefundDoneDto note(String? note);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RefundDoneDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RefundDoneDto(...).copyWith(id: 12, name: "My name")
  /// ```
  RefundDoneDto call({String? note});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRefundDoneDto.copyWith(...)` or call `instanceOfRefundDoneDto.copyWith.fieldName(value)` for a single field.
class _$RefundDoneDtoCWProxyImpl implements _$RefundDoneDtoCWProxy {
  const _$RefundDoneDtoCWProxyImpl(this._value);

  final RefundDoneDto _value;

  @override
  RefundDoneDto note(String? note) => call(note: note);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RefundDoneDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RefundDoneDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RefundDoneDto call({Object? note = const $CopyWithPlaceholder()}) {
    return RefundDoneDto(
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
    );
  }
}

extension $RefundDoneDtoCopyWith on RefundDoneDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRefundDoneDto.copyWith(...)` or `instanceOfRefundDoneDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RefundDoneDtoCWProxy get copyWith => _$RefundDoneDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundDoneDto _$RefundDoneDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RefundDoneDto', json, ($checkedConvert) {
      final val = RefundDoneDto(
        note: $checkedConvert('note', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$RefundDoneDtoToJson(RefundDoneDto instance) =>
    <String, dynamic>{'note': ?instance.note};
