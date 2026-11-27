//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'kitchen_status_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class KitchenStatusDto {
  /// Returns a new [KitchenStatusDto] instance.
  KitchenStatusDto({

    required  this.status,
  });

  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final KitchenStatusDtoStatusEnum status;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is KitchenStatusDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            status,
        ],
        [
            other.status,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        status,
    ],);

  factory KitchenStatusDto.fromJson(Map<String, dynamic> json) => _$KitchenStatusDtoFromJson(json);

  Map<String, dynamic> toJson() => _$KitchenStatusDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum KitchenStatusDtoStatusEnum {
@JsonValue(r'QUEUED')
QUEUED(r'QUEUED'),
@JsonValue(r'COOKING')
COOKING(r'COOKING'),
@JsonValue(r'READY')
READY(r'READY'),
@JsonValue(r'SERVED')
SERVED(r'SERVED');

const KitchenStatusDtoStatusEnum(this.value);

final String value;

@override
String toString() => value;
}


