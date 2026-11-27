// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_key_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GuestKeyDtoCWProxy {
  GuestKeyDto guestKey(String guestKey);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GuestKeyDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GuestKeyDto(...).copyWith(id: 12, name: "My name")
  /// ```
  GuestKeyDto call({String guestKey});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGuestKeyDto.copyWith(...)` or call `instanceOfGuestKeyDto.copyWith.fieldName(value)` for a single field.
class _$GuestKeyDtoCWProxyImpl implements _$GuestKeyDtoCWProxy {
  const _$GuestKeyDtoCWProxyImpl(this._value);

  final GuestKeyDto _value;

  @override
  GuestKeyDto guestKey(String guestKey) => call(guestKey: guestKey);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GuestKeyDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GuestKeyDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GuestKeyDto call({Object? guestKey = const $CopyWithPlaceholder()}) {
    return GuestKeyDto(
      guestKey: guestKey == const $CopyWithPlaceholder() || guestKey == null
          ? _value.guestKey
          // ignore: cast_nullable_to_non_nullable
          : guestKey as String,
    );
  }
}

extension $GuestKeyDtoCopyWith on GuestKeyDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGuestKeyDto.copyWith(...)` or `instanceOfGuestKeyDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GuestKeyDtoCWProxy get copyWith => _$GuestKeyDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestKeyDto _$GuestKeyDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GuestKeyDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['guestKey']);
      final val = GuestKeyDto(
        guestKey: $checkedConvert('guestKey', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$GuestKeyDtoToJson(GuestKeyDto instance) =>
    <String, dynamic>{'guestKey': instance.guestKey};
