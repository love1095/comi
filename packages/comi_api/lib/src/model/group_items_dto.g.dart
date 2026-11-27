// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_items_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GroupItemsDtoCWProxy {
  GroupItemsDto guestKey(String guestKey);

  GroupItemsDto items(List<CartLineDto> items);

  GroupItemsDto ageConfirmed(bool? ageConfirmed);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GroupItemsDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GroupItemsDto(...).copyWith(id: 12, name: "My name")
  /// ```
  GroupItemsDto call({
    String guestKey,
    List<CartLineDto> items,
    bool? ageConfirmed,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGroupItemsDto.copyWith(...)` or call `instanceOfGroupItemsDto.copyWith.fieldName(value)` for a single field.
class _$GroupItemsDtoCWProxyImpl implements _$GroupItemsDtoCWProxy {
  const _$GroupItemsDtoCWProxyImpl(this._value);

  final GroupItemsDto _value;

  @override
  GroupItemsDto guestKey(String guestKey) => call(guestKey: guestKey);

  @override
  GroupItemsDto items(List<CartLineDto> items) => call(items: items);

  @override
  GroupItemsDto ageConfirmed(bool? ageConfirmed) =>
      call(ageConfirmed: ageConfirmed);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GroupItemsDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GroupItemsDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GroupItemsDto call({
    Object? guestKey = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? ageConfirmed = const $CopyWithPlaceholder(),
  }) {
    return GroupItemsDto(
      guestKey: guestKey == const $CopyWithPlaceholder() || guestKey == null
          ? _value.guestKey
          // ignore: cast_nullable_to_non_nullable
          : guestKey as String,
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<CartLineDto>,
      ageConfirmed: ageConfirmed == const $CopyWithPlaceholder()
          ? _value.ageConfirmed
          // ignore: cast_nullable_to_non_nullable
          : ageConfirmed as bool?,
    );
  }
}

extension $GroupItemsDtoCopyWith on GroupItemsDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGroupItemsDto.copyWith(...)` or `instanceOfGroupItemsDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GroupItemsDtoCWProxy get copyWith => _$GroupItemsDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupItemsDto _$GroupItemsDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GroupItemsDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['guestKey', 'items']);
      final val = GroupItemsDto(
        guestKey: $checkedConvert('guestKey', (v) => v as String),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => CartLineDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        ageConfirmed: $checkedConvert('ageConfirmed', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$GroupItemsDtoToJson(GroupItemsDto instance) =>
    <String, dynamic>{
      'guestKey': instance.guestKey,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'ageConfirmed': ?instance.ageConfirmed,
    };
