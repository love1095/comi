//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'group_guest_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GroupGuestDto {
  /// Returns a new [GroupGuestDto] instance.
  GroupGuestDto({

    required  this.id,

    required  this.displayName,

    required  this.isHost,

    required  this.subtotal,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'displayName',
    required: true,
    includeIfNull: false,
  )


  final String displayName;



  @JsonKey(
    
    name: r'isHost',
    required: true,
    includeIfNull: false,
  )


  final bool isHost;



      /// Their dishes so far (VND)
  @JsonKey(
    
    name: r'subtotal',
    required: true,
    includeIfNull: false,
  )


  final num subtotal;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GroupGuestDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            displayName,
            isHost,
            subtotal,
        ],
        [
            other.id,
            other.displayName,
            other.isHost,
            other.subtotal,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        displayName,
        isHost,
        subtotal,
    ],);

  factory GroupGuestDto.fromJson(Map<String, dynamic> json) => _$GroupGuestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GroupGuestDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

