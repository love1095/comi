// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capacity_rule_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CapacityRuleDtoCWProxy {
  CapacityRuleDto weekdays(List<num> weekdays);

  CapacityRuleDto startMinute(num startMinute);

  CapacityRuleDto endMinute(num endMinute);

  CapacityRuleDto windowMinutes(num windowMinutes);

  CapacityRuleDto maxItems(num maxItems);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CapacityRuleDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CapacityRuleDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CapacityRuleDto call({
    List<num> weekdays,
    num startMinute,
    num endMinute,
    num windowMinutes,
    num maxItems,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCapacityRuleDto.copyWith(...)` or call `instanceOfCapacityRuleDto.copyWith.fieldName(value)` for a single field.
class _$CapacityRuleDtoCWProxyImpl implements _$CapacityRuleDtoCWProxy {
  const _$CapacityRuleDtoCWProxyImpl(this._value);

  final CapacityRuleDto _value;

  @override
  CapacityRuleDto weekdays(List<num> weekdays) => call(weekdays: weekdays);

  @override
  CapacityRuleDto startMinute(num startMinute) =>
      call(startMinute: startMinute);

  @override
  CapacityRuleDto endMinute(num endMinute) => call(endMinute: endMinute);

  @override
  CapacityRuleDto windowMinutes(num windowMinutes) =>
      call(windowMinutes: windowMinutes);

  @override
  CapacityRuleDto maxItems(num maxItems) => call(maxItems: maxItems);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CapacityRuleDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CapacityRuleDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CapacityRuleDto call({
    Object? weekdays = const $CopyWithPlaceholder(),
    Object? startMinute = const $CopyWithPlaceholder(),
    Object? endMinute = const $CopyWithPlaceholder(),
    Object? windowMinutes = const $CopyWithPlaceholder(),
    Object? maxItems = const $CopyWithPlaceholder(),
  }) {
    return CapacityRuleDto(
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

extension $CapacityRuleDtoCopyWith on CapacityRuleDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCapacityRuleDto.copyWith(...)` or `instanceOfCapacityRuleDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CapacityRuleDtoCWProxy get copyWith => _$CapacityRuleDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CapacityRuleDto _$CapacityRuleDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CapacityRuleDto', json, ($checkedConvert) {
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
      final val = CapacityRuleDto(
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

Map<String, dynamic> _$CapacityRuleDtoToJson(CapacityRuleDto instance) =>
    <String, dynamic>{
      'weekdays': instance.weekdays,
      'startMinute': instance.startMinute,
      'endMinute': instance.endMinute,
      'windowMinutes': instance.windowMinutes,
      'maxItems': instance.maxItems,
    };
