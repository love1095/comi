//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/group_restaurant_dto.dart';
import 'package:comi_api/src/model/booking_status.dart';
import 'package:comi_api/src/model/group_guest_dto.dart';
import 'package:comi_api/src/model/group_item_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'group_member_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GroupMemberDto {
  /// Returns a new [GroupMemberDto] instance.
  GroupMemberDto({

    required  this.token,

    required  this.link,

    required  this.bookingId,

    required  this.status,

    required  this.restaurant,

    required  this.arrivalAt,

    required  this.partySize,

    required  this.cutoffAt,

    required  this.locked,

    required  this.maxGuests,

    required  this.guests,

    required  this.items,

    required  this.total,

     this.guestId,

    required  this.guestKey,
  });

  @JsonKey(
    
    name: r'token',
    required: true,
    includeIfNull: false,
  )


  final String token;



      /// Share this link (Zalo, Messenger)
  @JsonKey(
    
    name: r'link',
    required: true,
    includeIfNull: false,
  )


  final String link;



  @JsonKey(
    
    name: r'bookingId',
    required: true,
    includeIfNull: false,
  )


  final String bookingId;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final BookingStatus status;



  @JsonKey(
    
    name: r'restaurant',
    required: true,
    includeIfNull: false,
  )


  final GroupRestaurantDto restaurant;



  @JsonKey(
    
    name: r'arrivalAt',
    required: true,
    includeIfNull: false,
  )


  final String arrivalAt;



  @JsonKey(
    
    name: r'partySize',
    required: true,
    includeIfNull: false,
  )


  final num partySize;



  @JsonKey(
    
    name: r'cutoffAt',
    required: true,
    includeIfNull: false,
  )


  final String cutoffAt;



  @JsonKey(
    
    name: r'locked',
    required: true,
    includeIfNull: false,
  )


  final bool locked;



  @JsonKey(
    
    name: r'maxGuests',
    required: true,
    includeIfNull: false,
  )


  final num maxGuests;



  @JsonKey(
    
    name: r'guests',
    required: true,
    includeIfNull: false,
  )


  final List<GroupGuestDto> guests;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<GroupItemDto> items;



  @JsonKey(
    
    name: r'total',
    required: true,
    includeIfNull: false,
  )


  final num total;



  @JsonKey(
    
    name: r'guestId',
    required: false,
    includeIfNull: false,
  )


  final String? guestId;



      /// Secret for adding/removing your own dishes — keep it on the device
  @JsonKey(
    
    name: r'guestKey',
    required: true,
    includeIfNull: false,
  )


  final String guestKey;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GroupMemberDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            token,
            link,
            bookingId,
            status,
            restaurant,
            arrivalAt,
            partySize,
            cutoffAt,
            locked,
            maxGuests,
            guests,
            items,
            total,
            guestId,
            guestKey,
        ],
        [
            other.token,
            other.link,
            other.bookingId,
            other.status,
            other.restaurant,
            other.arrivalAt,
            other.partySize,
            other.cutoffAt,
            other.locked,
            other.maxGuests,
            other.guests,
            other.items,
            other.total,
            other.guestId,
            other.guestKey,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        token,
        link,
        bookingId,
        status,
        restaurant,
        arrivalAt,
        partySize,
        cutoffAt,
        locked,
        maxGuests,
        guests,
        items,
        total,
        guestId,
        guestKey,
    ],);

  factory GroupMemberDto.fromJson(Map<String, dynamic> json) => _$GroupMemberDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMemberDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

