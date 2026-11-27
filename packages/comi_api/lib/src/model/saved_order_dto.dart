//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/cart_line_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'saved_order_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SavedOrderDto {
  /// Returns a new [SavedOrderDto] instance.
  SavedOrderDto({

    required  this.restaurantId,

     this.name = 'My usual',

    required  this.items,
  });

  @JsonKey(
    
    name: r'restaurantId',
    required: true,
    includeIfNull: false,
  )


  final String restaurantId;



  @JsonKey(
    defaultValue: 'My usual',
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<CartLineDto> items;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is SavedOrderDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            restaurantId,
            name,
            items,
        ],
        [
            other.restaurantId,
            other.name,
            other.items,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        restaurantId,
        name,
        items,
    ],);

  factory SavedOrderDto.fromJson(Map<String, dynamic> json) => _$SavedOrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SavedOrderDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

