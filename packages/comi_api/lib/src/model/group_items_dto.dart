//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/cart_line_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'group_items_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GroupItemsDto {
  /// Returns a new [GroupItemsDto] instance.
  GroupItemsDto({

    required  this.guestKey,

    required  this.items,

     this.ageConfirmed,
  });

  @JsonKey(
    
    name: r'guestKey',
    required: true,
    includeIfNull: false,
  )


  final String guestKey;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<CartLineDto> items;



  @JsonKey(
    
    name: r'ageConfirmed',
    required: false,
    includeIfNull: false,
  )


  final bool? ageConfirmed;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GroupItemsDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            guestKey,
            items,
            ageConfirmed,
        ],
        [
            other.guestKey,
            other.items,
            other.ageConfirmed,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        guestKey,
        items,
        ageConfirmed,
    ],);

  factory GroupItemsDto.fromJson(Map<String, dynamic> json) => _$GroupItemsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GroupItemsDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

