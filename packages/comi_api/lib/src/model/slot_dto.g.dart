// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SlotDtoCWProxy {
  SlotDto time(String time);

  SlotDto local(String local);

  SlotDto available(bool available);

  SlotDto diningMinutes(num diningMinutes);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SlotDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SlotDto(...).copyWith(id: 12, name: "My name")
  /// ```
  SlotDto call({String time, String local, bool available, num diningMinutes});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSlotDto.copyWith(...)` or call `instanceOfSlotDto.copyWith.fieldName(value)` for a single field.
class _$SlotDtoCWProxyImpl implements _$SlotDtoCWProxy {
  const _$SlotDtoCWProxyImpl(this._value);

  final SlotDto _value;

  @override
  SlotDto time(String time) => call(time: time);

  @override
  SlotDto local(String local) => call(local: local);

  @override
  SlotDto available(bool available) => call(available: available);

  @override
  SlotDto diningMinutes(num diningMinutes) =>
      call(diningMinutes: diningMinutes);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SlotDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SlotDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  SlotDto call({
    Object? time = const $CopyWithPlaceholder(),
    Object? local = const $CopyWithPlaceholder(),
    Object? available = const $CopyWithPlaceholder(),
    Object? diningMinutes = const $CopyWithPlaceholder(),
  }) {
    return SlotDto(
      time: time == const $CopyWithPlaceholder() || time == null
          ? _value.time
          // ignore: cast_nullable_to_non_nullable
          : time as String,
      local: local == const $CopyWithPlaceholder() || local == null
          ? _value.local
          // ignore: cast_nullable_to_non_nullable
          : local as String,
      available: available == const $CopyWithPlaceholder() || available == null
          ? _value.available
          // ignore: cast_nullable_to_non_nullable
          : available as bool,
      diningMinutes:
          diningMinutes == const $CopyWithPlaceholder() || diningMinutes == null
          ? _value.diningMinutes
          // ignore: cast_nullable_to_non_nullable
          : diningMinutes as num,
    );
  }
}

extension $SlotDtoCopyWith on SlotDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSlotDto.copyWith(...)` or `instanceOfSlotDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SlotDtoCWProxy get copyWith => _$SlotDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlotDto _$SlotDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SlotDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['time', 'local', 'available', 'diningMinutes'],
      );
      final val = SlotDto(
        time: $checkedConvert('time', (v) => v as String),
        local: $checkedConvert('local', (v) => v as String),
        available: $checkedConvert('available', (v) => v as bool),
        diningMinutes: $checkedConvert('diningMinutes', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$SlotDtoToJson(SlotDto instance) => <String, dynamic>{
  'time': instance.time,
  'local': instance.local,
  'available': instance.available,
  'diningMinutes': instance.diningMinutes,
};
