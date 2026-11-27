// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_issued_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MarkIssuedDtoCWProxy {
  MarkIssuedDto invoiceNo(String? invoiceNo);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MarkIssuedDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MarkIssuedDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MarkIssuedDto call({String? invoiceNo});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMarkIssuedDto.copyWith(...)` or call `instanceOfMarkIssuedDto.copyWith.fieldName(value)` for a single field.
class _$MarkIssuedDtoCWProxyImpl implements _$MarkIssuedDtoCWProxy {
  const _$MarkIssuedDtoCWProxyImpl(this._value);

  final MarkIssuedDto _value;

  @override
  MarkIssuedDto invoiceNo(String? invoiceNo) => call(invoiceNo: invoiceNo);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MarkIssuedDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MarkIssuedDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MarkIssuedDto call({Object? invoiceNo = const $CopyWithPlaceholder()}) {
    return MarkIssuedDto(
      invoiceNo: invoiceNo == const $CopyWithPlaceholder()
          ? _value.invoiceNo
          // ignore: cast_nullable_to_non_nullable
          : invoiceNo as String?,
    );
  }
}

extension $MarkIssuedDtoCopyWith on MarkIssuedDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMarkIssuedDto.copyWith(...)` or `instanceOfMarkIssuedDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MarkIssuedDtoCWProxy get copyWith => _$MarkIssuedDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkIssuedDto _$MarkIssuedDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MarkIssuedDto', json, ($checkedConvert) {
      final val = MarkIssuedDto(
        invoiceNo: $checkedConvert('invoiceNo', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$MarkIssuedDtoToJson(MarkIssuedDto instance) =>
    <String, dynamic>{'invoiceNo': ?instance.invoiceNo};
