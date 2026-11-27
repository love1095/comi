// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationDtoCWProxy {
  NotificationDto id(String id);

  NotificationDto type(String type);

  NotificationDto title(String title);

  NotificationDto body(String body);

  NotificationDto bookingId(String? bookingId);

  NotificationDto readAt(String? readAt);

  NotificationDto createdAt(String createdAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `NotificationDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationDto(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationDto call({
    String id,
    String type,
    String title,
    String body,
    String? bookingId,
    String? readAt,
    String createdAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationDto.copyWith(...)` or call `instanceOfNotificationDto.copyWith.fieldName(value)` for a single field.
class _$NotificationDtoCWProxyImpl implements _$NotificationDtoCWProxy {
  const _$NotificationDtoCWProxyImpl(this._value);

  final NotificationDto _value;

  @override
  NotificationDto id(String id) => call(id: id);

  @override
  NotificationDto type(String type) => call(type: type);

  @override
  NotificationDto title(String title) => call(title: title);

  @override
  NotificationDto body(String body) => call(body: body);

  @override
  NotificationDto bookingId(String? bookingId) => call(bookingId: bookingId);

  @override
  NotificationDto readAt(String? readAt) => call(readAt: readAt);

  @override
  NotificationDto createdAt(String createdAt) => call(createdAt: createdAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `NotificationDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  NotificationDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? body = const $CopyWithPlaceholder(),
    Object? bookingId = const $CopyWithPlaceholder(),
    Object? readAt = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return NotificationDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      body: body == const $CopyWithPlaceholder() || body == null
          ? _value.body
          // ignore: cast_nullable_to_non_nullable
          : body as String,
      bookingId: bookingId == const $CopyWithPlaceholder()
          ? _value.bookingId
          // ignore: cast_nullable_to_non_nullable
          : bookingId as String?,
      readAt: readAt == const $CopyWithPlaceholder()
          ? _value.readAt
          // ignore: cast_nullable_to_non_nullable
          : readAt as String?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String,
    );
  }
}

extension $NotificationDtoCopyWith on NotificationDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationDto.copyWith(...)` or `instanceOfNotificationDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationDtoCWProxy get copyWith => _$NotificationDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NotificationDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['id', 'type', 'title', 'body', 'createdAt'],
      );
      final val = NotificationDto(
        id: $checkedConvert('id', (v) => v as String),
        type: $checkedConvert('type', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        body: $checkedConvert('body', (v) => v as String),
        bookingId: $checkedConvert('bookingId', (v) => v as String?),
        readAt: $checkedConvert('readAt', (v) => v as String?),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$NotificationDtoToJson(NotificationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'body': instance.body,
      'bookingId': ?instance.bookingId,
      'readAt': ?instance.readAt,
      'createdAt': instance.createdAt,
    };
