// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_table_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BookingTableDtoCWProxy {
  BookingTableDto id(String id);

  BookingTableDto code(String code);

  BookingTableDto areaId(String areaId);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BookingTableDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BookingTableDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BookingTableDto call({String id, String code, String areaId});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBookingTableDto.copyWith(...)` or call `instanceOfBookingTableDto.copyWith.fieldName(value)` for a single field.
class _$BookingTableDtoCWProxyImpl implements _$BookingTableDtoCWProxy {
  const _$BookingTableDtoCWProxyImpl(this._value);

  final BookingTableDto _value;

  @override
  BookingTableDto id(String id) => call(id: id);

  @override
  BookingTableDto code(String code) => call(code: code);

  @override
  BookingTableDto areaId(String areaId) => call(areaId: areaId);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BookingTableDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BookingTableDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BookingTableDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? areaId = const $CopyWithPlaceholder(),
  }) {
    return BookingTableDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      areaId: areaId == const $CopyWithPlaceholder() || areaId == null
          ? _value.areaId
          // ignore: cast_nullable_to_non_nullable
          : areaId as String,
    );
  }
}

extension $BookingTableDtoCopyWith on BookingTableDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBookingTableDto.copyWith(...)` or `instanceOfBookingTableDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BookingTableDtoCWProxy get copyWith => _$BookingTableDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingTableDto _$BookingTableDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BookingTableDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'code', 'areaId']);
      final val = BookingTableDto(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        areaId: $checkedConvert('areaId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$BookingTableDtoToJson(BookingTableDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'areaId': instance.areaId,
    };
