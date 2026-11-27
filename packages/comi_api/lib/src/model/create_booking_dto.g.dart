// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_booking_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateBookingDtoCWProxy {
  CreateBookingDto restaurantId(String restaurantId);

  CreateBookingDto arrivalAt(String arrivalAt);

  CreateBookingDto partySize(num partySize);

  CreateBookingDto areaId(String? areaId);

  CreateBookingDto holdId(String? holdId);

  CreateBookingDto paymentMode(CreateBookingDtoPaymentModeEnum paymentMode);

  CreateBookingDto serveStyle(CreateBookingDtoServeStyleEnum? serveStyle);

  CreateBookingDto note(String? note);

  CreateBookingDto occasion(CreateBookingDtoOccasionEnum? occasion);

  CreateBookingDto ageConfirmed(bool? ageConfirmed);

  CreateBookingDto items(List<CartLineDto>? items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CreateBookingDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CreateBookingDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CreateBookingDto call({
    String restaurantId,
    String arrivalAt,
    num partySize,
    String? areaId,
    String? holdId,
    CreateBookingDtoPaymentModeEnum paymentMode,
    CreateBookingDtoServeStyleEnum? serveStyle,
    String? note,
    CreateBookingDtoOccasionEnum? occasion,
    bool? ageConfirmed,
    List<CartLineDto>? items,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCreateBookingDto.copyWith(...)` or call `instanceOfCreateBookingDto.copyWith.fieldName(value)` for a single field.
class _$CreateBookingDtoCWProxyImpl implements _$CreateBookingDtoCWProxy {
  const _$CreateBookingDtoCWProxyImpl(this._value);

  final CreateBookingDto _value;

  @override
  CreateBookingDto restaurantId(String restaurantId) =>
      call(restaurantId: restaurantId);

  @override
  CreateBookingDto arrivalAt(String arrivalAt) => call(arrivalAt: arrivalAt);

  @override
  CreateBookingDto partySize(num partySize) => call(partySize: partySize);

  @override
  CreateBookingDto areaId(String? areaId) => call(areaId: areaId);

  @override
  CreateBookingDto holdId(String? holdId) => call(holdId: holdId);

  @override
  CreateBookingDto paymentMode(CreateBookingDtoPaymentModeEnum paymentMode) =>
      call(paymentMode: paymentMode);

  @override
  CreateBookingDto serveStyle(CreateBookingDtoServeStyleEnum? serveStyle) =>
      call(serveStyle: serveStyle);

  @override
  CreateBookingDto note(String? note) => call(note: note);

  @override
  CreateBookingDto occasion(CreateBookingDtoOccasionEnum? occasion) =>
      call(occasion: occasion);

  @override
  CreateBookingDto ageConfirmed(bool? ageConfirmed) =>
      call(ageConfirmed: ageConfirmed);

  @override
  CreateBookingDto items(List<CartLineDto>? items) => call(items: items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CreateBookingDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CreateBookingDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CreateBookingDto call({
    Object? restaurantId = const $CopyWithPlaceholder(),
    Object? arrivalAt = const $CopyWithPlaceholder(),
    Object? partySize = const $CopyWithPlaceholder(),
    Object? areaId = const $CopyWithPlaceholder(),
    Object? holdId = const $CopyWithPlaceholder(),
    Object? paymentMode = const $CopyWithPlaceholder(),
    Object? serveStyle = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? occasion = const $CopyWithPlaceholder(),
    Object? ageConfirmed = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return CreateBookingDto(
      restaurantId:
          restaurantId == const $CopyWithPlaceholder() || restaurantId == null
          ? _value.restaurantId
          // ignore: cast_nullable_to_non_nullable
          : restaurantId as String,
      arrivalAt: arrivalAt == const $CopyWithPlaceholder() || arrivalAt == null
          ? _value.arrivalAt
          // ignore: cast_nullable_to_non_nullable
          : arrivalAt as String,
      partySize: partySize == const $CopyWithPlaceholder() || partySize == null
          ? _value.partySize
          // ignore: cast_nullable_to_non_nullable
          : partySize as num,
      areaId: areaId == const $CopyWithPlaceholder()
          ? _value.areaId
          // ignore: cast_nullable_to_non_nullable
          : areaId as String?,
      holdId: holdId == const $CopyWithPlaceholder()
          ? _value.holdId
          // ignore: cast_nullable_to_non_nullable
          : holdId as String?,
      paymentMode:
          paymentMode == const $CopyWithPlaceholder() || paymentMode == null
          ? _value.paymentMode
          // ignore: cast_nullable_to_non_nullable
          : paymentMode as CreateBookingDtoPaymentModeEnum,
      serveStyle: serveStyle == const $CopyWithPlaceholder()
          ? _value.serveStyle
          // ignore: cast_nullable_to_non_nullable
          : serveStyle as CreateBookingDtoServeStyleEnum?,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      occasion: occasion == const $CopyWithPlaceholder()
          ? _value.occasion
          // ignore: cast_nullable_to_non_nullable
          : occasion as CreateBookingDtoOccasionEnum?,
      ageConfirmed: ageConfirmed == const $CopyWithPlaceholder()
          ? _value.ageConfirmed
          // ignore: cast_nullable_to_non_nullable
          : ageConfirmed as bool?,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<CartLineDto>?,
    );
  }
}

extension $CreateBookingDtoCopyWith on CreateBookingDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCreateBookingDto.copyWith(...)` or `instanceOfCreateBookingDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateBookingDtoCWProxy get copyWith => _$CreateBookingDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBookingDto _$CreateBookingDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CreateBookingDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'restaurantId',
          'arrivalAt',
          'partySize',
          'paymentMode',
        ],
      );
      final val = CreateBookingDto(
        restaurantId: $checkedConvert('restaurantId', (v) => v as String),
        arrivalAt: $checkedConvert('arrivalAt', (v) => v as String),
        partySize: $checkedConvert('partySize', (v) => v as num),
        areaId: $checkedConvert('areaId', (v) => v as String?),
        holdId: $checkedConvert('holdId', (v) => v as String?),
        paymentMode: $checkedConvert(
          'paymentMode',
          (v) => $enumDecode(_$CreateBookingDtoPaymentModeEnumEnumMap, v),
        ),
        serveStyle: $checkedConvert(
          'serveStyle',
          (v) =>
              $enumDecodeNullable(_$CreateBookingDtoServeStyleEnumEnumMap, v),
        ),
        note: $checkedConvert('note', (v) => v as String?),
        occasion: $checkedConvert(
          'occasion',
          (v) => $enumDecodeNullable(_$CreateBookingDtoOccasionEnumEnumMap, v),
        ),
        ageConfirmed: $checkedConvert('ageConfirmed', (v) => v as bool?),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>?)
              ?.map((e) => CartLineDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CreateBookingDtoToJson(
  CreateBookingDto instance,
) => <String, dynamic>{
  'restaurantId': instance.restaurantId,
  'arrivalAt': instance.arrivalAt,
  'partySize': instance.partySize,
  'areaId': ?instance.areaId,
  'holdId': ?instance.holdId,
  'paymentMode':
      _$CreateBookingDtoPaymentModeEnumEnumMap[instance.paymentMode]!,
  'serveStyle': ?_$CreateBookingDtoServeStyleEnumEnumMap[instance.serveStyle],
  'note': ?instance.note,
  'occasion': ?_$CreateBookingDtoOccasionEnumEnumMap[instance.occasion],
  'ageConfirmed': ?instance.ageConfirmed,
  'items': ?instance.items?.map((e) => e.toJson()).toList(),
};

const _$CreateBookingDtoPaymentModeEnumEnumMap = {
  CreateBookingDtoPaymentModeEnum.PREPAID: 'PREPAID',
  CreateBookingDtoPaymentModeEnum.COD: 'COD',
};

const _$CreateBookingDtoServeStyleEnumEnumMap = {
  CreateBookingDtoServeStyleEnum.BY_COURSE: 'BY_COURSE',
  CreateBookingDtoServeStyleEnum.ALL_TOGETHER: 'ALL_TOGETHER',
};

const _$CreateBookingDtoOccasionEnumEnumMap = {
  CreateBookingDtoOccasionEnum.DATE: 'DATE',
  CreateBookingDtoOccasionEnum.ANNIVERSARY: 'ANNIVERSARY',
  CreateBookingDtoOccasionEnum.BIRTHDAY: 'BIRTHDAY',
  CreateBookingDtoOccasionEnum.BUSINESS: 'BUSINESS',
  CreateBookingDtoOccasionEnum.CELEBRATION: 'CELEBRATION',
};
