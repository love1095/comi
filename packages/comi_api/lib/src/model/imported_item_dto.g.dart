// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imported_item_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ImportedItemDtoCWProxy {
  ImportedItemDto row(num row);

  ImportedItemDto category(String category);

  ImportedItemDto name(String name);

  ImportedItemDto price(num price);

  ImportedItemDto course(Course course);

  ImportedItemDto kind(ItemKind kind);

  ImportedItemDto description(String? description);

  ImportedItemDto prepMinutes(num prepMinutes);

  ImportedItemDto isAlcohol(bool isAlcohol);

  ImportedItemDto tags(List<String> tags);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ImportedItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ImportedItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ImportedItemDto call({
    num row,
    String category,
    String name,
    num price,
    Course course,
    ItemKind kind,
    String? description,
    num prepMinutes,
    bool isAlcohol,
    List<String> tags,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfImportedItemDto.copyWith(...)` or call `instanceOfImportedItemDto.copyWith.fieldName(value)` for a single field.
class _$ImportedItemDtoCWProxyImpl implements _$ImportedItemDtoCWProxy {
  const _$ImportedItemDtoCWProxyImpl(this._value);

  final ImportedItemDto _value;

  @override
  ImportedItemDto row(num row) => call(row: row);

  @override
  ImportedItemDto category(String category) => call(category: category);

  @override
  ImportedItemDto name(String name) => call(name: name);

  @override
  ImportedItemDto price(num price) => call(price: price);

  @override
  ImportedItemDto course(Course course) => call(course: course);

  @override
  ImportedItemDto kind(ItemKind kind) => call(kind: kind);

  @override
  ImportedItemDto description(String? description) =>
      call(description: description);

  @override
  ImportedItemDto prepMinutes(num prepMinutes) =>
      call(prepMinutes: prepMinutes);

  @override
  ImportedItemDto isAlcohol(bool isAlcohol) => call(isAlcohol: isAlcohol);

  @override
  ImportedItemDto tags(List<String> tags) => call(tags: tags);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ImportedItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ImportedItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ImportedItemDto call({
    Object? row = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? course = const $CopyWithPlaceholder(),
    Object? kind = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? prepMinutes = const $CopyWithPlaceholder(),
    Object? isAlcohol = const $CopyWithPlaceholder(),
    Object? tags = const $CopyWithPlaceholder(),
  }) {
    return ImportedItemDto(
      row: row == const $CopyWithPlaceholder() || row == null
          ? _value.row
          // ignore: cast_nullable_to_non_nullable
          : row as num,
      category: category == const $CopyWithPlaceholder() || category == null
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
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
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      prepMinutes:
          prepMinutes == const $CopyWithPlaceholder() || prepMinutes == null
          ? _value.prepMinutes
          // ignore: cast_nullable_to_non_nullable
          : prepMinutes as num,
      isAlcohol: isAlcohol == const $CopyWithPlaceholder() || isAlcohol == null
          ? _value.isAlcohol
          // ignore: cast_nullable_to_non_nullable
          : isAlcohol as bool,
      tags: tags == const $CopyWithPlaceholder() || tags == null
          ? _value.tags
          // ignore: cast_nullable_to_non_nullable
          : tags as List<String>,
    );
  }
}

extension $ImportedItemDtoCopyWith on ImportedItemDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfImportedItemDto.copyWith(...)` or `instanceOfImportedItemDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ImportedItemDtoCWProxy get copyWith => _$ImportedItemDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportedItemDto _$ImportedItemDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ImportedItemDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'row',
          'category',
          'name',
          'price',
          'course',
          'kind',
          'prepMinutes',
          'isAlcohol',
          'tags',
        ],
      );
      final val = ImportedItemDto(
        row: $checkedConvert('row', (v) => v as num),
        category: $checkedConvert('category', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        price: $checkedConvert('price', (v) => v as num),
        course: $checkedConvert(
          'course',
          (v) => $enumDecode(_$CourseEnumMap, v),
        ),
        kind: $checkedConvert('kind', (v) => $enumDecode(_$ItemKindEnumMap, v)),
        description: $checkedConvert('description', (v) => v as String?),
        prepMinutes: $checkedConvert('prepMinutes', (v) => v as num),
        isAlcohol: $checkedConvert('isAlcohol', (v) => v as bool),
        tags: $checkedConvert(
          'tags',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ImportedItemDtoToJson(ImportedItemDto instance) =>
    <String, dynamic>{
      'row': instance.row,
      'category': instance.category,
      'name': instance.name,
      'price': instance.price,
      'course': _$CourseEnumMap[instance.course]!,
      'kind': _$ItemKindEnumMap[instance.kind]!,
      'description': ?instance.description,
      'prepMinutes': instance.prepMinutes,
      'isAlcohol': instance.isAlcohol,
      'tags': instance.tags,
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
