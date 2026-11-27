// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MenuItemDtoCWProxy {
  MenuItemDto categoryId(String categoryId);

  MenuItemDto name(String name);

  MenuItemDto description(String? description);

  MenuItemDto price(num price);

  MenuItemDto course(MenuItemDtoCourseEnum? course);

  MenuItemDto kind(MenuItemDtoKindEnum? kind);

  MenuItemDto prepMinutes(num? prepMinutes);

  MenuItemDto isAvailable(bool? isAvailable);

  MenuItemDto isPreorderable(bool? isPreorderable);

  MenuItemDto isAlcohol(bool? isAlcohol);

  MenuItemDto leadHours(num? leadHours);

  MenuItemDto tags(List<String>? tags);

  MenuItemDto sortOrder(num? sortOrder);

  MenuItemDto optionGroups(List<OptionGroupDto>? optionGroups);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MenuItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MenuItemDto call({
    String categoryId,
    String name,
    String? description,
    num price,
    MenuItemDtoCourseEnum? course,
    MenuItemDtoKindEnum? kind,
    num? prepMinutes,
    bool? isAvailable,
    bool? isPreorderable,
    bool? isAlcohol,
    num? leadHours,
    List<String>? tags,
    num? sortOrder,
    List<OptionGroupDto>? optionGroups,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMenuItemDto.copyWith(...)` or call `instanceOfMenuItemDto.copyWith.fieldName(value)` for a single field.
class _$MenuItemDtoCWProxyImpl implements _$MenuItemDtoCWProxy {
  const _$MenuItemDtoCWProxyImpl(this._value);

  final MenuItemDto _value;

  @override
  MenuItemDto categoryId(String categoryId) => call(categoryId: categoryId);

  @override
  MenuItemDto name(String name) => call(name: name);

  @override
  MenuItemDto description(String? description) =>
      call(description: description);

  @override
  MenuItemDto price(num price) => call(price: price);

  @override
  MenuItemDto course(MenuItemDtoCourseEnum? course) => call(course: course);

  @override
  MenuItemDto kind(MenuItemDtoKindEnum? kind) => call(kind: kind);

  @override
  MenuItemDto prepMinutes(num? prepMinutes) => call(prepMinutes: prepMinutes);

  @override
  MenuItemDto isAvailable(bool? isAvailable) => call(isAvailable: isAvailable);

  @override
  MenuItemDto isPreorderable(bool? isPreorderable) =>
      call(isPreorderable: isPreorderable);

  @override
  MenuItemDto isAlcohol(bool? isAlcohol) => call(isAlcohol: isAlcohol);

  @override
  MenuItemDto leadHours(num? leadHours) => call(leadHours: leadHours);

  @override
  MenuItemDto tags(List<String>? tags) => call(tags: tags);

  @override
  MenuItemDto sortOrder(num? sortOrder) => call(sortOrder: sortOrder);

  @override
  MenuItemDto optionGroups(List<OptionGroupDto>? optionGroups) =>
      call(optionGroups: optionGroups);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MenuItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MenuItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MenuItemDto call({
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
    Object? optionGroups = const $CopyWithPlaceholder(),
  }) {
    return MenuItemDto(
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
      course: course == const $CopyWithPlaceholder()
          ? _value.course
          // ignore: cast_nullable_to_non_nullable
          : course as MenuItemDtoCourseEnum?,
      kind: kind == const $CopyWithPlaceholder()
          ? _value.kind
          // ignore: cast_nullable_to_non_nullable
          : kind as MenuItemDtoKindEnum?,
      prepMinutes: prepMinutes == const $CopyWithPlaceholder()
          ? _value.prepMinutes
          // ignore: cast_nullable_to_non_nullable
          : prepMinutes as num?,
      isAvailable: isAvailable == const $CopyWithPlaceholder()
          ? _value.isAvailable
          // ignore: cast_nullable_to_non_nullable
          : isAvailable as bool?,
      isPreorderable: isPreorderable == const $CopyWithPlaceholder()
          ? _value.isPreorderable
          // ignore: cast_nullable_to_non_nullable
          : isPreorderable as bool?,
      isAlcohol: isAlcohol == const $CopyWithPlaceholder()
          ? _value.isAlcohol
          // ignore: cast_nullable_to_non_nullable
          : isAlcohol as bool?,
      leadHours: leadHours == const $CopyWithPlaceholder()
          ? _value.leadHours
          // ignore: cast_nullable_to_non_nullable
          : leadHours as num?,
      tags: tags == const $CopyWithPlaceholder()
          ? _value.tags
          // ignore: cast_nullable_to_non_nullable
          : tags as List<String>?,
      sortOrder: sortOrder == const $CopyWithPlaceholder()
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as num?,
      optionGroups: optionGroups == const $CopyWithPlaceholder()
          ? _value.optionGroups
          // ignore: cast_nullable_to_non_nullable
          : optionGroups as List<OptionGroupDto>?,
    );
  }
}

extension $MenuItemDtoCopyWith on MenuItemDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMenuItemDto.copyWith(...)` or `instanceOfMenuItemDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MenuItemDtoCWProxy get copyWith => _$MenuItemDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItemDto _$MenuItemDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MenuItemDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['categoryId', 'name', 'price']);
      final val = MenuItemDto(
        categoryId: $checkedConvert('categoryId', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
        price: $checkedConvert('price', (v) => v as num),
        course: $checkedConvert(
          'course',
          (v) => $enumDecodeNullable(_$MenuItemDtoCourseEnumEnumMap, v),
        ),
        kind: $checkedConvert(
          'kind',
          (v) => $enumDecodeNullable(_$MenuItemDtoKindEnumEnumMap, v),
        ),
        prepMinutes: $checkedConvert('prepMinutes', (v) => v as num?),
        isAvailable: $checkedConvert('isAvailable', (v) => v as bool?),
        isPreorderable: $checkedConvert('isPreorderable', (v) => v as bool?),
        isAlcohol: $checkedConvert('isAlcohol', (v) => v as bool?),
        leadHours: $checkedConvert('leadHours', (v) => v as num?),
        tags: $checkedConvert(
          'tags',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        sortOrder: $checkedConvert('sortOrder', (v) => v as num?),
        optionGroups: $checkedConvert(
          'optionGroups',
          (v) => (v as List<dynamic>?)
              ?.map((e) => OptionGroupDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MenuItemDtoToJson(MenuItemDto instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'name': instance.name,
      'description': ?instance.description,
      'price': instance.price,
      'course': ?_$MenuItemDtoCourseEnumEnumMap[instance.course],
      'kind': ?_$MenuItemDtoKindEnumEnumMap[instance.kind],
      'prepMinutes': ?instance.prepMinutes,
      'isAvailable': ?instance.isAvailable,
      'isPreorderable': ?instance.isPreorderable,
      'isAlcohol': ?instance.isAlcohol,
      'leadHours': ?instance.leadHours,
      'tags': ?instance.tags,
      'sortOrder': ?instance.sortOrder,
      'optionGroups': ?instance.optionGroups?.map((e) => e.toJson()).toList(),
    };

const _$MenuItemDtoCourseEnumEnumMap = {
  MenuItemDtoCourseEnum.DRINK: 'DRINK',
  MenuItemDtoCourseEnum.STARTER: 'STARTER',
  MenuItemDtoCourseEnum.MAIN: 'MAIN',
  MenuItemDtoCourseEnum.DESSERT: 'DESSERT',
};

const _$MenuItemDtoKindEnumEnumMap = {
  MenuItemDtoKindEnum.DISH: 'DISH',
  MenuItemDtoKindEnum.DRINK: 'DRINK',
  MenuItemDtoKindEnum.SET: 'SET',
  MenuItemDtoKindEnum.ADD_ON: 'ADD_ON',
};
