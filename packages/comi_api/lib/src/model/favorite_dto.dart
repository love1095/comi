//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'favorite_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FavoriteDto {
  /// Returns a new [FavoriteDto] instance.
  FavoriteDto({

    required  this.menuItemId,
  });

  @JsonKey(
    
    name: r'menuItemId',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is FavoriteDto &&
      runtimeType == other.runtimeType &&
      equals(
        [
            menuItemId,
        ],
        [
            other.menuItemId,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        menuItemId,
    ],);

  factory FavoriteDto.fromJson(Map<String, dynamic> json) => _$FavoriteDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

