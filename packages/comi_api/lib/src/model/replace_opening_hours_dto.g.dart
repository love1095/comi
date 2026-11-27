// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replace_opening_hours_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReplaceOpeningHoursDtoCWProxy {
  ReplaceOpeningHoursDto items(List<OpeningHoursItemDto> items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReplaceOpeningHoursDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReplaceOpeningHoursDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ReplaceOpeningHoursDto call({List<OpeningHoursItemDto> items});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReplaceOpeningHoursDto.copyWith(...)` or call `instanceOfReplaceOpeningHoursDto.copyWith.fieldName(value)` for a single field.
class _$ReplaceOpeningHoursDtoCWProxyImpl
    implements _$ReplaceOpeningHoursDtoCWProxy {
  const _$ReplaceOpeningHoursDtoCWProxyImpl(this._value);

  final ReplaceOpeningHoursDto _value;

  @override
  ReplaceOpeningHoursDto items(List<OpeningHoursItemDto> items) =>
      call(items: items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReplaceOpeningHoursDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReplaceOpeningHoursDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ReplaceOpeningHoursDto call({Object? items = const $CopyWithPlaceholder()}) {
    return ReplaceOpeningHoursDto(
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<OpeningHoursItemDto>,
    );
  }
}

extension $ReplaceOpeningHoursDtoCopyWith on ReplaceOpeningHoursDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReplaceOpeningHoursDto.copyWith(...)` or `instanceOfReplaceOpeningHoursDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReplaceOpeningHoursDtoCWProxy get copyWith =>
      _$ReplaceOpeningHoursDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplaceOpeningHoursDto _$ReplaceOpeningHoursDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ReplaceOpeningHoursDto', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['items']);
  final val = ReplaceOpeningHoursDto(
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => OpeningHoursItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ReplaceOpeningHoursDtoToJson(
  ReplaceOpeningHoursDto instance,
) => <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
