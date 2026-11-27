// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_page_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationPageDtoCWProxy {
  NotificationPageDto items(List<NotificationDto> items);

  NotificationPageDto unread(num unread);

  NotificationPageDto nextCursor(String? nextCursor);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `NotificationPageDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationPageDto(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationPageDto call({
    List<NotificationDto> items,
    num unread,
    String? nextCursor,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationPageDto.copyWith(...)` or call `instanceOfNotificationPageDto.copyWith.fieldName(value)` for a single field.
class _$NotificationPageDtoCWProxyImpl implements _$NotificationPageDtoCWProxy {
  const _$NotificationPageDtoCWProxyImpl(this._value);

  final NotificationPageDto _value;

  @override
  NotificationPageDto items(List<NotificationDto> items) => call(items: items);

  @override
  NotificationPageDto unread(num unread) => call(unread: unread);

  @override
  NotificationPageDto nextCursor(String? nextCursor) =>
      call(nextCursor: nextCursor);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `NotificationPageDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationPageDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  NotificationPageDto call({
    Object? items = const $CopyWithPlaceholder(),
    Object? unread = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return NotificationPageDto(
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<NotificationDto>,
      unread: unread == const $CopyWithPlaceholder() || unread == null
          ? _value.unread
          // ignore: cast_nullable_to_non_nullable
          : unread as num,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as String?,
    );
  }
}

extension $NotificationPageDtoCopyWith on NotificationPageDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationPageDto.copyWith(...)` or `instanceOfNotificationPageDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationPageDtoCWProxy get copyWith =>
      _$NotificationPageDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPageDto _$NotificationPageDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NotificationPageDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items', 'unread']);
      final val = NotificationPageDto(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => NotificationDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        unread: $checkedConvert('unread', (v) => v as num),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$NotificationPageDtoToJson(
  NotificationPageDto instance,
) => <String, dynamic>{
  'items': instance.items.map((e) => e.toJson()).toList(),
  'unread': instance.unread,
  'nextCursor': ?instance.nextCursor,
};
