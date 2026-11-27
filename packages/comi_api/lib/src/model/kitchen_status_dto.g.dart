// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_status_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$KitchenStatusDtoCWProxy {
  KitchenStatusDto status(KitchenStatusDtoStatusEnum status);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `KitchenStatusDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// KitchenStatusDto(...).copyWith(id: 12, name: "My name")
  /// ```
  KitchenStatusDto call({KitchenStatusDtoStatusEnum status});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfKitchenStatusDto.copyWith(...)` or call `instanceOfKitchenStatusDto.copyWith.fieldName(value)` for a single field.
class _$KitchenStatusDtoCWProxyImpl implements _$KitchenStatusDtoCWProxy {
  const _$KitchenStatusDtoCWProxyImpl(this._value);

  final KitchenStatusDto _value;

  @override
  KitchenStatusDto status(KitchenStatusDtoStatusEnum status) =>
      call(status: status);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `KitchenStatusDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// KitchenStatusDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  KitchenStatusDto call({Object? status = const $CopyWithPlaceholder()}) {
    return KitchenStatusDto(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as KitchenStatusDtoStatusEnum,
    );
  }
}

extension $KitchenStatusDtoCopyWith on KitchenStatusDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfKitchenStatusDto.copyWith(...)` or `instanceOfKitchenStatusDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$KitchenStatusDtoCWProxy get copyWith => _$KitchenStatusDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KitchenStatusDto _$KitchenStatusDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('KitchenStatusDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['status']);
      final val = KitchenStatusDto(
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$KitchenStatusDtoStatusEnumEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$KitchenStatusDtoToJson(KitchenStatusDto instance) =>
    <String, dynamic>{
      'status': _$KitchenStatusDtoStatusEnumEnumMap[instance.status]!,
    };

const _$KitchenStatusDtoStatusEnumEnumMap = {
  KitchenStatusDtoStatusEnum.QUEUED: 'QUEUED',
  KitchenStatusDtoStatusEnum.COOKING: 'COOKING',
  KitchenStatusDtoStatusEnum.READY: 'READY',
  KitchenStatusDtoStatusEnum.SERVED: 'SERVED',
};
