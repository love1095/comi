// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_entry_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuditEntryDtoCWProxy {
  AuditEntryDto id(String id);

  AuditEntryDto actorType(String actorType);

  AuditEntryDto actorId(String? actorId);

  AuditEntryDto action(String action);

  AuditEntryDto entity(String entity);

  AuditEntryDto entityId(String entityId);

  AuditEntryDto data(Map<String, Object>? data);

  AuditEntryDto createdAt(String createdAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AuditEntryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuditEntryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  AuditEntryDto call({
    String id,
    String actorType,
    String? actorId,
    String action,
    String entity,
    String entityId,
    Map<String, Object>? data,
    String createdAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuditEntryDto.copyWith(...)` or call `instanceOfAuditEntryDto.copyWith.fieldName(value)` for a single field.
class _$AuditEntryDtoCWProxyImpl implements _$AuditEntryDtoCWProxy {
  const _$AuditEntryDtoCWProxyImpl(this._value);

  final AuditEntryDto _value;

  @override
  AuditEntryDto id(String id) => call(id: id);

  @override
  AuditEntryDto actorType(String actorType) => call(actorType: actorType);

  @override
  AuditEntryDto actorId(String? actorId) => call(actorId: actorId);

  @override
  AuditEntryDto action(String action) => call(action: action);

  @override
  AuditEntryDto entity(String entity) => call(entity: entity);

  @override
  AuditEntryDto entityId(String entityId) => call(entityId: entityId);

  @override
  AuditEntryDto data(Map<String, Object>? data) => call(data: data);

  @override
  AuditEntryDto createdAt(String createdAt) => call(createdAt: createdAt);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `AuditEntryDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuditEntryDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AuditEntryDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? actorType = const $CopyWithPlaceholder(),
    Object? actorId = const $CopyWithPlaceholder(),
    Object? action = const $CopyWithPlaceholder(),
    Object? entity = const $CopyWithPlaceholder(),
    Object? entityId = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return AuditEntryDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      actorType: actorType == const $CopyWithPlaceholder() || actorType == null
          ? _value.actorType
          // ignore: cast_nullable_to_non_nullable
          : actorType as String,
      actorId: actorId == const $CopyWithPlaceholder()
          ? _value.actorId
          // ignore: cast_nullable_to_non_nullable
          : actorId as String?,
      action: action == const $CopyWithPlaceholder() || action == null
          ? _value.action
          // ignore: cast_nullable_to_non_nullable
          : action as String,
      entity: entity == const $CopyWithPlaceholder() || entity == null
          ? _value.entity
          // ignore: cast_nullable_to_non_nullable
          : entity as String,
      entityId: entityId == const $CopyWithPlaceholder() || entityId == null
          ? _value.entityId
          // ignore: cast_nullable_to_non_nullable
          : entityId as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Map<String, Object>?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String,
    );
  }
}

extension $AuditEntryDtoCopyWith on AuditEntryDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuditEntryDto.copyWith(...)` or `instanceOfAuditEntryDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuditEntryDtoCWProxy get copyWith => _$AuditEntryDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditEntryDto _$AuditEntryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuditEntryDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'actorType',
          'action',
          'entity',
          'entityId',
          'createdAt',
        ],
      );
      final val = AuditEntryDto(
        id: $checkedConvert('id', (v) => v as String),
        actorType: $checkedConvert('actorType', (v) => v as String),
        actorId: $checkedConvert('actorId', (v) => v as String?),
        action: $checkedConvert('action', (v) => v as String),
        entity: $checkedConvert('entity', (v) => v as String),
        entityId: $checkedConvert('entityId', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as Object),
          ),
        ),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$AuditEntryDtoToJson(AuditEntryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'actorType': instance.actorType,
      'actorId': ?instance.actorId,
      'action': instance.action,
      'entity': instance.entity,
      'entityId': instance.entityId,
      'data': ?instance.data,
      'createdAt': instance.createdAt,
    };
