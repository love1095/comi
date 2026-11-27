// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unavailable_line_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UnavailableLineDtoCWProxy {
  UnavailableLineDto menuItemId(String menuItemId);

  UnavailableLineDto name(String name);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UnavailableLineDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UnavailableLineDto(...).copyWith(id: 12, name: "My name")
  /// ```
  UnavailableLineDto call({String menuItemId, String name});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUnavailableLineDto.copyWith(...)` or call `instanceOfUnavailableLineDto.copyWith.fieldName(value)` for a single field.
class _$UnavailableLineDtoCWProxyImpl implements _$UnavailableLineDtoCWProxy {
  const _$UnavailableLineDtoCWProxyImpl(this._value);

  final UnavailableLineDto _value;

  @override
  UnavailableLineDto menuItemId(String menuItemId) =>
      call(menuItemId: menuItemId);

  @override
  UnavailableLineDto name(String name) => call(name: name);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UnavailableLineDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UnavailableLineDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  UnavailableLineDto call({
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return UnavailableLineDto(
      menuItemId:
          menuItemId == const $CopyWithPlaceholder() || menuItemId == null
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $UnavailableLineDtoCopyWith on UnavailableLineDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUnavailableLineDto.copyWith(...)` or `instanceOfUnavailableLineDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UnavailableLineDtoCWProxy get copyWith =>
      _$UnavailableLineDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnavailableLineDto _$UnavailableLineDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UnavailableLineDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['menuItemId', 'name']);
      final val = UnavailableLineDto(
        menuItemId: $checkedConvert('menuItemId', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$UnavailableLineDtoToJson(UnavailableLineDto instance) =>
    <String, dynamic>{'menuItemId': instance.menuItemId, 'name': instance.name};
