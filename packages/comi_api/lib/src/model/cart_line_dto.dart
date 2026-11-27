//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'cart_line_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CartLineDto {
  /// Returns a new [CartLineDto] instance.
  CartLineDto({

    required  this.menuItemId,

    required  this.quantity,

     this.optionIds,

     this.note,
  });

  @JsonKey(
    
    name: r'menuItemId',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



          // minimum: 1
          // maximum: 99
  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final num quantity;



  @JsonKey(
    
    name: r'optionIds',
    required: false,
    includeIfNull: false,
  )


  final List<String>? optionIds;



  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CartLineDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            menuItemId,
            quantity,
            optionIds,
            note,
        ],
        [
            other.menuItemId,
            other.quantity,
            other.optionIds,
            other.note,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        menuItemId,
        quantity,
        optionIds,
        note,
    ],);

  factory CartLineDto.fromJson(Map<String, dynamic> json) => _$CartLineDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartLineDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

