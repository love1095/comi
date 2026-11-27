//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:comi_api/src/model/split_guest_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'split_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SplitDto {
  /// Returns a new [SplitDto] instance.
  SplitDto({

     this.mode,

    required  this.total,

    required  this.paid,

    required  this.guests,
  });

  @JsonKey(
    
    name: r'mode',
    required: false,
    includeIfNull: false,
  )


  final SplitDtoModeEnum? mode;



  @JsonKey(
    
    name: r'total',
    required: true,
    includeIfNull: false,
  )


  final num total;



  @JsonKey(
    
    name: r'paid',
    required: true,
    includeIfNull: false,
  )


  final num paid;



  @JsonKey(
    
    name: r'guests',
    required: true,
    includeIfNull: false,
  )


  final List<SplitGuestDto> guests;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is SplitDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            mode,
            total,
            paid,
            guests,
        ],
        [
            other.mode,
            other.total,
            other.paid,
            other.guests,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        mode,
        total,
        paid,
        guests,
    ],);

  factory SplitDto.fromJson(Map<String, dynamic> json) => _$SplitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SplitDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum SplitDtoModeEnum {
@JsonValue(r'EQUAL')
EQUAL(r'EQUAL'),
@JsonValue(r'BY_ITEMS')
BY_ITEMS(r'BY_ITEMS'),
@JsonValue(r'CUSTOM')
CUSTOM(r'CUSTOM');

const SplitDtoModeEnum(this.value);

final String value;

@override
String toString() => value;
}


