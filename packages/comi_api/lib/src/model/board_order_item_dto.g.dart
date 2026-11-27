// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_order_item_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BoardOrderItemDtoCWProxy {
  BoardOrderItemDto id(String id);

  BoardOrderItemDto nameSnapshot(String nameSnapshot);

  BoardOrderItemDto unitPrice(num unitPrice);

  BoardOrderItemDto quantity(num quantity);

  BoardOrderItemDto optionsSnapshot(List<OptionSnapshotDto> optionsSnapshot);

  BoardOrderItemDto note(String? note);

  BoardOrderItemDto course(Course course);

  BoardOrderItemDto kitchenStatus(KitchenStatus kitchenStatus);

  BoardOrderItemDto round(num round);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BoardOrderItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BoardOrderItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  BoardOrderItemDto call({
    String id,
    String nameSnapshot,
    num unitPrice,
    num quantity,
    List<OptionSnapshotDto> optionsSnapshot,
    String? note,
    Course course,
    KitchenStatus kitchenStatus,
    num round,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBoardOrderItemDto.copyWith(...)` or call `instanceOfBoardOrderItemDto.copyWith.fieldName(value)` for a single field.
class _$BoardOrderItemDtoCWProxyImpl implements _$BoardOrderItemDtoCWProxy {
  const _$BoardOrderItemDtoCWProxyImpl(this._value);

  final BoardOrderItemDto _value;

  @override
  BoardOrderItemDto id(String id) => call(id: id);

  @override
  BoardOrderItemDto nameSnapshot(String nameSnapshot) =>
      call(nameSnapshot: nameSnapshot);

  @override
  BoardOrderItemDto unitPrice(num unitPrice) => call(unitPrice: unitPrice);

  @override
  BoardOrderItemDto quantity(num quantity) => call(quantity: quantity);

  @override
  BoardOrderItemDto optionsSnapshot(List<OptionSnapshotDto> optionsSnapshot) =>
      call(optionsSnapshot: optionsSnapshot);

  @override
  BoardOrderItemDto note(String? note) => call(note: note);

  @override
  BoardOrderItemDto course(Course course) => call(course: course);

  @override
  BoardOrderItemDto kitchenStatus(KitchenStatus kitchenStatus) =>
      call(kitchenStatus: kitchenStatus);

  @override
  BoardOrderItemDto round(num round) => call(round: round);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `BoardOrderItemDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BoardOrderItemDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  BoardOrderItemDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? nameSnapshot = const $CopyWithPlaceholder(),
    Object? unitPrice = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? optionsSnapshot = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? course = const $CopyWithPlaceholder(),
    Object? kitchenStatus = const $CopyWithPlaceholder(),
    Object? round = const $CopyWithPlaceholder(),
  }) {
    return BoardOrderItemDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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
      kitchenStatus:
          kitchenStatus == const $CopyWithPlaceholder() || kitchenStatus == null
          ? _value.kitchenStatus
          // ignore: cast_nullable_to_non_nullable
          : kitchenStatus as KitchenStatus,
      round: round == const $CopyWithPlaceholder() || round == null
          ? _value.round
          // ignore: cast_nullable_to_non_nullable
          : round as num,
    );
  }
}

extension $BoardOrderItemDtoCopyWith on BoardOrderItemDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBoardOrderItemDto.copyWith(...)` or `instanceOfBoardOrderItemDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BoardOrderItemDtoCWProxy get copyWith =>
      _$BoardOrderItemDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardOrderItemDto _$BoardOrderItemDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BoardOrderItemDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'nameSnapshot',
          'unitPrice',
          'quantity',
          'optionsSnapshot',
          'course',
          'kitchenStatus',
          'round',
        ],
      );
      final val = BoardOrderItemDto(
        id: $checkedConvert('id', (v) => v as String),
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
        kitchenStatus: $checkedConvert(
          'kitchenStatus',
          (v) => $enumDecode(_$KitchenStatusEnumMap, v),
        ),
        round: $checkedConvert('round', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$BoardOrderItemDtoToJson(
  BoardOrderItemDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'nameSnapshot': instance.nameSnapshot,
  'unitPrice': instance.unitPrice,
  'quantity': instance.quantity,
  'optionsSnapshot': instance.optionsSnapshot.map((e) => e.toJson()).toList(),
  'note': ?instance.note,
  'course': _$CourseEnumMap[instance.course]!,
  'kitchenStatus': _$KitchenStatusEnumMap[instance.kitchenStatus]!,
  'round': instance.round,
};

const _$CourseEnumMap = {
  Course.DRINK: 'DRINK',
  Course.STARTER: 'STARTER',
  Course.MAIN: 'MAIN',
  Course.DESSERT: 'DESSERT',
};

const _$KitchenStatusEnumMap = {
  KitchenStatus.HOLD: 'HOLD',
  KitchenStatus.SCHEDULED: 'SCHEDULED',
  KitchenStatus.QUEUED: 'QUEUED',
  KitchenStatus.COOKING: 'COOKING',
  KitchenStatus.READY: 'READY',
  KitchenStatus.SERVED: 'SERVED',
  KitchenStatus.CANCELLED: 'CANCELLED',
};
