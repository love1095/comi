//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'reorder_line_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReorderLineDto {
  /// Returns a new [ReorderLineDto] instance.
  ReorderLineDto({

    required  this.menuItemId,

    required  this.name,

    required  this.price,

    required  this.quantity,

     this.note,
  });

  @JsonKey(
    
    name: r'menuItemId',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'price',
    required: true,
    includeIfNull: false,
  )


  final num price;



  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final num quantity;



  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ReorderLineDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            menuItemId,
            name,
            price,
            quantity,
            note,
        ],
        [
            other.menuItemId,
            other.name,
            other.price,
            other.quantity,
            other.note,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        menuItemId,
        name,
        price,
        quantity,
        note,
    ],);

  factory ReorderLineDto.fromJson(Map<String, dynamic> json) => _$ReorderLineDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReorderLineDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

