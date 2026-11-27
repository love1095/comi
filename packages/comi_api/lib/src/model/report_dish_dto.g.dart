// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_dish_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportDishDtoCWProxy {
  ReportDishDto name(String name);

  ReportDishDto quantity(num quantity);

  ReportDishDto revenue(num revenue);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReportDishDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReportDishDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ReportDishDto call({String name, num quantity, num revenue});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReportDishDto.copyWith(...)` or call `instanceOfReportDishDto.copyWith.fieldName(value)` for a single field.
class _$ReportDishDtoCWProxyImpl implements _$ReportDishDtoCWProxy {
  const _$ReportDishDtoCWProxyImpl(this._value);

  final ReportDishDto _value;

  @override
  ReportDishDto name(String name) => call(name: name);

  @override
  ReportDishDto quantity(num quantity) => call(quantity: quantity);

  @override
  ReportDishDto revenue(num revenue) => call(revenue: revenue);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReportDishDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReportDishDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ReportDishDto call({
    Object? name = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
  }) {
    return ReportDishDto(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      quantity: quantity == const $CopyWithPlaceholder() || quantity == null
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as num,
      revenue: revenue == const $CopyWithPlaceholder() || revenue == null
          ? _value.revenue
          // ignore: cast_nullable_to_non_nullable
          : revenue as num,
    );
  }
}

extension $ReportDishDtoCopyWith on ReportDishDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReportDishDto.copyWith(...)` or `instanceOfReportDishDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReportDishDtoCWProxy get copyWith => _$ReportDishDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportDishDto _$ReportDishDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReportDishDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['name', 'quantity', 'revenue']);
      final val = ReportDishDto(
        name: $checkedConvert('name', (v) => v as String),
        quantity: $checkedConvert('quantity', (v) => v as num),
        revenue: $checkedConvert('revenue', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$ReportDishDtoToJson(ReportDishDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'revenue': instance.revenue,
    };
