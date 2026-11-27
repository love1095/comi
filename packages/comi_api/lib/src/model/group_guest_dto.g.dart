// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_guest_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GroupGuestDtoCWProxy {
  GroupGuestDto id(String id);

  GroupGuestDto displayName(String displayName);

  GroupGuestDto isHost(bool isHost);

  GroupGuestDto subtotal(num subtotal);

  GroupGuestDto amountDue(num amountDue);

  GroupGuestDto amountPaid(num amountPaid);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GroupGuestDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GroupGuestDto(...).copyWith(id: 12, name: "My name")
  /// ```
  GroupGuestDto call({
    String id,
    String displayName,
    bool isHost,
    num subtotal,
    num amountDue,
    num amountPaid,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGroupGuestDto.copyWith(...)` or call `instanceOfGroupGuestDto.copyWith.fieldName(value)` for a single field.
class _$GroupGuestDtoCWProxyImpl implements _$GroupGuestDtoCWProxy {
  const _$GroupGuestDtoCWProxyImpl(this._value);

  final GroupGuestDto _value;

  @override
  GroupGuestDto id(String id) => call(id: id);

  @override
  GroupGuestDto displayName(String displayName) =>
      call(displayName: displayName);

  @override
  GroupGuestDto isHost(bool isHost) => call(isHost: isHost);

  @override
  GroupGuestDto subtotal(num subtotal) => call(subtotal: subtotal);

  @override
  GroupGuestDto amountDue(num amountDue) => call(amountDue: amountDue);

  @override
  GroupGuestDto amountPaid(num amountPaid) => call(amountPaid: amountPaid);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GroupGuestDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GroupGuestDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GroupGuestDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? displayName = const $CopyWithPlaceholder(),
    Object? isHost = const $CopyWithPlaceholder(),
    Object? subtotal = const $CopyWithPlaceholder(),
    Object? amountDue = const $CopyWithPlaceholder(),
    Object? amountPaid = const $CopyWithPlaceholder(),
  }) {
    return GroupGuestDto(
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
      subtotal: subtotal == const $CopyWithPlaceholder() || subtotal == null
          ? _value.subtotal
          // ignore: cast_nullable_to_non_nullable
          : subtotal as num,
      amountDue: amountDue == const $CopyWithPlaceholder() || amountDue == null
          ? _value.amountDue
          // ignore: cast_nullable_to_non_nullable
          : amountDue as num,
      amountPaid:
          amountPaid == const $CopyWithPlaceholder() || amountPaid == null
          ? _value.amountPaid
          // ignore: cast_nullable_to_non_nullable
          : amountPaid as num,
    );
  }
}

extension $GroupGuestDtoCopyWith on GroupGuestDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGroupGuestDto.copyWith(...)` or `instanceOfGroupGuestDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GroupGuestDtoCWProxy get copyWith => _$GroupGuestDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupGuestDto _$GroupGuestDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GroupGuestDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'displayName',
          'isHost',
          'subtotal',
          'amountDue',
          'amountPaid',
        ],
      );
      final val = GroupGuestDto(
        id: $checkedConvert('id', (v) => v as String),
        displayName: $checkedConvert('displayName', (v) => v as String),
        isHost: $checkedConvert('isHost', (v) => v as bool),
        subtotal: $checkedConvert('subtotal', (v) => v as num),
        amountDue: $checkedConvert('amountDue', (v) => v as num),
        amountPaid: $checkedConvert('amountPaid', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$GroupGuestDtoToJson(GroupGuestDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'isHost': instance.isHost,
      'subtotal': instance.subtotal,
      'amountDue': instance.amountDue,
      'amountPaid': instance.amountPaid,
    };
