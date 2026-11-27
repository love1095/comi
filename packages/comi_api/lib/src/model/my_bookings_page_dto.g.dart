// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_bookings_page_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MyBookingsPageDtoCWProxy {
  MyBookingsPageDto items(List<CustomerBookingDto> items);

  MyBookingsPageDto nextCursor(String? nextCursor);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MyBookingsPageDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MyBookingsPageDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MyBookingsPageDto call({List<CustomerBookingDto> items, String? nextCursor});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMyBookingsPageDto.copyWith(...)` or call `instanceOfMyBookingsPageDto.copyWith.fieldName(value)` for a single field.
class _$MyBookingsPageDtoCWProxyImpl implements _$MyBookingsPageDtoCWProxy {
  const _$MyBookingsPageDtoCWProxyImpl(this._value);

  final MyBookingsPageDto _value;

  @override
  MyBookingsPageDto items(List<CustomerBookingDto> items) => call(items: items);

  @override
  MyBookingsPageDto nextCursor(String? nextCursor) =>
      call(nextCursor: nextCursor);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MyBookingsPageDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MyBookingsPageDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MyBookingsPageDto call({
    Object? items = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return MyBookingsPageDto(
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<CustomerBookingDto>,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as String?,
    );
  }
}

extension $MyBookingsPageDtoCopyWith on MyBookingsPageDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMyBookingsPageDto.copyWith(...)` or `instanceOfMyBookingsPageDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MyBookingsPageDtoCWProxy get copyWith =>
      _$MyBookingsPageDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBookingsPageDto _$MyBookingsPageDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MyBookingsPageDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = MyBookingsPageDto(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map(
                (e) => CustomerBookingDto.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$MyBookingsPageDtoToJson(MyBookingsPageDto instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'nextCursor': ?instance.nextCursor,
    };
