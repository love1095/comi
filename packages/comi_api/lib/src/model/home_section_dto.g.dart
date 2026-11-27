// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_section_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeSectionDtoCWProxy {
  HomeSectionDto key(String key);

  HomeSectionDto items(List<RestaurantCardDto> items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `HomeSectionDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HomeSectionDto(...).copyWith(id: 12, name: "My name")
  /// ```
  HomeSectionDto call({String key, List<RestaurantCardDto> items});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfHomeSectionDto.copyWith(...)` or call `instanceOfHomeSectionDto.copyWith.fieldName(value)` for a single field.
class _$HomeSectionDtoCWProxyImpl implements _$HomeSectionDtoCWProxy {
  const _$HomeSectionDtoCWProxyImpl(this._value);

  final HomeSectionDto _value;

  @override
  HomeSectionDto key(String key) => call(key: key);

  @override
  HomeSectionDto items(List<RestaurantCardDto> items) => call(items: items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `HomeSectionDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HomeSectionDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  HomeSectionDto call({
    Object? key = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return HomeSectionDto(
      key: key == const $CopyWithPlaceholder() || key == null
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String,
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<RestaurantCardDto>,
    );
  }
}

extension $HomeSectionDtoCopyWith on HomeSectionDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfHomeSectionDto.copyWith(...)` or `instanceOfHomeSectionDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomeSectionDtoCWProxy get copyWith => _$HomeSectionDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeSectionDto _$HomeSectionDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('HomeSectionDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['key', 'items']);
      final val = HomeSectionDto(
        key: $checkedConvert('key', (v) => v as String),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => RestaurantCardDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$HomeSectionDtoToJson(HomeSectionDto instance) =>
    <String, dynamic>{
      'key': instance.key,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
