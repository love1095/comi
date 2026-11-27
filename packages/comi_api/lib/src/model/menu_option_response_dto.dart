//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'menu_option_response_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MenuOptionResponseDto {
  /// Returns a new [MenuOptionResponseDto] instance.
  MenuOptionResponseDto({

    required  this.id,

    required  this.name,

    required  this.priceDelta,

    required  this.sortOrder,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'priceDelta',
    required: true,
    includeIfNull: false,
  )


  final num priceDelta;



  @JsonKey(
    
    name: r'sortOrder',
    required: true,
    includeIfNull: false,
  )


  final num sortOrder;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is MenuOptionResponseDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            name,
            priceDelta,
            sortOrder,
        ],
        [
            other.id,
            other.name,
            other.priceDelta,
            other.sortOrder,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        name,
        priceDelta,
        sortOrder,
    ],);

  factory MenuOptionResponseDto.fromJson(Map<String, dynamic> json) => _$MenuOptionResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MenuOptionResponseDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

