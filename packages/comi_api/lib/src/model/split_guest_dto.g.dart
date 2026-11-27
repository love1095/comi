// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'split_guest_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SplitGuestDtoCWProxy {
  SplitGuestDto id(String id);

  SplitGuestDto displayName(String displayName);

  SplitGuestDto isHost(bool isHost);

  SplitGuestDto amountDue(num amountDue);

  SplitGuestDto amountPaid(num amountPaid);

  SplitGuestDto paidAt(String? paidAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SplitGuestDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SplitGuestDto(...).copyWith(id: 12, name: "My name")
  /// ```
  SplitGuestDto call({
    String id,
    String displayName,
    bool isHost,
    num amountDue,
    num amountPaid,
    String? paidAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSplitGuestDto.copyWith(...)` or call `instanceOfSplitGuestDto.copyWith.fieldName(value)` for a single field.
class _$SplitGuestDtoCWProxyImpl implements _$SplitGuestDtoCWProxy {
  const _$SplitGuestDtoCWProxyImpl(this._value);

  final SplitGuestDto _value;

  @override
  SplitGuestDto id(String id) => call(id: id);

  @override
  SplitGuestDto displayName(String displayName) =>
      call(displayName: displayName);

  @override
  SplitGuestDto isHost(bool isHost) => call(isHost: isHost);

  @override
  SplitGuestDto amountDue(num amountDue) => call(amountDue: amountDue);

  @override
  SplitGuestDto amountPaid(num amountPaid) => call(amountPaid: amountPaid);

  @override
  SplitGuestDto paidAt(String? paidAt) => call(paidAt: paidAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `SplitGuestDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SplitGuestDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  SplitGuestDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? displayName = const $CopyWithPlaceholder(),
    Object? isHost = const $CopyWithPlaceholder(),
    Object? amountDue = const $CopyWithPlaceholder(),
    Object? amountPaid = const $CopyWithPlaceholder(),
    Object? paidAt = const $CopyWithPlaceholder(),
  }) {
    return SplitGuestDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      displayName:
          displayName == const $CopyWithPlaceholder() || displayName == null
          ? _value.displayName
          // ignore: cast_nullable_to_non_nullable
          : displayName as String,
      isHost: isHost == const $CopyWithPlaceholder() || isHost == null
          ? _value.isHost
          // ignore: cast_nullable_to_non_nullable
          : isHost as bool,
      amountDue: amountDue == const $CopyWithPlaceholder() || amountDue == null
          ? _value.amountDue
          // ignore: cast_nullable_to_non_nullable
          : amountDue as num,
      amountPaid:
          amountPaid == const $CopyWithPlaceholder() || amountPaid == null
          ? _value.amountPaid
          // ignore: cast_nullable_to_non_nullable
          : amountPaid as num,
      paidAt: paidAt == const $CopyWithPlaceholder()
          ? _value.paidAt
          // ignore: cast_nullable_to_non_nullable
          : paidAt as String?,
    );
  }
}

extension $SplitGuestDtoCopyWith on SplitGuestDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSplitGuestDto.copyWith(...)` or `instanceOfSplitGuestDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SplitGuestDtoCWProxy get copyWith => _$SplitGuestDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplitGuestDto _$SplitGuestDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SplitGuestDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'displayName',
          'isHost',
          'amountDue',
          'amountPaid',
        ],
      );
      final val = SplitGuestDto(
        id: $checkedConvert('id', (v) => v as String),
        displayName: $checkedConvert('displayName', (v) => v as String),
        isHost: $checkedConvert('isHost', (v) => v as bool),
        amountDue: $checkedConvert('amountDue', (v) => v as num),
        amountPaid: $checkedConvert('amountPaid', (v) => v as num),
        paidAt: $checkedConvert('paidAt', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$SplitGuestDtoToJson(SplitGuestDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'isHost': instance.isHost,
      'amountDue': instance.amountDue,
      'amountPaid': instance.amountPaid,
      'paidAt': ?instance.paidAt,
    };
