// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_view_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GroupViewDtoCWProxy {
  GroupViewDto token(String token);

  GroupViewDto link(String link);

  GroupViewDto bookingId(String bookingId);

  GroupViewDto status(BookingStatus status);

  GroupViewDto restaurant(GroupRestaurantDto restaurant);

  GroupViewDto arrivalAt(String arrivalAt);

  GroupViewDto partySize(num partySize);

  GroupViewDto cutoffAt(String cutoffAt);

  GroupViewDto locked(bool locked);

  GroupViewDto maxGuests(num maxGuests);

  GroupViewDto guests(List<GroupGuestDto> guests);

  GroupViewDto items(List<GroupItemDto> items);

  GroupViewDto total(num total);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GroupViewDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GroupViewDto(...).copyWith(id: 12, name: "My name")
  /// ```
  GroupViewDto call({
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
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGroupViewDto.copyWith(...)` or call `instanceOfGroupViewDto.copyWith.fieldName(value)` for a single field.
class _$GroupViewDtoCWProxyImpl implements _$GroupViewDtoCWProxy {
  const _$GroupViewDtoCWProxyImpl(this._value);

  final GroupViewDto _value;

  @override
  GroupViewDto token(String token) => call(token: token);

  @override
  GroupViewDto link(String link) => call(link: link);

  @override
  GroupViewDto bookingId(String bookingId) => call(bookingId: bookingId);

  @override
  GroupViewDto status(BookingStatus status) => call(status: status);

  @override
  GroupViewDto restaurant(GroupRestaurantDto restaurant) =>
      call(restaurant: restaurant);

  @override
  GroupViewDto arrivalAt(String arrivalAt) => call(arrivalAt: arrivalAt);

  @override
  GroupViewDto partySize(num partySize) => call(partySize: partySize);

  @override
  GroupViewDto cutoffAt(String cutoffAt) => call(cutoffAt: cutoffAt);

  @override
  GroupViewDto locked(bool locked) => call(locked: locked);

  @override
  GroupViewDto maxGuests(num maxGuests) => call(maxGuests: maxGuests);

  @override
  GroupViewDto guests(List<GroupGuestDto> guests) => call(guests: guests);

  @override
  GroupViewDto items(List<GroupItemDto> items) => call(items: items);

  @override
  GroupViewDto total(num total) => call(total: total);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `GroupViewDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GroupViewDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GroupViewDto call({
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
  }) {
    return GroupViewDto(
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
    );
  }
}

extension $GroupViewDtoCopyWith on GroupViewDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGroupViewDto.copyWith(...)` or `instanceOfGroupViewDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GroupViewDtoCWProxy get copyWith => _$GroupViewDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupViewDto _$GroupViewDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GroupViewDto', json, ($checkedConvert) {
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
        ],
      );
      final val = GroupViewDto(
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
      );
      return val;
    });

Map<String, dynamic> _$GroupViewDtoToJson(GroupViewDto instance) =>
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
