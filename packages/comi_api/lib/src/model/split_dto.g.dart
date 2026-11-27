// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'split_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SplitDtoCWProxy {
  SplitDto mode(SplitDtoModeEnum? mode);

  SplitDto total(num total);

  SplitDto paid(num paid);

  SplitDto guests(List<SplitGuestDto> guests);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SplitDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SplitDto(...).copyWith(id: 12, name: "My name")
  /// ```
  SplitDto call({
    SplitDtoModeEnum? mode,
    num total,
    num paid,
    List<SplitGuestDto> guests,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSplitDto.copyWith(...)` or call `instanceOfSplitDto.copyWith.fieldName(value)` for a single field.
class _$SplitDtoCWProxyImpl implements _$SplitDtoCWProxy {
  const _$SplitDtoCWProxyImpl(this._value);

  final SplitDto _value;

  @override
  SplitDto mode(SplitDtoModeEnum? mode) => call(mode: mode);

  @override
  SplitDto total(num total) => call(total: total);

  @override
  SplitDto paid(num paid) => call(paid: paid);

  @override
  SplitDto guests(List<SplitGuestDto> guests) => call(guests: guests);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SplitDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SplitDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  SplitDto call({
    Object? mode = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? paid = const $CopyWithPlaceholder(),
    Object? guests = const $CopyWithPlaceholder(),
  }) {
    return SplitDto(
      mode: mode == const $CopyWithPlaceholder()
          ? _value.mode
          // ignore: cast_nullable_to_non_nullable
          : mode as SplitDtoModeEnum?,
      total: total == const $CopyWithPlaceholder() || total == null
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as num,
      paid: paid == const $CopyWithPlaceholder() || paid == null
          ? _value.paid
          // ignore: cast_nullable_to_non_nullable
          : paid as num,
      guests: guests == const $CopyWithPlaceholder() || guests == null
          ? _value.guests
          // ignore: cast_nullable_to_non_nullable
          : guests as List<SplitGuestDto>,
    );
  }
}

extension $SplitDtoCopyWith on SplitDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSplitDto.copyWith(...)` or `instanceOfSplitDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SplitDtoCWProxy get copyWith => _$SplitDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplitDto _$SplitDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SplitDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['total', 'paid', 'guests']);
      final val = SplitDto(
        mode: $checkedConvert(
          'mode',
          (v) => $enumDecodeNullable(_$SplitDtoModeEnumEnumMap, v),
        ),
        total: $checkedConvert('total', (v) => v as num),
        paid: $checkedConvert('paid', (v) => v as num),
        guests: $checkedConvert(
          'guests',
          (v) => (v as List<dynamic>)
              .map((e) => SplitGuestDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SplitDtoToJson(SplitDto instance) => <String, dynamic>{
  'mode': ?_$SplitDtoModeEnumEnumMap[instance.mode],
  'total': instance.total,
  'paid': instance.paid,
  'guests': instance.guests.map((e) => e.toJson()).toList(),
};

const _$SplitDtoModeEnumEnumMap = {
  SplitDtoModeEnum.EQUAL: 'EQUAL',
  SplitDtoModeEnum.BY_ITEMS: 'BY_ITEMS',
  SplitDtoModeEnum.CUSTOM: 'CUSTOM',
};
