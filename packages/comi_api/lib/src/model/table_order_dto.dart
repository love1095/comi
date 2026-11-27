//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/cart_line_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'table_order_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TableOrderDto {
  /// Returns a new [TableOrderDto] instance.
  TableOrderDto({

    required  this.items,

     this.ageConfirmed,
  });

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
      other is TableOrderDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            items,
            ageConfirmed,
        ],
        [
            other.items,
            other.ageConfirmed,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        items,
        ageConfirmed,
    ],);

  factory TableOrderDto.fromJson(Map<String, dynamic> json) => _$TableOrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TableOrderDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

