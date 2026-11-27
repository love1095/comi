// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_paid_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MarkPaidDtoCWProxy {
  MarkPaidDto paid(bool paid);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MarkPaidDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MarkPaidDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MarkPaidDto call({bool paid});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMarkPaidDto.copyWith(...)` or call `instanceOfMarkPaidDto.copyWith.fieldName(value)` for a single field.
class _$MarkPaidDtoCWProxyImpl implements _$MarkPaidDtoCWProxy {
  const _$MarkPaidDtoCWProxyImpl(this._value);

  final MarkPaidDto _value;

  @override
  MarkPaidDto paid(bool paid) => call(paid: paid);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MarkPaidDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MarkPaidDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MarkPaidDto call({Object? paid = const $CopyWithPlaceholder()}) {
    return MarkPaidDto(
      paid: paid == const $CopyWithPlaceholder() || paid == null
          ? _value.paid
          // ignore: cast_nullable_to_non_nullable
          : paid as bool,
    );
  }
}

extension $MarkPaidDtoCopyWith on MarkPaidDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMarkPaidDto.copyWith(...)` or `instanceOfMarkPaidDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MarkPaidDtoCWProxy get copyWith => _$MarkPaidDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkPaidDto _$MarkPaidDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MarkPaidDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['paid']);
      final val = MarkPaidDto(paid: $checkedConvert('paid', (v) => v as bool));
      return val;
    });

Map<String, dynamic> _$MarkPaidDtoToJson(MarkPaidDto instance) =>
    <String, dynamic>{'paid': instance.paid};
