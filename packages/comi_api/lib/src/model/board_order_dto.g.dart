// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_order_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BoardOrderDtoCWProxy {
  BoardOrderDto total(num total);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BoardOrderDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BoardOrderDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BoardOrderDto call({num total});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBoardOrderDto.copyWith(...)` or call `instanceOfBoardOrderDto.copyWith.fieldName(value)` for a single field.
class _$BoardOrderDtoCWProxyImpl implements _$BoardOrderDtoCWProxy {
  const _$BoardOrderDtoCWProxyImpl(this._value);

  final BoardOrderDto _value;

  @override
  BoardOrderDto total(num total) => call(total: total);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BoardOrderDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BoardOrderDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BoardOrderDto call({Object? total = const $CopyWithPlaceholder()}) {
    return BoardOrderDto(
      total: total == const $CopyWithPlaceholder() || total == null
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as num,
    );
  }
}

extension $BoardOrderDtoCopyWith on BoardOrderDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBoardOrderDto.copyWith(...)` or `instanceOfBoardOrderDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BoardOrderDtoCWProxy get copyWith => _$BoardOrderDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardOrderDto _$BoardOrderDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BoardOrderDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['total']);
      final val = BoardOrderDto(
        total: $checkedConvert('total', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$BoardOrderDtoToJson(BoardOrderDto instance) =>
    <String, dynamic>{'total': instance.total};
