// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_brief_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AreaBriefDtoCWProxy {
  AreaBriefDto id(String id);

  AreaBriefDto name(String name);

  AreaBriefDto floor(num floor);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AreaBriefDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AreaBriefDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AreaBriefDto call({String id, String name, num floor});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAreaBriefDto.copyWith(...)` or call `instanceOfAreaBriefDto.copyWith.fieldName(value)` for a single field.
class _$AreaBriefDtoCWProxyImpl implements _$AreaBriefDtoCWProxy {
  const _$AreaBriefDtoCWProxyImpl(this._value);

  final AreaBriefDto _value;

  @override
  AreaBriefDto id(String id) => call(id: id);

  @override
  AreaBriefDto name(String name) => call(name: name);

  @override
  AreaBriefDto floor(num floor) => call(floor: floor);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AreaBriefDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AreaBriefDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AreaBriefDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? floor = const $CopyWithPlaceholder(),
  }) {
    return AreaBriefDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      floor: floor == const $CopyWithPlaceholder() || floor == null
          ? _value.floor
          // ignore: cast_nullable_to_non_nullable
          : floor as num,
    );
  }
}

extension $AreaBriefDtoCopyWith on AreaBriefDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAreaBriefDto.copyWith(...)` or `instanceOfAreaBriefDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AreaBriefDtoCWProxy get copyWith => _$AreaBriefDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaBriefDto _$AreaBriefDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AreaBriefDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'name', 'floor']);
      final val = AreaBriefDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        floor: $checkedConvert('floor', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$AreaBriefDtoToJson(AreaBriefDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'floor': instance.floor,
    };
