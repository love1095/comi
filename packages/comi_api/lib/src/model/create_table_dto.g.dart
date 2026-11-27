// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_table_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateTableDtoCWProxy {
  CreateTableDto code(String code);

  CreateTableDto minSeats(num? minSeats);

  CreateTableDto maxSeats(num maxSeats);

  CreateTableDto shape(CreateTableDtoShapeEnum? shape);

  CreateTableDto posX(num? posX);

  CreateTableDto posY(num? posY);

  CreateTableDto width(num? width);

  CreateTableDto height(num? height);

  CreateTableDto rotation(num? rotation);

  CreateTableDto features(List<String>? features);

  CreateTableDto seatLayout(Object? seatLayout);

  CreateTableDto isSelectable(bool? isSelectable);

  CreateTableDto isActive(bool? isActive);

  CreateTableDto joinGroup(String? joinGroup);

  CreateTableDto areaId(String areaId);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CreateTableDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CreateTableDto(...).copyWith(id: 12, name: "My name")
  /// ```
  CreateTableDto call({
    String code,
    num? minSeats,
    num maxSeats,
    CreateTableDtoShapeEnum? shape,
    num? posX,
    num? posY,
    num? width,
    num? height,
    num? rotation,
    List<String>? features,
    Object? seatLayout,
    bool? isSelectable,
    bool? isActive,
    String? joinGroup,
    String areaId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCreateTableDto.copyWith(...)` or call `instanceOfCreateTableDto.copyWith.fieldName(value)` for a single field.
class _$CreateTableDtoCWProxyImpl implements _$CreateTableDtoCWProxy {
  const _$CreateTableDtoCWProxyImpl(this._value);

  final CreateTableDto _value;

  @override
  CreateTableDto code(String code) => call(code: code);

  @override
  CreateTableDto minSeats(num? minSeats) => call(minSeats: minSeats);

  @override
  CreateTableDto maxSeats(num maxSeats) => call(maxSeats: maxSeats);

  @override
  CreateTableDto shape(CreateTableDtoShapeEnum? shape) => call(shape: shape);

  @override
  CreateTableDto posX(num? posX) => call(posX: posX);

  @override
  CreateTableDto posY(num? posY) => call(posY: posY);

  @override
  CreateTableDto width(num? width) => call(width: width);

  @override
  CreateTableDto height(num? height) => call(height: height);

  @override
  CreateTableDto rotation(num? rotation) => call(rotation: rotation);

  @override
  CreateTableDto features(List<String>? features) => call(features: features);

  @override
  CreateTableDto seatLayout(Object? seatLayout) => call(seatLayout: seatLayout);

  @override
  CreateTableDto isSelectable(bool? isSelectable) =>
      call(isSelectable: isSelectable);

  @override
  CreateTableDto isActive(bool? isActive) => call(isActive: isActive);

  @override
  CreateTableDto joinGroup(String? joinGroup) => call(joinGroup: joinGroup);

  @override
  CreateTableDto areaId(String areaId) => call(areaId: areaId);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CreateTableDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CreateTableDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CreateTableDto call({
    Object? code = const $CopyWithPlaceholder(),
    Object? minSeats = const $CopyWithPlaceholder(),
    Object? maxSeats = const $CopyWithPlaceholder(),
    Object? shape = const $CopyWithPlaceholder(),
    Object? posX = const $CopyWithPlaceholder(),
    Object? posY = const $CopyWithPlaceholder(),
    Object? width = const $CopyWithPlaceholder(),
    Object? height = const $CopyWithPlaceholder(),
    Object? rotation = const $CopyWithPlaceholder(),
    Object? features = const $CopyWithPlaceholder(),
    Object? seatLayout = const $CopyWithPlaceholder(),
    Object? isSelectable = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? joinGroup = const $CopyWithPlaceholder(),
    Object? areaId = const $CopyWithPlaceholder(),
  }) {
    return CreateTableDto(
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      minSeats: minSeats == const $CopyWithPlaceholder()
          ? _value.minSeats
          // ignore: cast_nullable_to_non_nullable
          : minSeats as num?,
      maxSeats: maxSeats == const $CopyWithPlaceholder() || maxSeats == null
          ? _value.maxSeats
          // ignore: cast_nullable_to_non_nullable
          : maxSeats as num,
      shape: shape == const $CopyWithPlaceholder()
          ? _value.shape
          // ignore: cast_nullable_to_non_nullable
          : shape as CreateTableDtoShapeEnum?,
      posX: posX == const $CopyWithPlaceholder()
          ? _value.posX
          // ignore: cast_nullable_to_non_nullable
          : posX as num?,
      posY: posY == const $CopyWithPlaceholder()
          ? _value.posY
          // ignore: cast_nullable_to_non_nullable
          : posY as num?,
      width: width == const $CopyWithPlaceholder()
          ? _value.width
          // ignore: cast_nullable_to_non_nullable
          : width as num?,
      height: height == const $CopyWithPlaceholder()
          ? _value.height
          // ignore: cast_nullable_to_non_nullable
          : height as num?,
      rotation: rotation == const $CopyWithPlaceholder()
          ? _value.rotation
          // ignore: cast_nullable_to_non_nullable
          : rotation as num?,
      features: features == const $CopyWithPlaceholder()
          ? _value.features
          // ignore: cast_nullable_to_non_nullable
          : features as List<String>?,
      seatLayout: seatLayout == const $CopyWithPlaceholder()
          ? _value.seatLayout
          // ignore: cast_nullable_to_non_nullable
          : seatLayout as Object?,
      isSelectable: isSelectable == const $CopyWithPlaceholder()
          ? _value.isSelectable
          // ignore: cast_nullable_to_non_nullable
          : isSelectable as bool?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      joinGroup: joinGroup == const $CopyWithPlaceholder()
          ? _value.joinGroup
          // ignore: cast_nullable_to_non_nullable
          : joinGroup as String?,
      areaId: areaId == const $CopyWithPlaceholder() || areaId == null
          ? _value.areaId
          // ignore: cast_nullable_to_non_nullable
          : areaId as String,
    );
  }
}

extension $CreateTableDtoCopyWith on CreateTableDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCreateTableDto.copyWith(...)` or `instanceOfCreateTableDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateTableDtoCWProxy get copyWith => _$CreateTableDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTableDto _$CreateTableDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CreateTableDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['code', 'maxSeats', 'areaId']);
      final val = CreateTableDto(
        code: $checkedConvert('code', (v) => v as String),
        minSeats: $checkedConvert('minSeats', (v) => v as num? ?? 1),
        maxSeats: $checkedConvert('maxSeats', (v) => v as num),
        shape: $checkedConvert(
          'shape',
          (v) => $enumDecodeNullable(_$CreateTableDtoShapeEnumEnumMap, v),
        ),
        posX: $checkedConvert('posX', (v) => v as num?),
        posY: $checkedConvert('posY', (v) => v as num?),
        width: $checkedConvert('width', (v) => v as num?),
        height: $checkedConvert('height', (v) => v as num?),
        rotation: $checkedConvert('rotation', (v) => v as num?),
        features: $checkedConvert(
          'features',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        seatLayout: $checkedConvert('seatLayout', (v) => v),
        isSelectable: $checkedConvert('isSelectable', (v) => v as bool?),
        isActive: $checkedConvert('isActive', (v) => v as bool?),
        joinGroup: $checkedConvert('joinGroup', (v) => v as String?),
        areaId: $checkedConvert('areaId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$CreateTableDtoToJson(CreateTableDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'minSeats': ?instance.minSeats,
      'maxSeats': instance.maxSeats,
      'shape': ?_$CreateTableDtoShapeEnumEnumMap[instance.shape],
      'posX': ?instance.posX,
      'posY': ?instance.posY,
      'width': ?instance.width,
      'height': ?instance.height,
      'rotation': ?instance.rotation,
      'features': ?instance.features,
      'seatLayout': ?instance.seatLayout,
      'isSelectable': ?instance.isSelectable,
      'isActive': ?instance.isActive,
      'joinGroup': ?instance.joinGroup,
      'areaId': instance.areaId,
    };

const _$CreateTableDtoShapeEnumEnumMap = {
  CreateTableDtoShapeEnum.RECT: 'RECT',
  CreateTableDtoShapeEnum.ROUND: 'ROUND',
  CreateTableDtoShapeEnum.SQUARE: 'SQUARE',
  CreateTableDtoShapeEnum.BOOTH: 'BOOTH',
  CreateTableDtoShapeEnum.BAR_SEAT: 'BAR_SEAT',
};
