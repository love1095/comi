//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'booking_table_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BookingTableDto {
  /// Returns a new [BookingTableDto] instance.
  BookingTableDto({

    required  this.id,

    required  this.code,

    required  this.areaId,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'code',
    required: true,
    includeIfNull: false,
  )


  final String code;



  @JsonKey(
    
    name: r'areaId',
    required: true,
    includeIfNull: false,
  )


  final String areaId;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is BookingTableDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            code,
            areaId,
        ],
        [
            other.id,
            other.code,
            other.areaId,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        code,
        areaId,
    ],);

  factory BookingTableDto.fromJson(Map<String, dynamic> json) => _$BookingTableDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BookingTableDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

