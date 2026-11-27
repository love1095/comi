// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_map_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TableMapDtoCWProxy {
  TableMapDto allowTableChoice(bool allowTableChoice);

  TableMapDto arrivalAt(String arrivalAt);

  TableMapDto diningMinutes(num diningMinutes);

  TableMapDto areas(List<MapAreaDto> areas);

  TableMapDto area(MapAreaWithElementsDto area);

  TableMapDto myHold(MyHoldDto? myHold);

  TableMapDto tables(List<MapTableStateDto> tables);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `TableMapDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TableMapDto(...).copyWith(id: 12, name: "My name")
  /// ```
  TableMapDto call({
    bool allowTableChoice,
    String arrivalAt,
    num diningMinutes,
    List<MapAreaDto> areas,
    MapAreaWithElementsDto area,
    MyHoldDto? myHold,
    List<MapTableStateDto> tables,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTableMapDto.copyWith(...)` or call `instanceOfTableMapDto.copyWith.fieldName(value)` for a single field.
class _$TableMapDtoCWProxyImpl implements _$TableMapDtoCWProxy {
  const _$TableMapDtoCWProxyImpl(this._value);

  final TableMapDto _value;

  @override
  TableMapDto allowTableChoice(bool allowTableChoice) =>
      call(allowTableChoice: allowTableChoice);

  @override
  TableMapDto arrivalAt(String arrivalAt) => call(arrivalAt: arrivalAt);

  @override
  TableMapDto diningMinutes(num diningMinutes) =>
      call(diningMinutes: diningMinutes);

  @override
  TableMapDto areas(List<MapAreaDto> areas) => call(areas: areas);

  @override
  TableMapDto area(MapAreaWithElementsDto area) => call(area: area);

  @override
  TableMapDto myHold(MyHoldDto? myHold) => call(myHold: myHold);

  @override
  TableMapDto tables(List<MapTableStateDto> tables) => call(tables: tables);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `TableMapDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TableMapDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  TableMapDto call({
    Object? allowTableChoice = const $CopyWithPlaceholder(),
    Object? arrivalAt = const $CopyWithPlaceholder(),
    Object? diningMinutes = const $CopyWithPlaceholder(),
    Object? areas = const $CopyWithPlaceholder(),
    Object? area = const $CopyWithPlaceholder(),
    Object? myHold = const $CopyWithPlaceholder(),
    Object? tables = const $CopyWithPlaceholder(),
  }) {
    return TableMapDto(
      allowTableChoice:
          allowTableChoice == const $CopyWithPlaceholder() ||
              allowTableChoice == null
          ? _value.allowTableChoice
          // ignore: cast_nullable_to_non_nullable
          : allowTableChoice as bool,
      arrivalAt: arrivalAt == const $CopyWithPlaceholder() || arrivalAt == null
          ? _value.arrivalAt
          // ignore: cast_nullable_to_non_nullable
          : arrivalAt as String,
      diningMinutes:
          diningMinutes == const $CopyWithPlaceholder() || diningMinutes == null
          ? _value.diningMinutes
          // ignore: cast_nullable_to_non_nullable
          : diningMinutes as num,
      areas: areas == const $CopyWithPlaceholder() || areas == null
          ? _value.areas
          // ignore: cast_nullable_to_non_nullable
          : areas as List<MapAreaDto>,
      area: area == const $CopyWithPlaceholder() || area == null
          ? _value.area
          // ignore: cast_nullable_to_non_nullable
          : area as MapAreaWithElementsDto,
      myHold: myHold == const $CopyWithPlaceholder()
          ? _value.myHold
          // ignore: cast_nullable_to_non_nullable
          : myHold as MyHoldDto?,
      tables: tables == const $CopyWithPlaceholder() || tables == null
          ? _value.tables
          // ignore: cast_nullable_to_non_nullable
          : tables as List<MapTableStateDto>,
    );
  }
}

extension $TableMapDtoCopyWith on TableMapDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTableMapDto.copyWith(...)` or `instanceOfTableMapDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TableMapDtoCWProxy get copyWith => _$TableMapDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableMapDto _$TableMapDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TableMapDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'allowTableChoice',
          'arrivalAt',
          'diningMinutes',
          'areas',
          'area',
          'tables',
        ],
      );
      final val = TableMapDto(
        allowTableChoice: $checkedConvert('allowTableChoice', (v) => v as bool),
        arrivalAt: $checkedConvert('arrivalAt', (v) => v as String),
        diningMinutes: $checkedConvert('diningMinutes', (v) => v as num),
        areas: $checkedConvert(
          'areas',
          (v) => (v as List<dynamic>)
              .map((e) => MapAreaDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        area: $checkedConvert(
          'area',
          (v) => MapAreaWithElementsDto.fromJson(v as Map<String, dynamic>),
        ),
        myHold: $checkedConvert(
          'myHold',
          (v) =>
              v == null ? null : MyHoldDto.fromJson(v as Map<String, dynamic>),
        ),
        tables: $checkedConvert(
          'tables',
          (v) => (v as List<dynamic>)
              .map((e) => MapTableStateDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TableMapDtoToJson(TableMapDto instance) =>
    <String, dynamic>{
      'allowTableChoice': instance.allowTableChoice,
      'arrivalAt': instance.arrivalAt,
      'diningMinutes': instance.diningMinutes,
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'area': instance.area.toJson(),
      'myHold': ?instance.myHold?.toJson(),
      'tables': instance.tables.map((e) => e.toJson()).toList(),
    };
