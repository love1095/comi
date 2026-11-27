// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_queue_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$KitchenQueueDtoCWProxy {
  KitchenQueueDto now(String now);

  KitchenQueueDto active(List<KitchenItemDto> active);

  KitchenQueueDto ready(List<KitchenItemDto> ready);

  KitchenQueueDto upcoming(List<KitchenItemDto> upcoming);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `KitchenQueueDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// KitchenQueueDto(...).copyWith(id: 12, name: "My name")
  /// ```
  KitchenQueueDto call({
    String now,
    List<KitchenItemDto> active,
    List<KitchenItemDto> ready,
    List<KitchenItemDto> upcoming,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfKitchenQueueDto.copyWith(...)` or call `instanceOfKitchenQueueDto.copyWith.fieldName(value)` for a single field.
class _$KitchenQueueDtoCWProxyImpl implements _$KitchenQueueDtoCWProxy {
  const _$KitchenQueueDtoCWProxyImpl(this._value);

  final KitchenQueueDto _value;

  @override
  KitchenQueueDto now(String now) => call(now: now);

  @override
  KitchenQueueDto active(List<KitchenItemDto> active) => call(active: active);

  @override
  KitchenQueueDto ready(List<KitchenItemDto> ready) => call(ready: ready);

  @override
  KitchenQueueDto upcoming(List<KitchenItemDto> upcoming) =>
      call(upcoming: upcoming);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `KitchenQueueDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// KitchenQueueDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  KitchenQueueDto call({
    Object? now = const $CopyWithPlaceholder(),
    Object? active = const $CopyWithPlaceholder(),
    Object? ready = const $CopyWithPlaceholder(),
    Object? upcoming = const $CopyWithPlaceholder(),
  }) {
    return KitchenQueueDto(
      now: now == const $CopyWithPlaceholder() || now == null
          ? _value.now
          // ignore: cast_nullable_to_non_nullable
          : now as String,
      active: active == const $CopyWithPlaceholder() || active == null
          ? _value.active
          // ignore: cast_nullable_to_non_nullable
          : active as List<KitchenItemDto>,
      ready: ready == const $CopyWithPlaceholder() || ready == null
          ? _value.ready
          // ignore: cast_nullable_to_non_nullable
          : ready as List<KitchenItemDto>,
      upcoming: upcoming == const $CopyWithPlaceholder() || upcoming == null
          ? _value.upcoming
          // ignore: cast_nullable_to_non_nullable
          : upcoming as List<KitchenItemDto>,
    );
  }
}

extension $KitchenQueueDtoCopyWith on KitchenQueueDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfKitchenQueueDto.copyWith(...)` or `instanceOfKitchenQueueDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$KitchenQueueDtoCWProxy get copyWith => _$KitchenQueueDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KitchenQueueDto _$KitchenQueueDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('KitchenQueueDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['now', 'active', 'ready', 'upcoming'],
      );
      final val = KitchenQueueDto(
        now: $checkedConvert('now', (v) => v as String),
        active: $checkedConvert(
          'active',
          (v) => (v as List<dynamic>)
              .map((e) => KitchenItemDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        ready: $checkedConvert(
          'ready',
          (v) => (v as List<dynamic>)
              .map((e) => KitchenItemDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        upcoming: $checkedConvert(
          'upcoming',
          (v) => (v as List<dynamic>)
              .map((e) => KitchenItemDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$KitchenQueueDtoToJson(KitchenQueueDto instance) =>
    <String, dynamic>{
      'now': instance.now,
      'active': instance.active.map((e) => e.toJson()).toList(),
      'ready': instance.ready.map((e) => e.toJson()).toList(),
      'upcoming': instance.upcoming.map((e) => e.toJson()).toList(),
    };
