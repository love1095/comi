//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/service_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'service_request_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ServiceRequestDto {
  /// Returns a new [ServiceRequestDto] instance.
  ServiceRequestDto({

    required  this.id,

    required  this.bookingId,

    required  this.bookingCode,

     this.tableCode,

    required  this.type,

     this.note,

    required  this.status,

    required  this.createdAt,

     this.doneAt,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'bookingId',
    required: true,
    includeIfNull: false,
  )


  final String bookingId;



  @JsonKey(
    
    name: r'bookingCode',
    required: true,
    includeIfNull: false,
  )


  final String bookingCode;



  @JsonKey(
    
    name: r'tableCode',
    required: false,
    includeIfNull: false,
  )


  final String? tableCode;



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



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final ServiceRequestDtoStatusEnum status;



  @JsonKey(
    
    name: r'createdAt',
    required: true,
    includeIfNull: false,
  )


  final String createdAt;



  @JsonKey(
    
    name: r'doneAt',
    required: false,
    includeIfNull: false,
  )


  final String? doneAt;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is ServiceRequestDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            bookingId,
            bookingCode,
            tableCode,
            type,
            note,
            status,
            createdAt,
            doneAt,
        ],
        [
            other.id,
            other.bookingId,
            other.bookingCode,
            other.tableCode,
            other.type,
            other.note,
            other.status,
            other.createdAt,
            other.doneAt,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        bookingId,
        bookingCode,
        tableCode,
        type,
        note,
        status,
        createdAt,
        doneAt,
    ],);

  factory ServiceRequestDto.fromJson(Map<String, dynamic> json) => _$ServiceRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceRequestDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum ServiceRequestDtoStatusEnum {
@JsonValue(r'OPEN')
OPEN(r'OPEN'),
@JsonValue(r'DONE')
DONE(r'DONE');

const ServiceRequestDtoStatusEnum(this.value);

final String value;

@override
String toString() => value;
}


