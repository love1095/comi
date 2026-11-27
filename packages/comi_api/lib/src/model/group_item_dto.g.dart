// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_item_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GroupItemDtoCWProxy {
  GroupItemDto id(String id);

  GroupItemDto guestId(String? guestId);

  GroupItemDto menuItemId(String menuItemId);

  GroupItemDto nameSnapshot(String nameSnapshot);

  GroupItemDto unitPrice(num unitPrice);

  GroupItemDto quantity(num quantity);

  GroupItemDto optionsSnapshot(List<OptionSnapshotDto> optionsSnapshot);

  GroupItemDto note(String? note);

  GroupItemDto course(Course course);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GroupItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GroupItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  GroupItemDto call({
    String id,
    String? guestId,
    String menuItemId,
    String nameSnapshot,
    num unitPrice,
    num quantity,
    List<OptionSnapshotDto> optionsSnapshot,
    String? note,
    Course course,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGroupItemDto.copyWith(...)` or call `instanceOfGroupItemDto.copyWith.fieldName(value)` for a single field.
class _$GroupItemDtoCWProxyImpl implements _$GroupItemDtoCWProxy {
  const _$GroupItemDtoCWProxyImpl(this._value);

  final GroupItemDto _value;

  @override
  GroupItemDto id(String id) => call(id: id);

  @override
  GroupItemDto guestId(String? guestId) => call(guestId: guestId);

  @override
  GroupItemDto menuItemId(String menuItemId) => call(menuItemId: menuItemId);

  @override
  GroupItemDto nameSnapshot(String nameSnapshot) =>
      call(nameSnapshot: nameSnapshot);

  @override
  GroupItemDto unitPrice(num unitPrice) => call(unitPrice: unitPrice);

  @override
  GroupItemDto quantity(num quantity) => call(quantity: quantity);

  @override
  GroupItemDto optionsSnapshot(List<OptionSnapshotDto> optionsSnapshot) =>
      call(optionsSnapshot: optionsSnapshot);

  @override
  GroupItemDto note(String? note) => call(note: note);

  @override
  GroupItemDto course(Course course) => call(course: course);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GroupItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GroupItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GroupItemDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? guestId = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? nameSnapshot = const $CopyWithPlaceholder(),
    Object? unitPrice = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? optionsSnapshot = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? course = const $CopyWithPlaceholder(),
  }) {
    return GroupItemDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      guestId: guestId == const $CopyWithPlaceholder()
          ? _value.guestId
          // ignore: cast_nullable_to_non_nullable
          : guestId as String?,
      menuItemId:
          menuItemId == const $CopyWithPlaceholder() || menuItemId == null
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      nameSnapshot:
          nameSnapshot == const $CopyWithPlaceholder() || nameSnapshot == null
          ? _value.nameSnapshot
          // ignore: cast_nullable_to_non_nullable
          : nameSnapshot as String,
      unitPrice: unitPrice == const $CopyWithPlaceholder() || unitPrice == null
          ? _value.unitPrice
          // ignore: cast_nullable_to_non_nullable
          : unitPrice as num,
      quantity: quantity == const $CopyWithPlaceholder() || quantity == null
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as num,
      optionsSnapshot:
          optionsSnapshot == const $CopyWithPlaceholder() ||
              optionsSnapshot == null
          ? _value.optionsSnapshot
          // ignore: cast_nullable_to_non_nullable
          : optionsSnapshot as List<OptionSnapshotDto>,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      course: course == const $CopyWithPlaceholder() || course == null
          ? _value.course
          // ignore: cast_nullable_to_non_nullable
          : course as Course,
    );
  }
}

extension $GroupItemDtoCopyWith on GroupItemDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGroupItemDto.copyWith(...)` or `instanceOfGroupItemDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GroupItemDtoCWProxy get copyWith => _$GroupItemDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupItemDto _$GroupItemDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GroupItemDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'menuItemId',
          'nameSnapshot',
          'unitPrice',
          'quantity',
          'optionsSnapshot',
          'course',
        ],
      );
      final val = GroupItemDto(
        id: $checkedConvert('id', (v) => v as String),
        guestId: $checkedConvert('guestId', (v) => v as String?),
        menuItemId: $checkedConvert('menuItemId', (v) => v as String),
        nameSnapshot: $checkedConvert('nameSnapshot', (v) => v as String),
        unitPrice: $checkedConvert('unitPrice', (v) => v as num),
        quantity: $checkedConvert('quantity', (v) => v as num),
        optionsSnapshot: $checkedConvert(
          'optionsSnapshot',
          (v) => (v as List<dynamic>)
              .map((e) => OptionSnapshotDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        note: $checkedConvert('note', (v) => v as String?),
        course: $checkedConvert(
          'course',
          (v) => $enumDecode(_$CourseEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$GroupItemDtoToJson(
  GroupItemDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'guestId': ?instance.guestId,
  'menuItemId': instance.menuItemId,
  'nameSnapshot': instance.nameSnapshot,
  'unitPrice': instance.unitPrice,
  'quantity': instance.quantity,
  'optionsSnapshot': instance.optionsSnapshot.map((e) => e.toJson()).toList(),
  'note': ?instance.note,
  'course': _$CourseEnumMap[instance.course]!,
};

const _$CourseEnumMap = {
  Course.DRINK: 'DRINK',
  Course.STARTER: 'STARTER',
  Course.MAIN: 'MAIN',
  Course.DESSERT: 'DESSERT',
};
