// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DecisionDtoCWProxy {
  DecisionDto hide_(bool hide_);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `DecisionDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DecisionDto(...).copyWith(id: 12, name: "My name")
  /// ```
  DecisionDto call({bool hide_});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDecisionDto.copyWith(...)` or call `instanceOfDecisionDto.copyWith.fieldName(value)` for a single field.
class _$DecisionDtoCWProxyImpl implements _$DecisionDtoCWProxy {
  const _$DecisionDtoCWProxyImpl(this._value);

  final DecisionDto _value;

  @override
  DecisionDto hide_(bool hide_) => call(hide_: hide_);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `DecisionDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DecisionDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  DecisionDto call({Object? hide_ = const $CopyWithPlaceholder()}) {
    return DecisionDto(
      hide_: hide_ == const $CopyWithPlaceholder() || hide_ == null
          ? _value.hide_
          // ignore: cast_nullable_to_non_nullable
          : hide_ as bool,
    );
  }
}

extension $DecisionDtoCopyWith on DecisionDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDecisionDto.copyWith(...)` or `instanceOfDecisionDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DecisionDtoCWProxy get copyWith => _$DecisionDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecisionDto _$DecisionDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DecisionDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['hide']);
      final val = DecisionDto(hide_: $checkedConvert('hide', (v) => v as bool));
      return val;
    }, fieldKeyMap: const {'hide_': 'hide'});

Map<String, dynamic> _$DecisionDtoToJson(DecisionDto instance) =>
    <String, dynamic>{'hide': instance.hide_};
