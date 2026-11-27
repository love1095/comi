// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_user_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BoardUserDtoCWProxy {
  BoardUserDto id(String id);

  BoardUserDto name(String? name);

  BoardUserDto phone(String? phone);

  BoardUserDto noShowCount(num noShowCount);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BoardUserDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BoardUserDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BoardUserDto call({String id, String? name, String? phone, num noShowCount});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBoardUserDto.copyWith(...)` or call `instanceOfBoardUserDto.copyWith.fieldName(value)` for a single field.
class _$BoardUserDtoCWProxyImpl implements _$BoardUserDtoCWProxy {
  const _$BoardUserDtoCWProxyImpl(this._value);

  final BoardUserDto _value;

  @override
  BoardUserDto id(String id) => call(id: id);

  @override
  BoardUserDto name(String? name) => call(name: name);

  @override
  BoardUserDto phone(String? phone) => call(phone: phone);

  @override
  BoardUserDto noShowCount(num noShowCount) => call(noShowCount: noShowCount);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BoardUserDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BoardUserDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BoardUserDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? noShowCount = const $CopyWithPlaceholder(),
  }) {
    return BoardUserDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      noShowCount:
          noShowCount == const $CopyWithPlaceholder() || noShowCount == null
          ? _value.noShowCount
          // ignore: cast_nullable_to_non_nullable
          : noShowCount as num,
    );
  }
}

extension $BoardUserDtoCopyWith on BoardUserDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBoardUserDto.copyWith(...)` or `instanceOfBoardUserDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BoardUserDtoCWProxy get copyWith => _$BoardUserDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardUserDto _$BoardUserDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BoardUserDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'noShowCount']);
      final val = BoardUserDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String?),
        phone: $checkedConvert('phone', (v) => v as String?),
        noShowCount: $checkedConvert('noShowCount', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$BoardUserDtoToJson(BoardUserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': ?instance.name,
      'phone': ?instance.phone,
      'noShowCount': instance.noShowCount,
    };
