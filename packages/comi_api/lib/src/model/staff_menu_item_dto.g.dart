// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_menu_item_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StaffMenuItemDtoCWProxy {
  StaffMenuItemDto id(String id);

  StaffMenuItemDto categoryId(String categoryId);

  StaffMenuItemDto name(String name);

  StaffMenuItemDto description(String? description);

  StaffMenuItemDto price(num price);

  StaffMenuItemDto course(Course course);

  StaffMenuItemDto kind(ItemKind kind);

  StaffMenuItemDto prepMinutes(num prepMinutes);

  StaffMenuItemDto isAvailable(bool isAvailable);

  StaffMenuItemDto isPreorderable(bool isPreorderable);

  StaffMenuItemDto isAlcohol(bool isAlcohol);

  StaffMenuItemDto leadHours(num leadHours);

  StaffMenuItemDto tags(List<String> tags);

  StaffMenuItemDto sortOrder(num sortOrder);

  StaffMenuItemDto photos(List<MenuPhotoDto> photos);

  StaffMenuItemDto optionGroups(List<OptionGroupResponseDto> optionGroups);

  StaffMenuItemDto translations(List<MenuTranslationDto> translations);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StaffMenuItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StaffMenuItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  StaffMenuItemDto call({
    String id,
    String categoryId,
    String name,
    String? description,
    num price,
    Course course,
    ItemKind kind,
    num prepMinutes,
    bool isAvailable,
    bool isPreorderable,
    bool isAlcohol,
    num leadHours,
    List<String> tags,
    num sortOrder,
    List<MenuPhotoDto> photos,
    List<OptionGroupResponseDto> optionGroups,
    List<MenuTranslationDto> translations,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStaffMenuItemDto.copyWith(...)` or call `instanceOfStaffMenuItemDto.copyWith.fieldName(value)` for a single field.
class _$StaffMenuItemDtoCWProxyImpl implements _$StaffMenuItemDtoCWProxy {
  const _$StaffMenuItemDtoCWProxyImpl(this._value);

  final StaffMenuItemDto _value;

  @override
  StaffMenuItemDto id(String id) => call(id: id);

  @override
  StaffMenuItemDto categoryId(String categoryId) =>
      call(categoryId: categoryId);

  @override
  StaffMenuItemDto name(String name) => call(name: name);

  @override
  StaffMenuItemDto description(String? description) =>
      call(description: description);

  @override
  StaffMenuItemDto price(num price) => call(price: price);

  @override
  StaffMenuItemDto course(Course course) => call(course: course);

  @override
  StaffMenuItemDto kind(ItemKind kind) => call(kind: kind);

  @override
  StaffMenuItemDto prepMinutes(num prepMinutes) =>
      call(prepMinutes: prepMinutes);

  @override
  StaffMenuItemDto isAvailable(bool isAvailable) =>
      call(isAvailable: isAvailable);

  @override
  StaffMenuItemDto isPreorderable(bool isPreorderable) =>
      call(isPreorderable: isPreorderable);

  @override
  StaffMenuItemDto isAlcohol(bool isAlcohol) => call(isAlcohol: isAlcohol);

  @override
  StaffMenuItemDto leadHours(num leadHours) => call(leadHours: leadHours);

  @override
  StaffMenuItemDto tags(List<String> tags) => call(tags: tags);

  @override
  StaffMenuItemDto sortOrder(num sortOrder) => call(sortOrder: sortOrder);

  @override
  StaffMenuItemDto photos(List<MenuPhotoDto> photos) => call(photos: photos);

  @override
  StaffMenuItemDto optionGroups(List<OptionGroupResponseDto> optionGroups) =>
      call(optionGroups: optionGroups);

  @override
  StaffMenuItemDto translations(List<MenuTranslationDto> translations) =>
      call(translations: translations);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `StaffMenuItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StaffMenuItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  StaffMenuItemDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? categoryId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? course = const $CopyWithPlaceholder(),
    Object? kind = const $CopyWithPlaceholder(),
    Object? prepMinutes = const $CopyWithPlaceholder(),
    Object? isAvailable = const $CopyWithPlaceholder(),
    Object? isPreorderable = const $CopyWithPlaceholder(),
    Object? isAlcohol = const $CopyWithPlaceholder(),
    Object? leadHours = const $CopyWithPlaceholder(),
    Object? tags = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
    Object? photos = const $CopyWithPlaceholder(),
    Object? optionGroups = const $CopyWithPlaceholder(),
    Object? translations = const $CopyWithPlaceholder(),
  }) {
    return StaffMenuItemDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      categoryId:
          categoryId == const $CopyWithPlaceholder() || categoryId == null
          ? _value.categoryId
          // ignore: cast_nullable_to_non_nullable
          : categoryId as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
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
      sortOrder: sortOrder == const $CopyWithPlaceholder() || sortOrder == null
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as num,
      photos: photos == const $CopyWithPlaceholder() || photos == null
          ? _value.photos
          // ignore: cast_nullable_to_non_nullable
          : photos as List<MenuPhotoDto>,
      optionGroups:
          optionGroups == const $CopyWithPlaceholder() || optionGroups == null
          ? _value.optionGroups
          // ignore: cast_nullable_to_non_nullable
          : optionGroups as List<OptionGroupResponseDto>,
      translations:
          translations == const $CopyWithPlaceholder() || translations == null
          ? _value.translations
          // ignore: cast_nullable_to_non_nullable
          : translations as List<MenuTranslationDto>,
    );
  }
}

extension $StaffMenuItemDtoCopyWith on StaffMenuItemDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStaffMenuItemDto.copyWith(...)` or `instanceOfStaffMenuItemDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StaffMenuItemDtoCWProxy get copyWith => _$StaffMenuItemDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffMenuItemDto _$StaffMenuItemDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('StaffMenuItemDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'categoryId',
      'name',
      'price',
      'course',
      'kind',
      'prepMinutes',
      'isAvailable',
      'isPreorderable',
      'isAlcohol',
      'leadHours',
      'tags',
      'sortOrder',
      'photos',
      'optionGroups',
      'translations',
    ],
  );
  final val = StaffMenuItemDto(
    id: $checkedConvert('id', (v) => v as String),
    categoryId: $checkedConvert('categoryId', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    description: $checkedConvert('description', (v) => v as String?),
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
    sortOrder: $checkedConvert('sortOrder', (v) => v as num),
    photos: $checkedConvert(
      'photos',
      (v) => (v as List<dynamic>)
          .map((e) => MenuPhotoDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    optionGroups: $checkedConvert(
      'optionGroups',
      (v) => (v as List<dynamic>)
          .map(
            (e) => OptionGroupResponseDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
    translations: $checkedConvert(
      'translations',
      (v) => (v as List<dynamic>)
          .map((e) => MenuTranslationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$StaffMenuItemDtoToJson(StaffMenuItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'name': instance.name,
      'description': ?instance.description,
      'price': instance.price,
      'course': _$CourseEnumMap[instance.course]!,
      'kind': _$ItemKindEnumMap[instance.kind]!,
      'prepMinutes': instance.prepMinutes,
      'isAvailable': instance.isAvailable,
      'isPreorderable': instance.isPreorderable,
      'isAlcohol': instance.isAlcohol,
      'leadHours': instance.leadHours,
      'tags': instance.tags,
      'sortOrder': instance.sortOrder,
      'photos': instance.photos.map((e) => e.toJson()).toList(),
      'optionGroups': instance.optionGroups.map((e) => e.toJson()).toList(),
      'translations': instance.translations.map((e) => e.toJson()).toList(),
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
