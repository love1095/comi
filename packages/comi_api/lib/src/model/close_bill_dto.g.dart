// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_bill_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CloseBillDtoCWProxy {
  CloseBillDto finalBillAmount(num? finalBillAmount);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CloseBillDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CloseBillDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CloseBillDto call({num? finalBillAmount});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCloseBillDto.copyWith(...)` or call `instanceOfCloseBillDto.copyWith.fieldName(value)` for a single field.
class _$CloseBillDtoCWProxyImpl implements _$CloseBillDtoCWProxy {
  const _$CloseBillDtoCWProxyImpl(this._value);

  final CloseBillDto _value;

  @override
  CloseBillDto finalBillAmount(num? finalBillAmount) =>
      call(finalBillAmount: finalBillAmount);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CloseBillDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CloseBillDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CloseBillDto call({Object? finalBillAmount = const $CopyWithPlaceholder()}) {
    return CloseBillDto(
      finalBillAmount: finalBillAmount == const $CopyWithPlaceholder()
          ? _value.finalBillAmount
          // ignore: cast_nullable_to_non_nullable
          : finalBillAmount as num?,
    );
  }
}

extension $CloseBillDtoCopyWith on CloseBillDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCloseBillDto.copyWith(...)` or `instanceOfCloseBillDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CloseBillDtoCWProxy get copyWith => _$CloseBillDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloseBillDto _$CloseBillDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CloseBillDto', json, ($checkedConvert) {
      final val = CloseBillDto(
        finalBillAmount: $checkedConvert('finalBillAmount', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$CloseBillDtoToJson(CloseBillDto instance) =>
    <String, dynamic>{'finalBillAmount': ?instance.finalBillAmount};
