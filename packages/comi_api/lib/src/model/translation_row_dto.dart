//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'translation_row_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TranslationRowDto {
  /// Returns a new [TranslationRowDto] instance.
  TranslationRowDto({

    required  this.itemId,

    required  this.sourceName,

     this.sourceDescription,

     this.name,

     this.description,

    required  this.state,
  });

  @JsonKey(
    
    name: r'itemId',
    required: true,
    includeIfNull: false,
  )


  final String itemId;



      /// Vietnamese source
  @JsonKey(
    
    name: r'sourceName',
    required: true,
    includeIfNull: false,
  )


  final String sourceName;



  @JsonKey(
    
    name: r'sourceDescription',
    required: false,
    includeIfNull: false,
  )


  final String? sourceDescription;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



  @JsonKey(
    
    name: r'state',
    required: true,
    includeIfNull: false,
  )


  final TranslationRowDtoStateEnum state;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is TranslationRowDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            itemId,
            sourceName,
            sourceDescription,
            name,
            description,
            state,
        ],
        [
            other.itemId,
            other.sourceName,
            other.sourceDescription,
            other.name,
            other.description,
            other.state,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        itemId,
        sourceName,
        sourceDescription,
        name,
        description,
        state,
    ],);

  factory TranslationRowDto.fromJson(Map<String, dynamic> json) => _$TranslationRowDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationRowDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum TranslationRowDtoStateEnum {
@JsonValue(r'none')
none(r'none'),
@JsonValue(r'machine')
machine(r'machine'),
@JsonValue(r'human')
human(r'human');

const TranslationRowDtoStateEnum(this.value);

final String value;

@override
String toString() => value;
}


