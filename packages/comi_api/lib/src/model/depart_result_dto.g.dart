// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'depart_result_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DepartResultDtoCWProxy {
  DepartResultDto etaAt(String etaAt);

  DepartResultDto travelMinutes(num travelMinutes);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `DepartResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DepartResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  DepartResultDto call({String etaAt, num travelMinutes});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDepartResultDto.copyWith(...)` or call `instanceOfDepartResultDto.copyWith.fieldName(value)` for a single field.
class _$DepartResultDtoCWProxyImpl implements _$DepartResultDtoCWProxy {
  const _$DepartResultDtoCWProxyImpl(this._value);

  final DepartResultDto _value;

  @override
  DepartResultDto etaAt(String etaAt) => call(etaAt: etaAt);

  @override
  DepartResultDto travelMinutes(num travelMinutes) =>
      call(travelMinutes: travelMinutes);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `DepartResultDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DepartResultDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  DepartResultDto call({
    Object? etaAt = const $CopyWithPlaceholder(),
    Object? travelMinutes = const $CopyWithPlaceholder(),
  }) {
    return DepartResultDto(
      etaAt: etaAt == const $CopyWithPlaceholder() || etaAt == null
          ? _value.etaAt
          // ignore: cast_nullable_to_non_nullable
          : etaAt as String,
      travelMinutes:
          travelMinutes == const $CopyWithPlaceholder() || travelMinutes == null
          ? _value.travelMinutes
          // ignore: cast_nullable_to_non_nullable
          : travelMinutes as num,
    );
  }
}

extension $DepartResultDtoCopyWith on DepartResultDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDepartResultDto.copyWith(...)` or `instanceOfDepartResultDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DepartResultDtoCWProxy get copyWith => _$DepartResultDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartResultDto _$DepartResultDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DepartResultDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['etaAt', 'travelMinutes']);
      final val = DepartResultDto(
        etaAt: $checkedConvert('etaAt', (v) => v as String),
        travelMinutes: $checkedConvert('travelMinutes', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$DepartResultDtoToJson(DepartResultDto instance) =>
    <String, dynamic>{
      'etaAt': instance.etaAt,
      'travelMinutes': instance.travelMinutes,
    };
