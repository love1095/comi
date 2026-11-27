//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'split_guest_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SplitGuestDto {
  /// Returns a new [SplitGuestDto] instance.
  SplitGuestDto({

    required  this.id,

    required  this.displayName,

    required  this.isHost,

    required  this.amountDue,

    required  this.amountPaid,

     this.paidAt,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'displayName',
    required: true,
    includeIfNull: false,
  )


  final String displayName;



  @JsonKey(
    
    name: r'isHost',
    required: true,
    includeIfNull: false,
  )


  final bool isHost;



  @JsonKey(
    
    name: r'amountDue',
    required: true,
    includeIfNull: false,
  )


  final num amountDue;



  @JsonKey(
    
    name: r'amountPaid',
    required: true,
    includeIfNull: false,
  )


  final num amountPaid;



  @JsonKey(
    
    name: r'paidAt',
    required: false,
    includeIfNull: false,
  )


  final String? paidAt;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is SplitGuestDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            displayName,
            isHost,
            amountDue,
            amountPaid,
            paidAt,
        ],
        [
            other.id,
            other.displayName,
            other.isHost,
            other.amountDue,
            other.amountPaid,
            other.paidAt,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        displayName,
        isHost,
        amountDue,
        amountPaid,
        paidAt,
    ],);

  factory SplitGuestDto.fromJson(Map<String, dynamic> json) => _$SplitGuestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SplitGuestDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

