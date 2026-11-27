// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dining_rule_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DiningRuleDtoCWProxy {
  DiningRuleDto weekdays(List<String> weekdays);

  DiningRuleDto startMinute(num startMinute);

  DiningRuleDto endMinute(num endMinute);

  DiningRuleDto diningMinutes(num diningMinutes);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `DiningRuleDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DiningRuleDto(...).copyWith(id: 12, name: "My name")
  /// ```
  DiningRuleDto call({
    List<String> weekdays,
    num startMinute,
    num endMinute,
    num diningMinutes,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDiningRuleDto.copyWith(...)` or call `instanceOfDiningRuleDto.copyWith.fieldName(value)` for a single field.
class _$DiningRuleDtoCWProxyImpl implements _$DiningRuleDtoCWProxy {
  const _$DiningRuleDtoCWProxyImpl(this._value);

  final DiningRuleDto _value;

  @override
  DiningRuleDto weekdays(List<String> weekdays) => call(weekdays: weekdays);

  @override
  DiningRuleDto startMinute(num startMinute) => call(startMinute: startMinute);

  @override
  DiningRuleDto endMinute(num endMinute) => call(endMinute: endMinute);

  @override
  DiningRuleDto diningMinutes(num diningMinutes) =>
      call(diningMinutes: diningMinutes);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `DiningRuleDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DiningRuleDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  DiningRuleDto call({
    Object? weekdays = const $CopyWithPlaceholder(),
    Object? startMinute = const $CopyWithPlaceholder(),
    Object? endMinute = const $CopyWithPlaceholder(),
    Object? diningMinutes = const $CopyWithPlaceholder(),
  }) {
    return DiningRuleDto(
      weekdays: weekdays == const $CopyWithPlaceholder() || weekdays == null
          ? _value.weekdays
          // ignore: cast_nullable_to_non_nullable
          : weekdays as List<String>,
      startMinute:
          startMinute == const $CopyWithPlaceholder() || startMinute == null
          ? _value.startMinute
          // ignore: cast_nullable_to_non_nullable
          : startMinute as num,
      endMinute: endMinute == const $CopyWithPlaceholder() || endMinute == null
          ? _value.endMinute
          // ignore: cast_nullable_to_non_nullable
          : endMinute as num,
      diningMinutes:
          diningMinutes == const $CopyWithPlaceholder() || diningMinutes == null
          ? _value.diningMinutes
          // ignore: cast_nullable_to_non_nullable
          : diningMinutes as num,
    );
  }
}

extension $DiningRuleDtoCopyWith on DiningRuleDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDiningRuleDto.copyWith(...)` or `instanceOfDiningRuleDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DiningRuleDtoCWProxy get copyWith => _$DiningRuleDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiningRuleDto _$DiningRuleDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DiningRuleDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'weekdays',
          'startMinute',
          'endMinute',
          'diningMinutes',
        ],
      );
      final val = DiningRuleDto(
        weekdays: $checkedConvert(
          'weekdays',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        startMinute: $checkedConvert('startMinute', (v) => v as num),
        endMinute: $checkedConvert('endMinute', (v) => v as num),
        diningMinutes: $checkedConvert('diningMinutes', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$DiningRuleDtoToJson(DiningRuleDto instance) =>
    <String, dynamic>{
      'weekdays': instance.weekdays,
      'startMinute': instance.startMinute,
      'endMinute': instance.endMinute,
      'diningMinutes': instance.diningMinutes,
    };
