// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_menu_item_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PublicMenuItemDtoCWProxy {
  PublicMenuItemDto id(String id);

  PublicMenuItemDto name(String name);

  PublicMenuItemDto description(String? description);

  PublicMenuItemDto translated(bool translated);

  PublicMenuItemDto originalName(String originalName);

  PublicMenuItemDto price(num price);

  PublicMenuItemDto course(Course course);

  PublicMenuItemDto kind(ItemKind kind);

  PublicMenuItemDto prepMinutes(num prepMinutes);

  PublicMenuItemDto isAvailable(bool isAvailable);

  PublicMenuItemDto isPreorderable(bool isPreorderable);

  PublicMenuItemDto isAlcohol(bool isAlcohol);

  PublicMenuItemDto leadHours(num leadHours);

  PublicMenuItemDto tags(List<String> tags);

  PublicMenuItemDto photos(List<PublicPhotoDto> photos);

  PublicMenuItemDto optionGroups(List<PublicOptionGroupDto> optionGroups);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PublicMenuItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PublicMenuItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  PublicMenuItemDto call({
    String id,
    String name,
    String? description,
    bool translated,
    String originalName,
    num price,
    Course course,
    ItemKind kind,
    num prepMinutes,
    bool isAvailable,
    bool isPreorderable,
    bool isAlcohol,
    num leadHours,
    List<String> tags,
    List<PublicPhotoDto> photos,
    List<PublicOptionGroupDto> optionGroups,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPublicMenuItemDto.copyWith(...)` or call `instanceOfPublicMenuItemDto.copyWith.fieldName(value)` for a single field.
class _$PublicMenuItemDtoCWProxyImpl implements _$PublicMenuItemDtoCWProxy {
  const _$PublicMenuItemDtoCWProxyImpl(this._value);

  final PublicMenuItemDto _value;

  @override
  PublicMenuItemDto id(String id) => call(id: id);

  @override
  PublicMenuItemDto name(String name) => call(name: name);

  @override
  PublicMenuItemDto description(String? description) =>
      call(description: description);

  @override
  PublicMenuItemDto translated(bool translated) => call(translated: translated);

  @override
  PublicMenuItemDto originalName(String originalName) =>
      call(originalName: originalName);

  @override
  PublicMenuItemDto price(num price) => call(price: price);

  @override
  PublicMenuItemDto course(Course course) => call(course: course);

  @override
  PublicMenuItemDto kind(ItemKind kind) => call(kind: kind);

  @override
  PublicMenuItemDto prepMinutes(num prepMinutes) =>
      call(prepMinutes: prepMinutes);

  @override
  PublicMenuItemDto isAvailable(bool isAvailable) =>
      call(isAvailable: isAvailable);

  @override
  PublicMenuItemDto isPreorderable(bool isPreorderable) =>
      call(isPreorderable: isPreorderable);

  @override
  PublicMenuItemDto isAlcohol(bool isAlcohol) => call(isAlcohol: isAlcohol);

  @override
  PublicMenuItemDto leadHours(num leadHours) => call(leadHours: leadHours);

  @override
  PublicMenuItemDto tags(List<String> tags) => call(tags: tags);

  @override
  PublicMenuItemDto photos(List<PublicPhotoDto> photos) => call(photos: photos);

  @override
  PublicMenuItemDto optionGroups(List<PublicOptionGroupDto> optionGroups) =>
      call(optionGroups: optionGroups);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PublicMenuItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PublicMenuItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  PublicMenuItemDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? translated = const $CopyWithPlaceholder(),
    Object? originalName = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? course = const $CopyWithPlaceholder(),
    Object? kind = const $CopyWithPlaceholder(),
    Object? prepMinutes = const $CopyWithPlaceholder(),
    Object? isAvailable = const $CopyWithPlaceholder(),
    Object? isPreorderable = const $CopyWithPlaceholder(),
    Object? isAlcohol = const $CopyWithPlaceholder(),
    Object? leadHours = const $CopyWithPlaceholder(),
    Object? tags = const $CopyWithPlaceholder(),
    Object? photos = const $CopyWithPlaceholder(),
    Object? optionGroups = const $CopyWithPlaceholder(),
  }) {
    return PublicMenuItemDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      translated:
          translated == const $CopyWithPlaceholder() || translated == null
          ? _value.translated
          // ignore: cast_nullable_to_non_nullable
          : translated as bool,
      originalName:
          originalName == const $CopyWithPlaceholder() || originalName == null
          ? _value.originalName
          // ignore: cast_nullable_to_non_nullable
          : originalName as String,
      price: price == const $CopyWithPlaceholder() || price == null
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as num,
      course: course == const $CopyWithPlaceholder() || course == null
          ? _value.course
          // ignore: cast_nullable_to_non_nullable
          : course as Course,
      kind: kind == const $CopyWithPlaceholder() || kind == null
          ? _value.kind
          // ignore: cast_nullable_to_non_nullable
          : kind as ItemKind,
      prepMinutes:
          prepMinutes == const $CopyWithPlaceholder() || prepMinutes == null
          ? _value.prepMinutes
          // ignore: cast_nullable_to_non_nullable
          : prepMinutes as num,
      isAvailable:
          isAvailable == const $CopyWithPlaceholder() || isAvailable == null
          ? _value.isAvailable
          // ignore: cast_nullable_to_non_nullable
          : isAvailable as bool,
      isPreorderable:
          isPreorderable == const $CopyWithPlaceholder() ||
              isPreorderable == null
          ? _value.isPreorderable
          // ignore: cast_nullable_to_non_nullable
          : isPreorderable as bool,
      isAlcohol: isAlcohol == const $CopyWithPlaceholder() || isAlcohol == null
          ? _value.isAlcohol
          // ignore: cast_nullable_to_non_nullable
          : isAlcohol as bool,
      leadHours: leadHours == const $CopyWithPlaceholder() || leadHours == null
          ? _value.leadHours
          // ignore: cast_nullable_to_non_nullable
          : leadHours as num,
      tags: tags == const $CopyWithPlaceholder() || tags == null
          ? _value.tags
          // ignore: cast_nullable_to_non_nullable
          : tags as List<String>,
      photos: photos == const $CopyWithPlaceholder() || photos == null
          ? _value.photos
          // ignore: cast_nullable_to_non_nullable
          : photos as List<PublicPhotoDto>,
      optionGroups:
          optionGroups == const $CopyWithPlaceholder() || optionGroups == null
          ? _value.optionGroups
          // ignore: cast_nullable_to_non_nullable
          : optionGroups as List<PublicOptionGroupDto>,
    );
  }
}

extension $PublicMenuItemDtoCopyWith on PublicMenuItemDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPublicMenuItemDto.copyWith(...)` or `instanceOfPublicMenuItemDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PublicMenuItemDtoCWProxy get copyWith =>
      _$PublicMenuItemDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicMenuItemDto _$PublicMenuItemDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PublicMenuItemDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'translated',
      'originalName',
      'price',
      'course',
      'kind',
      'prepMinutes',
      'isAvailable',
      'isPreorderable',
      'isAlcohol',
      'leadHours',
      'tags',
      'photos',
      'optionGroups',
    ],
  );
  final val = PublicMenuItemDto(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    description: $checkedConvert('description', (v) => v as String?),
    translated: $checkedConvert('translated', (v) => v as bool),
    originalName: $checkedConvert('originalName', (v) => v as String),
    price: $checkedConvert('price', (v) => v as num),
    course: $checkedConvert('course', (v) => $enumDecode(_$CourseEnumMap, v)),
    kind: $checkedConvert('kind', (v) => $enumDecode(_$ItemKindEnumMap, v)),
    prepMinutes: $checkedConvert('prepMinutes', (v) => v as num),
    isAvailable: $checkedConvert('isAvailable', (v) => v as bool),
    isPreorderable: $checkedConvert('isPreorderable', (v) => v as bool),
    isAlcohol: $checkedConvert('isAlcohol', (v) => v as bool),
    leadHours: $checkedConvert('leadHours', (v) => v as num),
    tags: $checkedConvert(
      'tags',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    photos: $checkedConvert(
      'photos',
      (v) => (v as List<dynamic>)
          .map((e) => PublicPhotoDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    optionGroups: $checkedConvert(
      'optionGroups',
      (v) => (v as List<dynamic>)
          .map((e) => PublicOptionGroupDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$PublicMenuItemDtoToJson(PublicMenuItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': ?instance.description,
      'translated': instance.translated,
      'originalName': instance.originalName,
      'price': instance.price,
      'course': _$CourseEnumMap[instance.course]!,
      'kind': _$ItemKindEnumMap[instance.kind]!,
      'prepMinutes': instance.prepMinutes,
      'isAvailable': instance.isAvailable,
      'isPreorderable': instance.isPreorderable,
      'isAlcohol': instance.isAlcohol,
      'leadHours': instance.leadHours,
      'tags': instance.tags,
      'photos': instance.photos.map((e) => e.toJson()).toList(),
      'optionGroups': instance.optionGroups.map((e) => e.toJson()).toList(),
    };

const _$CourseEnumMap = {
  Course.DRINK: 'DRINK',
  Course.STARTER: 'STARTER',
  Course.MAIN: 'MAIN',
  Course.DESSERT: 'DESSERT',
};

const _$ItemKindEnumMap = {
  ItemKind.DISH: 'DISH',
  ItemKind.DRINK: 'DRINK',
  ItemKind.SET: 'SET',
  ItemKind.ADD_ON: 'ADD_ON',
};
