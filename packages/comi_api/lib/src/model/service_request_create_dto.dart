//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/service_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'service_request_create_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ServiceRequestCreateDto {
  /// Returns a new [ServiceRequestCreateDto] instance.
  ServiceRequestCreateDto({

    required  this.type,

     this.note,
  });

  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final ServiceType type;



  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ServiceRequestCreateDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            type,
            note,
        ],
        [
            other.type,
            other.note,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        type,
        note,
    ],);

  factory ServiceRequestCreateDto.fromJson(Map<String, dynamic> json) => _$ServiceRequestCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceRequestCreateDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

