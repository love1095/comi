// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_snapshot_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OptionSnapshotDtoCWProxy {
  OptionSnapshotDto group(String group);

  OptionSnapshotDto option(String option);

  OptionSnapshotDto priceDelta(num priceDelta);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `OptionSnapshotDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OptionSnapshotDto(...).copyWith(id: 12, name: "My name")
  /// ```
  OptionSnapshotDto call({String group, String option, num priceDelta});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOptionSnapshotDto.copyWith(...)` or call `instanceOfOptionSnapshotDto.copyWith.fieldName(value)` for a single field.
class _$OptionSnapshotDtoCWProxyImpl implements _$OptionSnapshotDtoCWProxy {
  const _$OptionSnapshotDtoCWProxyImpl(this._value);

  final OptionSnapshotDto _value;

  @override
  OptionSnapshotDto group(String group) => call(group: group);

  @override
  OptionSnapshotDto option(String option) => call(option: option);

  @override
  OptionSnapshotDto priceDelta(num priceDelta) => call(priceDelta: priceDelta);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `OptionSnapshotDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OptionSnapshotDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  OptionSnapshotDto call({
    Object? group = const $CopyWithPlaceholder(),
    Object? option = const $CopyWithPlaceholder(),
    Object? priceDelta = const $CopyWithPlaceholder(),
  }) {
    return OptionSnapshotDto(
      group: group == const $CopyWithPlaceholder() || group == null
          ? _value.group
          // ignore: cast_nullable_to_non_nullable
          : group as String,
      option: option == const $CopyWithPlaceholder() || option == null
          ? _value.option
          // ignore: cast_nullable_to_non_nullable
          : option as String,
      priceDelta:
          priceDelta == const $CopyWithPlaceholder() || priceDelta == null
          ? _value.priceDelta
          // ignore: cast_nullable_to_non_nullable
          : priceDelta as num,
    );
  }
}

extension $OptionSnapshotDtoCopyWith on OptionSnapshotDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOptionSnapshotDto.copyWith(...)` or `instanceOfOptionSnapshotDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OptionSnapshotDtoCWProxy get copyWith =>
      _$OptionSnapshotDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionSnapshotDto _$OptionSnapshotDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OptionSnapshotDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['group', 'option', 'priceDelta']);
      final val = OptionSnapshotDto(
        group: $checkedConvert('group', (v) => v as String),
        option: $checkedConvert('option', (v) => v as String),
        priceDelta: $checkedConvert('priceDelta', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$OptionSnapshotDtoToJson(OptionSnapshotDto instance) =>
    <String, dynamic>{
      'group': instance.group,
      'option': instance.option,
      'priceDelta': instance.priceDelta,
    };
