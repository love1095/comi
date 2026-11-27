// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UnreadDtoCWProxy {
  UnreadDto unread(num unread);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UnreadDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UnreadDto(...).copyWith(id: 12, name: "My name")
  /// ```
  UnreadDto call({num unread});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUnreadDto.copyWith(...)` or call `instanceOfUnreadDto.copyWith.fieldName(value)` for a single field.
class _$UnreadDtoCWProxyImpl implements _$UnreadDtoCWProxy {
  const _$UnreadDtoCWProxyImpl(this._value);

  final UnreadDto _value;

  @override
  UnreadDto unread(num unread) => call(unread: unread);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UnreadDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UnreadDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  UnreadDto call({Object? unread = const $CopyWithPlaceholder()}) {
    return UnreadDto(
      unread: unread == const $CopyWithPlaceholder() || unread == null
          ? _value.unread
          // ignore: cast_nullable_to_non_nullable
          : unread as num,
    );
  }
}

extension $UnreadDtoCopyWith on UnreadDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUnreadDto.copyWith(...)` or `instanceOfUnreadDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UnreadDtoCWProxy get copyWith => _$UnreadDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnreadDto _$UnreadDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UnreadDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['unread']);
      final val = UnreadDto(unread: $checkedConvert('unread', (v) => v as num));
      return val;
    });

Map<String, dynamic> _$UnreadDtoToJson(UnreadDto instance) => <String, dynamic>{
  'unread': instance.unread,
};
