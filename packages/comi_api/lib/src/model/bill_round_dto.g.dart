// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_round_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BillRoundDtoCWProxy {
  BillRoundDto round(num round);

  BillRoundDto waitingForStaff(bool waitingForStaff);

  BillRoundDto subtotal(num subtotal);

  BillRoundDto items(List<BoardOrderItemDto> items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BillRoundDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BillRoundDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BillRoundDto call({
    num round,
    bool waitingForStaff,
    num subtotal,
    List<BoardOrderItemDto> items,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBillRoundDto.copyWith(...)` or call `instanceOfBillRoundDto.copyWith.fieldName(value)` for a single field.
class _$BillRoundDtoCWProxyImpl implements _$BillRoundDtoCWProxy {
  const _$BillRoundDtoCWProxyImpl(this._value);

  final BillRoundDto _value;

  @override
  BillRoundDto round(num round) => call(round: round);

  @override
  BillRoundDto waitingForStaff(bool waitingForStaff) =>
      call(waitingForStaff: waitingForStaff);

  @override
  BillRoundDto subtotal(num subtotal) => call(subtotal: subtotal);

  @override
  BillRoundDto items(List<BoardOrderItemDto> items) => call(items: items);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BillRoundDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BillRoundDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BillRoundDto call({
    Object? round = const $CopyWithPlaceholder(),
    Object? waitingForStaff = const $CopyWithPlaceholder(),
    Object? subtotal = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return BillRoundDto(
      round: round == const $CopyWithPlaceholder() || round == null
          ? _value.round
          // ignore: cast_nullable_to_non_nullable
          : round as num,
      waitingForStaff:
          waitingForStaff == const $CopyWithPlaceholder() ||
              waitingForStaff == null
          ? _value.waitingForStaff
          // ignore: cast_nullable_to_non_nullable
          : waitingForStaff as bool,
      subtotal: subtotal == const $CopyWithPlaceholder() || subtotal == null
          ? _value.subtotal
          // ignore: cast_nullable_to_non_nullable
          : subtotal as num,
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<BoardOrderItemDto>,
    );
  }
}

extension $BillRoundDtoCopyWith on BillRoundDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBillRoundDto.copyWith(...)` or `instanceOfBillRoundDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BillRoundDtoCWProxy get copyWith => _$BillRoundDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillRoundDto _$BillRoundDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BillRoundDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['round', 'waitingForStaff', 'subtotal', 'items'],
      );
      final val = BillRoundDto(
        round: $checkedConvert('round', (v) => v as num),
        waitingForStaff: $checkedConvert('waitingForStaff', (v) => v as bool),
        subtotal: $checkedConvert('subtotal', (v) => v as num),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => BoardOrderItemDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BillRoundDtoToJson(BillRoundDto instance) =>
    <String, dynamic>{
      'round': instance.round,
      'waitingForStaff': instance.waitingForStaff,
      'subtotal': instance.subtotal,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
