// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capacity_rules_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CapacityRulesDtoCWProxy {
  CapacityRulesDto rules(List<CapacityRuleInput> rules);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CapacityRulesDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CapacityRulesDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CapacityRulesDto call({List<CapacityRuleInput> rules});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCapacityRulesDto.copyWith(...)` or call `instanceOfCapacityRulesDto.copyWith.fieldName(value)` for a single field.
class _$CapacityRulesDtoCWProxyImpl implements _$CapacityRulesDtoCWProxy {
  const _$CapacityRulesDtoCWProxyImpl(this._value);

  final CapacityRulesDto _value;

  @override
  CapacityRulesDto rules(List<CapacityRuleInput> rules) => call(rules: rules);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CapacityRulesDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CapacityRulesDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CapacityRulesDto call({Object? rules = const $CopyWithPlaceholder()}) {
    return CapacityRulesDto(
      rules: rules == const $CopyWithPlaceholder() || rules == null
          ? _value.rules
          // ignore: cast_nullable_to_non_nullable
          : rules as List<CapacityRuleInput>,
    );
  }
}

extension $CapacityRulesDtoCopyWith on CapacityRulesDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCapacityRulesDto.copyWith(...)` or `instanceOfCapacityRulesDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CapacityRulesDtoCWProxy get copyWith => _$CapacityRulesDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CapacityRulesDto _$CapacityRulesDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CapacityRulesDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['rules']);
      final val = CapacityRulesDto(
        rules: $checkedConvert(
          'rules',
          (v) => (v as List<dynamic>)
              .map((e) => CapacityRuleInput.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CapacityRulesDtoToJson(CapacityRulesDto instance) =>
    <String, dynamic>{'rules': instance.rules.map((e) => e.toJson()).toList()};
