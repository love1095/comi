// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_input_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VoucherInputDtoCWProxy {
  VoucherInputDto code(String code);

  VoucherInputDto type(VoucherType type);

  VoucherInputDto value(num value);

  VoucherInputDto maxDiscount(num? maxDiscount);

  VoucherInputDto minOrder(num? minOrder);

  VoucherInputDto startsAt(String startsAt);

  VoucherInputDto endsAt(String endsAt);

  VoucherInputDto totalLimit(num? totalLimit);

  VoucherInputDto perUserLimit(num? perUserLimit);

  VoucherInputDto firstOrderOnly(bool? firstOrderOnly);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `VoucherInputDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VoucherInputDto(...).copyWith(id: 12, name: "My name")
  /// ```
  VoucherInputDto call({
    String code,
    VoucherType type,
    num value,
    num? maxDiscount,
    num? minOrder,
    String startsAt,
    String endsAt,
    num? totalLimit,
    num? perUserLimit,
    bool? firstOrderOnly,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfVoucherInputDto.copyWith(...)` or call `instanceOfVoucherInputDto.copyWith.fieldName(value)` for a single field.
class _$VoucherInputDtoCWProxyImpl implements _$VoucherInputDtoCWProxy {
  const _$VoucherInputDtoCWProxyImpl(this._value);

  final VoucherInputDto _value;

  @override
  VoucherInputDto code(String code) => call(code: code);

  @override
  VoucherInputDto type(VoucherType type) => call(type: type);

  @override
  VoucherInputDto value(num value) => call(value: value);

  @override
  VoucherInputDto maxDiscount(num? maxDiscount) =>
      call(maxDiscount: maxDiscount);

  @override
  VoucherInputDto minOrder(num? minOrder) => call(minOrder: minOrder);

  @override
  VoucherInputDto startsAt(String startsAt) => call(startsAt: startsAt);

  @override
  VoucherInputDto endsAt(String endsAt) => call(endsAt: endsAt);

  @override
  VoucherInputDto totalLimit(num? totalLimit) => call(totalLimit: totalLimit);

  @override
  VoucherInputDto perUserLimit(num? perUserLimit) =>
      call(perUserLimit: perUserLimit);

  @override
  VoucherInputDto firstOrderOnly(bool? firstOrderOnly) =>
      call(firstOrderOnly: firstOrderOnly);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `VoucherInputDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VoucherInputDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  VoucherInputDto call({
    Object? code = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? maxDiscount = const $CopyWithPlaceholder(),
    Object? minOrder = const $CopyWithPlaceholder(),
    Object? startsAt = const $CopyWithPlaceholder(),
    Object? endsAt = const $CopyWithPlaceholder(),
    Object? totalLimit = const $CopyWithPlaceholder(),
    Object? perUserLimit = const $CopyWithPlaceholder(),
    Object? firstOrderOnly = const $CopyWithPlaceholder(),
  }) {
    return VoucherInputDto(
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as VoucherType,
      value: value == const $CopyWithPlaceholder() || value == null
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as num,
      maxDiscount: maxDiscount == const $CopyWithPlaceholder()
          ? _value.maxDiscount
          // ignore: cast_nullable_to_non_nullable
          : maxDiscount as num?,
      minOrder: minOrder == const $CopyWithPlaceholder()
          ? _value.minOrder
          // ignore: cast_nullable_to_non_nullable
          : minOrder as num?,
      startsAt: startsAt == const $CopyWithPlaceholder() || startsAt == null
          ? _value.startsAt
          // ignore: cast_nullable_to_non_nullable
          : startsAt as String,
      endsAt: endsAt == const $CopyWithPlaceholder() || endsAt == null
          ? _value.endsAt
          // ignore: cast_nullable_to_non_nullable
          : endsAt as String,
      totalLimit: totalLimit == const $CopyWithPlaceholder()
          ? _value.totalLimit
          // ignore: cast_nullable_to_non_nullable
          : totalLimit as num?,
      perUserLimit: perUserLimit == const $CopyWithPlaceholder()
          ? _value.perUserLimit
          // ignore: cast_nullable_to_non_nullable
          : perUserLimit as num?,
      firstOrderOnly: firstOrderOnly == const $CopyWithPlaceholder()
          ? _value.firstOrderOnly
          // ignore: cast_nullable_to_non_nullable
          : firstOrderOnly as bool?,
    );
  }
}

extension $VoucherInputDtoCopyWith on VoucherInputDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfVoucherInputDto.copyWith(...)` or `instanceOfVoucherInputDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VoucherInputDtoCWProxy get copyWith => _$VoucherInputDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherInputDto _$VoucherInputDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('VoucherInputDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['code', 'type', 'value', 'startsAt', 'endsAt'],
      );
      final val = VoucherInputDto(
        code: $checkedConvert('code', (v) => v as String),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$VoucherTypeEnumMap, v),
        ),
        value: $checkedConvert('value', (v) => v as num),
        maxDiscount: $checkedConvert('maxDiscount', (v) => v as num?),
        minOrder: $checkedConvert('minOrder', (v) => v as num?),
        startsAt: $checkedConvert('startsAt', (v) => v as String),
        endsAt: $checkedConvert('endsAt', (v) => v as String),
        totalLimit: $checkedConvert('totalLimit', (v) => v as num?),
        perUserLimit: $checkedConvert('perUserLimit', (v) => v as num?),
        firstOrderOnly: $checkedConvert('firstOrderOnly', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$VoucherInputDtoToJson(VoucherInputDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'type': _$VoucherTypeEnumMap[instance.type]!,
      'value': instance.value,
      'maxDiscount': ?instance.maxDiscount,
      'minOrder': ?instance.minOrder,
      'startsAt': instance.startsAt,
      'endsAt': instance.endsAt,
      'totalLimit': ?instance.totalLimit,
      'perUserLimit': ?instance.perUserLimit,
      'firstOrderOnly': ?instance.firstOrderOnly,
    };

const _$VoucherTypeEnumMap = {
  VoucherType.FIXED: 'FIXED',
  VoucherType.PERCENT: 'PERCENT',
};
