// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_group_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$JoinGroupDtoCWProxy {
  JoinGroupDto displayName(String displayName);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `JoinGroupDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// JoinGroupDto(...).copyWith(id: 12, name: "My name")
  /// ```
  JoinGroupDto call({String displayName});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfJoinGroupDto.copyWith(...)` or call `instanceOfJoinGroupDto.copyWith.fieldName(value)` for a single field.
class _$JoinGroupDtoCWProxyImpl implements _$JoinGroupDtoCWProxy {
  const _$JoinGroupDtoCWProxyImpl(this._value);

  final JoinGroupDto _value;

  @override
  JoinGroupDto displayName(String displayName) =>
      call(displayName: displayName);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `JoinGroupDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// JoinGroupDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  JoinGroupDto call({Object? displayName = const $CopyWithPlaceholder()}) {
    return JoinGroupDto(
      displayName:
          displayName == const $CopyWithPlaceholder() || displayName == null
          ? _value.displayName
          // ignore: cast_nullable_to_non_nullable
          : displayName as String,
    );
  }
}

extension $JoinGroupDtoCopyWith on JoinGroupDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfJoinGroupDto.copyWith(...)` or `instanceOfJoinGroupDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$JoinGroupDtoCWProxy get copyWith => _$JoinGroupDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinGroupDto _$JoinGroupDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JoinGroupDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['displayName']);
      final val = JoinGroupDto(
        displayName: $checkedConvert('displayName', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$JoinGroupDtoToJson(JoinGroupDto instance) =>
    <String, dynamic>{'displayName': instance.displayName};
