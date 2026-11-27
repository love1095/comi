//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'audit_entry_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuditEntryDto {
  /// Returns a new [AuditEntryDto] instance.
  AuditEntryDto({

    required  this.id,

    required  this.actorType,

     this.actorId,

    required  this.action,

    required  this.entity,

    required  this.entityId,

     this.data,

    required  this.createdAt,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'actorType',
    required: true,
    includeIfNull: false,
  )


  final String actorType;



  @JsonKey(
    
    name: r'actorId',
    required: false,
    includeIfNull: false,
  )


  final String? actorId;



  @JsonKey(
    
    name: r'action',
    required: true,
    includeIfNull: false,
  )


  final String action;



  @JsonKey(
    
    name: r'entity',
    required: true,
    includeIfNull: false,
  )


  final String entity;



  @JsonKey(
    
    name: r'entityId',
    required: true,
    includeIfNull: false,
  )


  final String entityId;



  @JsonKey(
    
    name: r'data',
    required: false,
    includeIfNull: false,
  )


  final Map<String, Object>? data;



  @JsonKey(
    
    name: r'createdAt',
    required: true,
    includeIfNull: false,
  )


  final String createdAt;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is AuditEntryDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            actorType,
            actorId,
            action,
            entity,
            entityId,
            data,
            createdAt,
        ],
        [
            other.id,
            other.actorType,
            other.actorId,
            other.action,
            other.entity,
            other.entityId,
            other.data,
            other.createdAt,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        actorType,
        actorId,
        action,
        entity,
        entityId,
        data,
        createdAt,
    ],);

  factory AuditEntryDto.fromJson(Map<String, dynamic> json) => _$AuditEntryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuditEntryDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

