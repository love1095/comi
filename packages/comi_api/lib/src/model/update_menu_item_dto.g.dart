// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_menu_item_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateMenuItemDtoCWProxy {
  UpdateMenuItemDto categoryId(String? categoryId);

  UpdateMenuItemDto name(String? name);

  UpdateMenuItemDto description(String? description);

  UpdateMenuItemDto price(num? price);

  UpdateMenuItemDto course(UpdateMenuItemDtoCourseEnum? course);

  UpdateMenuItemDto kind(UpdateMenuItemDtoKindEnum? kind);

  UpdateMenuItemDto prepMinutes(num? prepMinutes);

  UpdateMenuItemDto isAvailable(bool? isAvailable);

  UpdateMenuItemDto isPreorderable(bool? isPreorderable);

  UpdateMenuItemDto isAlcohol(bool? isAlcohol);

  UpdateMenuItemDto leadHours(num? leadHours);

  UpdateMenuItemDto tags(List<String>? tags);

  UpdateMenuItemDto sortOrder(num? sortOrder);

  UpdateMenuItemDto optionGroups(List<OptionGroupDto>? optionGroups);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UpdateMenuItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateMenuItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateMenuItemDto call({
    String? categoryId,
    String? name,
    String? description,
    num? price,
    UpdateMenuItemDtoCourseEnum? course,
    UpdateMenuItemDtoKindEnum? kind,
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
/// Use as `instanceOfUpdateMenuItemDto.copyWith(...)` or call `instanceOfUpdateMenuItemDto.copyWith.fieldName(value)` for a single field.
class _$UpdateMenuItemDtoCWProxyImpl implements _$UpdateMenuItemDtoCWProxy {
  const _$UpdateMenuItemDtoCWProxyImpl(this._value);

  final UpdateMenuItemDto _value;

  @override
  UpdateMenuItemDto categoryId(String? categoryId) =>
      call(categoryId: categoryId);

  @override
  UpdateMenuItemDto name(String? name) => call(name: name);

  @override
  UpdateMenuItemDto description(String? description) =>
      call(description: description);

  @override
  UpdateMenuItemDto price(num? price) => call(price: price);

  @override
  UpdateMenuItemDto course(UpdateMenuItemDtoCourseEnum? course) =>
      call(course: course);

  @override
  UpdateMenuItemDto kind(UpdateMenuItemDtoKindEnum? kind) => call(kind: kind);

  @override
  UpdateMenuItemDto prepMinutes(num? prepMinutes) =>
      call(prepMinutes: prepMinutes);

  @override
  UpdateMenuItemDto isAvailable(bool? isAvailable) =>
      call(isAvailable: isAvailable);

  @override
  UpdateMenuItemDto isPreorderable(bool? isPreorderable) =>
      call(isPreorderable: isPreorderable);

  @override
  UpdateMenuItemDto isAlcohol(bool? isAlcohol) => call(isAlcohol: isAlcohol);

  @override
  UpdateMenuItemDto leadHours(num? leadHours) => call(leadHours: leadHours);

  @override
  UpdateMenuItemDto tags(List<String>? tags) => call(tags: tags);

  @override
  UpdateMenuItemDto sortOrder(num? sortOrder) => call(sortOrder: sortOrder);

  @override
  UpdateMenuItemDto optionGroups(List<OptionGroupDto>? optionGroups) =>
      call(optionGroups: optionGroups);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UpdateMenuItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateMenuItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  UpdateMenuItemDto call({
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
    return UpdateMenuItemDto(
      categoryId: categoryId == const $CopyWithPlaceholder()
          ? _value.categoryId
          // ignore: cast_nullable_to_non_nullable
          : categoryId as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as num?,
      course: course == const $CopyWithPlaceholder()
          ? _value.course
          // ignore: cast_nullable_to_non_nullable
          : course as UpdateMenuItemDtoCourseEnum?,
      kind: kind == const $CopyWithPlaceholder()
          ? _value.kind
          // ignore: cast_nullable_to_non_nullable
          : kind as UpdateMenuItemDtoKindEnum?,
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

extension $UpdateMenuItemDtoCopyWith on UpdateMenuItemDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateMenuItemDto.copyWith(...)` or `instanceOfUpdateMenuItemDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateMenuItemDtoCWProxy get copyWith =>
      _$UpdateMenuItemDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMenuItemDto _$UpdateMenuItemDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateMenuItemDto', json, ($checkedConvert) {
      final val = UpdateMenuItemDto(
        categoryId: $checkedConvert('categoryId', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
        description: $checkedConvert('description', (v) => v as String?),
        price: $checkedConvert('price', (v) => v as num?),
        course: $checkedConvert(
          'course',
          (v) => $enumDecodeNullable(_$UpdateMenuItemDtoCourseEnumEnumMap, v),
        ),
        kind: $checkedConvert(
          'kind',
          (v) => $enumDecodeNullable(_$UpdateMenuItemDtoKindEnumEnumMap, v),
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

Map<String, dynamic> _$UpdateMenuItemDtoToJson(UpdateMenuItemDto instance) =>
    <String, dynamic>{
      'categoryId': ?instance.categoryId,
      'name': ?instance.name,
      'description': ?instance.description,
      'price': ?instance.price,
      'course': ?_$UpdateMenuItemDtoCourseEnumEnumMap[instance.course],
      'kind': ?_$UpdateMenuItemDtoKindEnumEnumMap[instance.kind],
      'prepMinutes': ?instance.prepMinutes,
      'isAvailable': ?instance.isAvailable,
      'isPreorderable': ?instance.isPreorderable,
      'isAlcohol': ?instance.isAlcohol,
      'leadHours': ?instance.leadHours,
      'tags': ?instance.tags,
      'sortOrder': ?instance.sortOrder,
      'optionGroups': ?instance.optionGroups?.map((e) => e.toJson()).toList(),
    };

const _$UpdateMenuItemDtoCourseEnumEnumMap = {
  UpdateMenuItemDtoCourseEnum.DRINK: 'DRINK',
  UpdateMenuItemDtoCourseEnum.STARTER: 'STARTER',
  UpdateMenuItemDtoCourseEnum.MAIN: 'MAIN',
  UpdateMenuItemDtoCourseEnum.DESSERT: 'DESSERT',
};

const _$UpdateMenuItemDtoKindEnumEnumMap = {
  UpdateMenuItemDtoKindEnum.DISH: 'DISH',
  UpdateMenuItemDtoKindEnum.DRINK: 'DRINK',
  UpdateMenuItemDtoKindEnum.SET: 'SET',
  UpdateMenuItemDtoKindEnum.ADD_ON: 'ADD_ON',
};
