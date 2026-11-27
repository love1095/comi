// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MembershipDtoCWProxy {
  MembershipDto role(StaffRole role);

  MembershipDto restaurant(RestaurantSummaryDto restaurant);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MembershipDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MembershipDto(...).copyWith(id: 12, name: "My name")
  /// ```
  MembershipDto call({StaffRole role, RestaurantSummaryDto restaurant});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMembershipDto.copyWith(...)` or call `instanceOfMembershipDto.copyWith.fieldName(value)` for a single field.
class _$MembershipDtoCWProxyImpl implements _$MembershipDtoCWProxy {
  const _$MembershipDtoCWProxyImpl(this._value);

  final MembershipDto _value;

  @override
  MembershipDto role(StaffRole role) => call(role: role);

  @override
  MembershipDto restaurant(RestaurantSummaryDto restaurant) =>
      call(restaurant: restaurant);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MembershipDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MembershipDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MembershipDto call({
    Object? role = const $CopyWithPlaceholder(),
    Object? restaurant = const $CopyWithPlaceholder(),
  }) {
    return MembershipDto(
      role: role == const $CopyWithPlaceholder() || role == null
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as StaffRole,
      restaurant:
          restaurant == const $CopyWithPlaceholder() || restaurant == null
          ? _value.restaurant
          // ignore: cast_nullable_to_non_nullable
          : restaurant as RestaurantSummaryDto,
    );
  }
}

extension $MembershipDtoCopyWith on MembershipDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMembershipDto.copyWith(...)` or `instanceOfMembershipDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MembershipDtoCWProxy get copyWith => _$MembershipDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipDto _$MembershipDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MembershipDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['role', 'restaurant']);
      final val = MembershipDto(
        role: $checkedConvert(
          'role',
          (v) => $enumDecode(_$StaffRoleEnumMap, v),
        ),
        restaurant: $checkedConvert(
          'restaurant',
          (v) => RestaurantSummaryDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MembershipDtoToJson(MembershipDto instance) =>
    <String, dynamic>{
      'role': _$StaffRoleEnumMap[instance.role]!,
      'restaurant': instance.restaurant.toJson(),
    };

const _$StaffRoleEnumMap = {
  StaffRole.OWNER: 'OWNER',
  StaffRole.MANAGER: 'MANAGER',
  StaffRole.CASHIER: 'CASHIER',
  StaffRole.KITCHEN: 'KITCHEN',
};
