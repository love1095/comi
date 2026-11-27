// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_voucher_input_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AdminVoucherInputDtoCWProxy {
  AdminVoucherInputDto code(String code);

  AdminVoucherInputDto type(VoucherType type);

  AdminVoucherInputDto value(num value);

  AdminVoucherInputDto maxDiscount(num? maxDiscount);

  AdminVoucherInputDto minOrder(num? minOrder);

  AdminVoucherInputDto startsAt(String startsAt);

  AdminVoucherInputDto endsAt(String endsAt);

  AdminVoucherInputDto totalLimit(num? totalLimit);

  AdminVoucherInputDto perUserLimit(num? perUserLimit);

  AdminVoucherInputDto firstOrderOnly(bool? firstOrderOnly);

  AdminVoucherInputDto restaurantId(String? restaurantId);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminVoucherInputDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminVoucherInputDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AdminVoucherInputDto call({
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
    String? restaurantId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAdminVoucherInputDto.copyWith(...)` or call `instanceOfAdminVoucherInputDto.copyWith.fieldName(value)` for a single field.
class _$AdminVoucherInputDtoCWProxyImpl
    implements _$AdminVoucherInputDtoCWProxy {
  const _$AdminVoucherInputDtoCWProxyImpl(this._value);

  final AdminVoucherInputDto _value;

  @override
  AdminVoucherInputDto code(String code) => call(code: code);

  @override
  AdminVoucherInputDto type(VoucherType type) => call(type: type);

  @override
  AdminVoucherInputDto value(num value) => call(value: value);

  @override
  AdminVoucherInputDto maxDiscount(num? maxDiscount) =>
      call(maxDiscount: maxDiscount);

  @override
  AdminVoucherInputDto minOrder(num? minOrder) => call(minOrder: minOrder);

  @override
  AdminVoucherInputDto startsAt(String startsAt) => call(startsAt: startsAt);

  @override
  AdminVoucherInputDto endsAt(String endsAt) => call(endsAt: endsAt);

  @override
  AdminVoucherInputDto totalLimit(num? totalLimit) =>
      call(totalLimit: totalLimit);

  @override
  AdminVoucherInputDto perUserLimit(num? perUserLimit) =>
      call(perUserLimit: perUserLimit);

  @override
  AdminVoucherInputDto firstOrderOnly(bool? firstOrderOnly) =>
      call(firstOrderOnly: firstOrderOnly);

  @override
  AdminVoucherInputDto restaurantId(String? restaurantId) =>
      call(restaurantId: restaurantId);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AdminVoucherInputDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminVoucherInputDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AdminVoucherInputDto call({
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
    Object? restaurantId = const $CopyWithPlaceholder(),
  }) {
    return AdminVoucherInputDto(
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
      restaurantId: restaurantId == const $CopyWithPlaceholder()
          ? _value.restaurantId
          // ignore: cast_nullable_to_non_nullable
          : restaurantId as String?,
    );
  }
}

extension $AdminVoucherInputDtoCopyWith on AdminVoucherInputDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAdminVoucherInputDto.copyWith(...)` or `instanceOfAdminVoucherInputDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AdminVoucherInputDtoCWProxy get copyWith =>
      _$AdminVoucherInputDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminVoucherInputDto _$AdminVoucherInputDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AdminVoucherInputDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['code', 'type', 'value', 'startsAt', 'endsAt'],
  );
  final val = AdminVoucherInputDto(
    code: $checkedConvert('code', (v) => v as String),
    type: $checkedConvert('type', (v) => $enumDecode(_$VoucherTypeEnumMap, v)),
    value: $checkedConvert('value', (v) => v as num),
    maxDiscount: $checkedConvert('maxDiscount', (v) => v as num?),
    minOrder: $checkedConvert('minOrder', (v) => v as num?),
    startsAt: $checkedConvert('startsAt', (v) => v as String),
    endsAt: $checkedConvert('endsAt', (v) => v as String),
    totalLimit: $checkedConvert('totalLimit', (v) => v as num?),
    perUserLimit: $checkedConvert('perUserLimit', (v) => v as num?),
    firstOrderOnly: $checkedConvert('firstOrderOnly', (v) => v as bool?),
    restaurantId: $checkedConvert('restaurantId', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$AdminVoucherInputDtoToJson(
  AdminVoucherInputDto instance,
) => <String, dynamic>{
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
  'restaurantId': ?instance.restaurantId,
};

const _$VoucherTypeEnumMap = {
  VoucherType.FIXED: 'FIXED',
  VoucherType.PERCENT: 'PERCENT',
};
