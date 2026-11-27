// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_key_pay_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GuestKeyPayDtoCWProxy {
  GuestKeyPayDto guestKey(String guestKey);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GuestKeyPayDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GuestKeyPayDto(...).copyWith(id: 12, name: "My name")
  /// ```
  GuestKeyPayDto call({String guestKey});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGuestKeyPayDto.copyWith(...)` or call `instanceOfGuestKeyPayDto.copyWith.fieldName(value)` for a single field.
class _$GuestKeyPayDtoCWProxyImpl implements _$GuestKeyPayDtoCWProxy {
  const _$GuestKeyPayDtoCWProxyImpl(this._value);

  final GuestKeyPayDto _value;

  @override
  GuestKeyPayDto guestKey(String guestKey) => call(guestKey: guestKey);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GuestKeyPayDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GuestKeyPayDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GuestKeyPayDto call({Object? guestKey = const $CopyWithPlaceholder()}) {
    return GuestKeyPayDto(
      guestKey: guestKey == const $CopyWithPlaceholder() || guestKey == null
          ? _value.guestKey
          // ignore: cast_nullable_to_non_nullable
          : guestKey as String,
    );
  }
}

extension $GuestKeyPayDtoCopyWith on GuestKeyPayDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGuestKeyPayDto.copyWith(...)` or `instanceOfGuestKeyPayDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GuestKeyPayDtoCWProxy get copyWith => _$GuestKeyPayDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestKeyPayDto _$GuestKeyPayDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GuestKeyPayDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['guestKey']);
      final val = GuestKeyPayDto(
        guestKey: $checkedConvert('guestKey', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$GuestKeyPayDtoToJson(GuestKeyPayDto instance) =>
    <String, dynamic>{'guestKey': instance.guestKey};
