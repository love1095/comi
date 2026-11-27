//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'invoice_request_create_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InvoiceRequestCreateDto {
  /// Returns a new [InvoiceRequestCreateDto] instance.
  InvoiceRequestCreateDto({

    required  this.companyName,

    required  this.taxCode,

    required  this.address,

    required  this.email,

     this.saveProfile,
  });

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



      /// Save for next time
  @JsonKey(
    
    name: r'saveProfile',
    required: false,
    includeIfNull: false,
  )


  final bool? saveProfile;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is InvoiceRequestCreateDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            companyName,
            taxCode,
            address,
            email,
            saveProfile,
        ],
        [
            other.companyName,
            other.taxCode,
            other.address,
            other.email,
            other.saveProfile,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        companyName,
        taxCode,
        address,
        email,
        saveProfile,
    ],);

  factory InvoiceRequestCreateDto.fromJson(Map<String, dynamic> json) => _$InvoiceRequestCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceRequestCreateDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

