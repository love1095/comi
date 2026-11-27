// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_cancel_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RestaurantCancelDtoCWProxy {
  RestaurantCancelDto reason(String reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RestaurantCancelDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RestaurantCancelDto(...).copyWith(id: 12, name: "My name")
  /// ```
  RestaurantCancelDto call({String reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRestaurantCancelDto.copyWith(...)` or call `instanceOfRestaurantCancelDto.copyWith.fieldName(value)` for a single field.
class _$RestaurantCancelDtoCWProxyImpl implements _$RestaurantCancelDtoCWProxy {
  const _$RestaurantCancelDtoCWProxyImpl(this._value);

  final RestaurantCancelDto _value;

  @override
  RestaurantCancelDto reason(String reason) => call(reason: reason);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `RestaurantCancelDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RestaurantCancelDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RestaurantCancelDto call({Object? reason = const $CopyWithPlaceholder()}) {
    return RestaurantCancelDto(
      reason: reason == const $CopyWithPlaceholder() || reason == null
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $RestaurantCancelDtoCopyWith on RestaurantCancelDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRestaurantCancelDto.copyWith(...)` or `instanceOfRestaurantCancelDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RestaurantCancelDtoCWProxy get copyWith =>
      _$RestaurantCancelDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantCancelDto _$RestaurantCancelDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RestaurantCancelDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['reason']);
      final val = RestaurantCancelDto(
        reason: $checkedConvert('reason', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RestaurantCancelDtoToJson(
  RestaurantCancelDto instance,
) => <String, dynamic>{'reason': instance.reason};
