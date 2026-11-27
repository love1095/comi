// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VoucherDtoCWProxy {
  VoucherDto id(String id);

  VoucherDto code(String code);

  VoucherDto restaurantId(String? restaurantId);

  VoucherDto fundedBy(VoucherFunder fundedBy);

  VoucherDto type(VoucherType type);

  VoucherDto value(num value);

  VoucherDto maxDiscount(num? maxDiscount);

  VoucherDto minOrder(num minOrder);

  VoucherDto startsAt(String startsAt);

  VoucherDto endsAt(String endsAt);

  VoucherDto totalLimit(num? totalLimit);

  VoucherDto perUserLimit(num perUserLimit);

  VoucherDto firstOrderOnly(bool firstOrderOnly);

  VoucherDto usedCount(num usedCount);

  VoucherDto isActive(bool isActive);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `VoucherDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VoucherDto(...).copyWith(id: 12, name: "My name")
  /// ```
  VoucherDto call({
    String id,
    String code,
    String? restaurantId,
    VoucherFunder fundedBy,
    VoucherType type,
    num value,
    num? maxDiscount,
    num minOrder,
    String startsAt,
    String endsAt,
    num? totalLimit,
    num perUserLimit,
    bool firstOrderOnly,
    num usedCount,
    bool isActive,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfVoucherDto.copyWith(...)` or call `instanceOfVoucherDto.copyWith.fieldName(value)` for a single field.
class _$VoucherDtoCWProxyImpl implements _$VoucherDtoCWProxy {
  const _$VoucherDtoCWProxyImpl(this._value);

  final VoucherDto _value;

  @override
  VoucherDto id(String id) => call(id: id);

  @override
  VoucherDto code(String code) => call(code: code);

  @override
  VoucherDto restaurantId(String? restaurantId) =>
      call(restaurantId: restaurantId);

  @override
  VoucherDto fundedBy(VoucherFunder fundedBy) => call(fundedBy: fundedBy);

  @override
  VoucherDto type(VoucherType type) => call(type: type);

  @override
  VoucherDto value(num value) => call(value: value);

  @override
  VoucherDto maxDiscount(num? maxDiscount) => call(maxDiscount: maxDiscount);

  @override
  VoucherDto minOrder(num minOrder) => call(minOrder: minOrder);

  @override
  VoucherDto startsAt(String startsAt) => call(startsAt: startsAt);

  @override
  VoucherDto endsAt(String endsAt) => call(endsAt: endsAt);

  @override
  VoucherDto totalLimit(num? totalLimit) => call(totalLimit: totalLimit);

  @override
  VoucherDto perUserLimit(num perUserLimit) => call(perUserLimit: perUserLimit);

  @override
  VoucherDto firstOrderOnly(bool firstOrderOnly) =>
      call(firstOrderOnly: firstOrderOnly);

  @override
  VoucherDto usedCount(num usedCount) => call(usedCount: usedCount);

  @override
  VoucherDto isActive(bool isActive) => call(isActive: isActive);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `VoucherDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VoucherDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  VoucherDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? restaurantId = const $CopyWithPlaceholder(),
    Object? fundedBy = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? maxDiscount = const $CopyWithPlaceholder(),
    Object? minOrder = const $CopyWithPlaceholder(),
    Object? startsAt = const $CopyWithPlaceholder(),
    Object? endsAt = const $CopyWithPlaceholder(),
    Object? totalLimit = const $CopyWithPlaceholder(),
    Object? perUserLimit = const $CopyWithPlaceholder(),
    Object? firstOrderOnly = const $CopyWithPlaceholder(),
    Object? usedCount = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return VoucherDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      restaurantId: restaurantId == const $CopyWithPlaceholder()
          ? _value.restaurantId
          // ignore: cast_nullable_to_non_nullable
          : restaurantId as String?,
      fundedBy: fundedBy == const $CopyWithPlaceholder() || fundedBy == null
          ? _value.fundedBy
          // ignore: cast_nullable_to_non_nullable
          : fundedBy as VoucherFunder,
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
      minOrder: minOrder == const $CopyWithPlaceholder() || minOrder == null
          ? _value.minOrder
          // ignore: cast_nullable_to_non_nullable
          : minOrder as num,
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
      perUserLimit:
          perUserLimit == const $CopyWithPlaceholder() || perUserLimit == null
          ? _value.perUserLimit
          // ignore: cast_nullable_to_non_nullable
          : perUserLimit as num,
      firstOrderOnly:
          firstOrderOnly == const $CopyWithPlaceholder() ||
              firstOrderOnly == null
          ? _value.firstOrderOnly
          // ignore: cast_nullable_to_non_nullable
          : firstOrderOnly as bool,
      usedCount: usedCount == const $CopyWithPlaceholder() || usedCount == null
          ? _value.usedCount
          // ignore: cast_nullable_to_non_nullable
          : usedCount as num,
      isActive: isActive == const $CopyWithPlaceholder() || isActive == null
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
    );
  }
}

extension $VoucherDtoCopyWith on VoucherDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfVoucherDto.copyWith(...)` or `instanceOfVoucherDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VoucherDtoCWProxy get copyWith => _$VoucherDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherDto _$VoucherDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('VoucherDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'code',
          'fundedBy',
          'type',
          'value',
          'minOrder',
          'startsAt',
          'endsAt',
          'perUserLimit',
          'firstOrderOnly',
          'usedCount',
          'isActive',
        ],
      );
      final val = VoucherDto(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        restaurantId: $checkedConvert('restaurantId', (v) => v as String?),
        fundedBy: $checkedConvert(
          'fundedBy',
          (v) => $enumDecode(_$VoucherFunderEnumMap, v),
        ),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$VoucherTypeEnumMap, v),
        ),
        value: $checkedConvert('value', (v) => v as num),
        maxDiscount: $checkedConvert('maxDiscount', (v) => v as num?),
        minOrder: $checkedConvert('minOrder', (v) => v as num),
        startsAt: $checkedConvert('startsAt', (v) => v as String),
        endsAt: $checkedConvert('endsAt', (v) => v as String),
        totalLimit: $checkedConvert('totalLimit', (v) => v as num?),
        perUserLimit: $checkedConvert('perUserLimit', (v) => v as num),
        firstOrderOnly: $checkedConvert('firstOrderOnly', (v) => v as bool),
        usedCount: $checkedConvert('usedCount', (v) => v as num),
        isActive: $checkedConvert('isActive', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$VoucherDtoToJson(VoucherDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'restaurantId': ?instance.restaurantId,
      'fundedBy': _$VoucherFunderEnumMap[instance.fundedBy]!,
      'type': _$VoucherTypeEnumMap[instance.type]!,
      'value': instance.value,
      'maxDiscount': ?instance.maxDiscount,
      'minOrder': instance.minOrder,
      'startsAt': instance.startsAt,
      'endsAt': instance.endsAt,
      'totalLimit': ?instance.totalLimit,
      'perUserLimit': instance.perUserLimit,
      'firstOrderOnly': instance.firstOrderOnly,
      'usedCount': instance.usedCount,
      'isActive': instance.isActive,
    };

const _$VoucherFunderEnumMap = {
  VoucherFunder.PLATFORM: 'PLATFORM',
  VoucherFunder.RESTAURANT: 'RESTAURANT',
};

const _$VoucherTypeEnumMap = {
  VoucherType.FIXED: 'FIXED',
  VoucherType.PERCENT: 'PERCENT',
};
