// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_option_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PublicOptionDtoCWProxy {
  PublicOptionDto id(String id);

  PublicOptionDto name(String name);

  PublicOptionDto priceDelta(num priceDelta);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PublicOptionDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PublicOptionDto(...).copyWith(id: 12, name: "My name")
  /// ```
  PublicOptionDto call({String id, String name, num priceDelta});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPublicOptionDto.copyWith(...)` or call `instanceOfPublicOptionDto.copyWith.fieldName(value)` for a single field.
class _$PublicOptionDtoCWProxyImpl implements _$PublicOptionDtoCWProxy {
  const _$PublicOptionDtoCWProxyImpl(this._value);

  final PublicOptionDto _value;

  @override
  PublicOptionDto id(String id) => call(id: id);

  @override
  PublicOptionDto name(String name) => call(name: name);

  @override
  PublicOptionDto priceDelta(num priceDelta) => call(priceDelta: priceDelta);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PublicOptionDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PublicOptionDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  PublicOptionDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? priceDelta = const $CopyWithPlaceholder(),
  }) {
    return PublicOptionDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      priceDelta:
          priceDelta == const $CopyWithPlaceholder() || priceDelta == null
          ? _value.priceDelta
          // ignore: cast_nullable_to_non_nullable
          : priceDelta as num,
    );
  }
}

extension $PublicOptionDtoCopyWith on PublicOptionDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPublicOptionDto.copyWith(...)` or `instanceOfPublicOptionDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PublicOptionDtoCWProxy get copyWith => _$PublicOptionDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicOptionDto _$PublicOptionDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PublicOptionDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'name', 'priceDelta']);
      final val = PublicOptionDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        priceDelta: $checkedConvert('priceDelta', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$PublicOptionDtoToJson(PublicOptionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'priceDelta': instance.priceDelta,
    };
