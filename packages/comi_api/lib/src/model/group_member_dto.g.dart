// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GroupMemberDtoCWProxy {
  GroupMemberDto token(String token);

  GroupMemberDto link(String link);

  GroupMemberDto bookingId(String bookingId);

  GroupMemberDto status(BookingStatus status);

  GroupMemberDto restaurant(GroupRestaurantDto restaurant);

  GroupMemberDto arrivalAt(String arrivalAt);

  GroupMemberDto partySize(num partySize);

  GroupMemberDto cutoffAt(String cutoffAt);

  GroupMemberDto locked(bool locked);

  GroupMemberDto maxGuests(num maxGuests);

  GroupMemberDto guests(List<GroupGuestDto> guests);

  GroupMemberDto items(List<GroupItemDto> items);

  GroupMemberDto total(num total);

  GroupMemberDto guestId(String? guestId);

  GroupMemberDto guestKey(String guestKey);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GroupMemberDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GroupMemberDto(...).copyWith(id: 12, name: "My name")
  /// ```
  GroupMemberDto call({
    String token,
    String link,
    String bookingId,
    BookingStatus status,
    GroupRestaurantDto restaurant,
    String arrivalAt,
    num partySize,
    String cutoffAt,
    bool locked,
    num maxGuests,
    List<GroupGuestDto> guests,
    List<GroupItemDto> items,
    num total,
    String? guestId,
    String guestKey,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGroupMemberDto.copyWith(...)` or call `instanceOfGroupMemberDto.copyWith.fieldName(value)` for a single field.
class _$GroupMemberDtoCWProxyImpl implements _$GroupMemberDtoCWProxy {
  const _$GroupMemberDtoCWProxyImpl(this._value);

  final GroupMemberDto _value;

  @override
  GroupMemberDto token(String token) => call(token: token);

  @override
  GroupMemberDto link(String link) => call(link: link);

  @override
  GroupMemberDto bookingId(String bookingId) => call(bookingId: bookingId);

  @override
  GroupMemberDto status(BookingStatus status) => call(status: status);

  @override
  GroupMemberDto restaurant(GroupRestaurantDto restaurant) =>
      call(restaurant: restaurant);

  @override
  GroupMemberDto arrivalAt(String arrivalAt) => call(arrivalAt: arrivalAt);

  @override
  GroupMemberDto partySize(num partySize) => call(partySize: partySize);

  @override
  GroupMemberDto cutoffAt(String cutoffAt) => call(cutoffAt: cutoffAt);

  @override
  GroupMemberDto locked(bool locked) => call(locked: locked);

  @override
  GroupMemberDto maxGuests(num maxGuests) => call(maxGuests: maxGuests);

  @override
  GroupMemberDto guests(List<GroupGuestDto> guests) => call(guests: guests);

  @override
  GroupMemberDto items(List<GroupItemDto> items) => call(items: items);

  @override
  GroupMemberDto total(num total) => call(total: total);

  @override
  GroupMemberDto guestId(String? guestId) => call(guestId: guestId);

  @override
  GroupMemberDto guestKey(String guestKey) => call(guestKey: guestKey);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GroupMemberDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GroupMemberDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GroupMemberDto call({
    Object? token = const $CopyWithPlaceholder(),
    Object? link = const $CopyWithPlaceholder(),
    Object? bookingId = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? restaurant = const $CopyWithPlaceholder(),
    Object? arrivalAt = const $CopyWithPlaceholder(),
    Object? partySize = const $CopyWithPlaceholder(),
    Object? cutoffAt = const $CopyWithPlaceholder(),
    Object? locked = const $CopyWithPlaceholder(),
    Object? maxGuests = const $CopyWithPlaceholder(),
    Object? guests = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? guestId = const $CopyWithPlaceholder(),
    Object? guestKey = const $CopyWithPlaceholder(),
  }) {
    return GroupMemberDto(
      token: token == const $CopyWithPlaceholder() || token == null
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
      link: link == const $CopyWithPlaceholder() || link == null
          ? _value.link
          // ignore: cast_nullable_to_non_nullable
          : link as String,
      bookingId: bookingId == const $CopyWithPlaceholder() || bookingId == null
          ? _value.bookingId
          // ignore: cast_nullable_to_non_nullable
          : bookingId as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as BookingStatus,
      restaurant:
          restaurant == const $CopyWithPlaceholder() || restaurant == null
          ? _value.restaurant
          // ignore: cast_nullable_to_non_nullable
          : restaurant as GroupRestaurantDto,
      arrivalAt: arrivalAt == const $CopyWithPlaceholder() || arrivalAt == null
          ? _value.arrivalAt
          // ignore: cast_nullable_to_non_nullable
          : arrivalAt as String,
      partySize: partySize == const $CopyWithPlaceholder() || partySize == null
          ? _value.partySize
          // ignore: cast_nullable_to_non_nullable
          : partySize as num,
      cutoffAt: cutoffAt == const $CopyWithPlaceholder() || cutoffAt == null
          ? _value.cutoffAt
          // ignore: cast_nullable_to_non_nullable
          : cutoffAt as String,
      locked: locked == const $CopyWithPlaceholder() || locked == null
          ? _value.locked
          // ignore: cast_nullable_to_non_nullable
          : locked as bool,
      maxGuests: maxGuests == const $CopyWithPlaceholder() || maxGuests == null
          ? _value.maxGuests
          // ignore: cast_nullable_to_non_nullable
          : maxGuests as num,
      guests: guests == const $CopyWithPlaceholder() || guests == null
          ? _value.guests
          // ignore: cast_nullable_to_non_nullable
          : guests as List<GroupGuestDto>,
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<GroupItemDto>,
      total: total == const $CopyWithPlaceholder() || total == null
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as num,
      guestId: guestId == const $CopyWithPlaceholder()
          ? _value.guestId
          // ignore: cast_nullable_to_non_nullable
          : guestId as String?,
      guestKey: guestKey == const $CopyWithPlaceholder() || guestKey == null
          ? _value.guestKey
          // ignore: cast_nullable_to_non_nullable
          : guestKey as String,
    );
  }
}

extension $GroupMemberDtoCopyWith on GroupMemberDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGroupMemberDto.copyWith(...)` or `instanceOfGroupMemberDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GroupMemberDtoCWProxy get copyWith => _$GroupMemberDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupMemberDto _$GroupMemberDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GroupMemberDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'token',
          'link',
          'bookingId',
          'status',
          'restaurant',
          'arrivalAt',
          'partySize',
          'cutoffAt',
          'locked',
          'maxGuests',
          'guests',
          'items',
          'total',
          'guestKey',
        ],
      );
      final val = GroupMemberDto(
        token: $checkedConvert('token', (v) => v as String),
        link: $checkedConvert('link', (v) => v as String),
        bookingId: $checkedConvert('bookingId', (v) => v as String),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$BookingStatusEnumMap, v),
        ),
        restaurant: $checkedConvert(
          'restaurant',
          (v) => GroupRestaurantDto.fromJson(v as Map<String, dynamic>),
        ),
        arrivalAt: $checkedConvert('arrivalAt', (v) => v as String),
        partySize: $checkedConvert('partySize', (v) => v as num),
        cutoffAt: $checkedConvert('cutoffAt', (v) => v as String),
        locked: $checkedConvert('locked', (v) => v as bool),
        maxGuests: $checkedConvert('maxGuests', (v) => v as num),
        guests: $checkedConvert(
          'guests',
          (v) => (v as List<dynamic>)
              .map((e) => GroupGuestDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => GroupItemDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        total: $checkedConvert('total', (v) => v as num),
        guestId: $checkedConvert('guestId', (v) => v as String?),
        guestKey: $checkedConvert('guestKey', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$GroupMemberDtoToJson(GroupMemberDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'link': instance.link,
      'bookingId': instance.bookingId,
      'status': _$BookingStatusEnumMap[instance.status]!,
      'restaurant': instance.restaurant.toJson(),
      'arrivalAt': instance.arrivalAt,
      'partySize': instance.partySize,
      'cutoffAt': instance.cutoffAt,
      'locked': instance.locked,
      'maxGuests': instance.maxGuests,
      'guests': instance.guests.map((e) => e.toJson()).toList(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      'total': instance.total,
      'guestId': ?instance.guestId,
      'guestKey': instance.guestKey,
    };

const _$BookingStatusEnumMap = {
  BookingStatus.PENDING: 'PENDING',
  BookingStatus.CONFIRMED: 'CONFIRMED',
  BookingStatus.CHECKED_IN: 'CHECKED_IN',
  BookingStatus.COMPLETED: 'COMPLETED',
  BookingStatus.CANCELLED: 'CANCELLED',
  BookingStatus.NO_SHOW: 'NO_SHOW',
  BookingStatus.EXPIRED: 'EXPIRED',
};
