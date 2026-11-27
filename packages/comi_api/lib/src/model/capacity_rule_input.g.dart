// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capacity_rule_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CapacityRuleInputCWProxy {
  CapacityRuleInput weekdays(List<num> weekdays);

  CapacityRuleInput startMinute(num startMinute);

  CapacityRuleInput endMinute(num endMinute);

  CapacityRuleInput windowMinutes(num windowMinutes);

  CapacityRuleInput maxItems(num maxItems);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CapacityRuleInput(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CapacityRuleInput(...).copyWith(id: 12, name: "My name")
  /// ```
  CapacityRuleInput call({
    List<num> weekdays,
    num startMinute,
    num endMinute,
    num windowMinutes,
    num maxItems,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCapacityRuleInput.copyWith(...)` or call `instanceOfCapacityRuleInput.copyWith.fieldName(value)` for a single field.
class _$CapacityRuleInputCWProxyImpl implements _$CapacityRuleInputCWProxy {
  const _$CapacityRuleInputCWProxyImpl(this._value);

  final CapacityRuleInput _value;

  @override
  CapacityRuleInput weekdays(List<num> weekdays) => call(weekdays: weekdays);

  @override
  CapacityRuleInput startMinute(num startMinute) =>
      call(startMinute: startMinute);

  @override
  CapacityRuleInput endMinute(num endMinute) => call(endMinute: endMinute);

  @override
  CapacityRuleInput windowMinutes(num windowMinutes) =>
      call(windowMinutes: windowMinutes);

  @override
  CapacityRuleInput maxItems(num maxItems) => call(maxItems: maxItems);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CapacityRuleInput(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CapacityRuleInput(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CapacityRuleInput call({
    Object? weekdays = const $CopyWithPlaceholder(),
    Object? startMinute = const $CopyWithPlaceholder(),
    Object? endMinute = const $CopyWithPlaceholder(),
    Object? windowMinutes = const $CopyWithPlaceholder(),
    Object? maxItems = const $CopyWithPlaceholder(),
  }) {
    return CapacityRuleInput(
      weekdays: weekdays == const $CopyWithPlaceholder() || weekdays == null
          ? _value.weekdays
          // ignore: cast_nullable_to_non_nullable
          : weekdays as List<num>,
      startMinute:
          startMinute == const $CopyWithPlaceholder() || startMinute == null
          ? _value.startMinute
          // ignore: cast_nullable_to_non_nullable
          : startMinute as num,
      endMinute: endMinute == const $CopyWithPlaceholder() || endMinute == null
          ? _value.endMinute
          // ignore: cast_nullable_to_non_nullable
          : endMinute as num,
      windowMinutes:
          windowMinutes == const $CopyWithPlaceholder() || windowMinutes == null
          ? _value.windowMinutes
          // ignore: cast_nullable_to_non_nullable
          : windowMinutes as num,
      maxItems: maxItems == const $CopyWithPlaceholder() || maxItems == null
          ? _value.maxItems
          // ignore: cast_nullable_to_non_nullable
          : maxItems as num,
    );
  }
}

extension $CapacityRuleInputCopyWith on CapacityRuleInput {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCapacityRuleInput.copyWith(...)` or `instanceOfCapacityRuleInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CapacityRuleInputCWProxy get copyWith =>
      _$CapacityRuleInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CapacityRuleInput _$CapacityRuleInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CapacityRuleInput', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'weekdays',
          'startMinute',
          'endMinute',
          'windowMinutes',
          'maxItems',
        ],
      );
      final val = CapacityRuleInput(
        weekdays: $checkedConvert(
          'weekdays',
          (v) => (v as List<dynamic>).map((e) => e as num).toList(),
        ),
        startMinute: $checkedConvert('startMinute', (v) => v as num),
        endMinute: $checkedConvert('endMinute', (v) => v as num),
        windowMinutes: $checkedConvert('windowMinutes', (v) => v as num),
        maxItems: $checkedConvert('maxItems', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$CapacityRuleInputToJson(CapacityRuleInput instance) =>
    <String, dynamic>{
      'weekdays': instance.weekdays,
      'startMinute': instance.startMinute,
      'endMinute': instance.endMinute,
      'windowMinutes': instance.windowMinutes,
      'maxItems': instance.maxItems,
    };
