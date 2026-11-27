//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'invoice_profile_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InvoiceProfileDto {
  /// Returns a new [InvoiceProfileDto] instance.
  InvoiceProfileDto({

    required  this.id,

    required  this.companyName,

    required  this.taxCode,

    required  this.address,

    required  this.email,

    required  this.isDefault,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'companyName',
    required: true,
    includeIfNull: false,
  )


  final String companyName;



  @JsonKey(
    
    name: r'taxCode',
    required: true,
    includeIfNull: false,
  )


  final String taxCode;



  @JsonKey(
    
    name: r'address',
    required: true,
    includeIfNull: false,
  )


  final String address;



  @JsonKey(
    
    name: r'email',
    required: true,
    includeIfNull: false,
  )


  final String email;



  @JsonKey(
    
    name: r'isDefault',
    required: true,
    includeIfNull: false,
  )


  final bool isDefault;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is InvoiceProfileDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            companyName,
            taxCode,
            address,
            email,
            isDefault,
        ],
        [
            other.id,
            other.companyName,
            other.taxCode,
            other.address,
            other.email,
            other.isDefault,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        companyName,
        taxCode,
        address,
        email,
        isDefault,
    ],);

  factory InvoiceProfileDto.fromJson(Map<String, dynamic> json) => _$InvoiceProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceProfileDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

