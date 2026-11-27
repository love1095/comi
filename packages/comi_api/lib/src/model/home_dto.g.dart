// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeDtoCWProxy {
  HomeDto mode(HomeDtoModeEnum mode);

  HomeDto sections(List<HomeSectionDto> sections);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `HomeDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HomeDto(...).copyWith(id: 12, name: "My name")
  /// ```
  HomeDto call({HomeDtoModeEnum mode, List<HomeSectionDto> sections});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfHomeDto.copyWith(...)` or call `instanceOfHomeDto.copyWith.fieldName(value)` for a single field.
class _$HomeDtoCWProxyImpl implements _$HomeDtoCWProxy {
  const _$HomeDtoCWProxyImpl(this._value);

  final HomeDto _value;

  @override
  HomeDto mode(HomeDtoModeEnum mode) => call(mode: mode);

  @override
  HomeDto sections(List<HomeSectionDto> sections) => call(sections: sections);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `HomeDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HomeDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  HomeDto call({
    Object? mode = const $CopyWithPlaceholder(),
    Object? sections = const $CopyWithPlaceholder(),
  }) {
    return HomeDto(
      mode: mode == const $CopyWithPlaceholder() || mode == null
          ? _value.mode
          // ignore: cast_nullable_to_non_nullable
          : mode as HomeDtoModeEnum,
      sections: sections == const $CopyWithPlaceholder() || sections == null
          ? _value.sections
          // ignore: cast_nullable_to_non_nullable
          : sections as List<HomeSectionDto>,
    );
  }
}

extension $HomeDtoCopyWith on HomeDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfHomeDto.copyWith(...)` or `instanceOfHomeDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomeDtoCWProxy get copyWith => _$HomeDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDto _$HomeDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('HomeDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['mode', 'sections']);
      final val = HomeDto(
        mode: $checkedConvert(
          'mode',
          (v) => $enumDecode(_$HomeDtoModeEnumEnumMap, v),
        ),
        sections: $checkedConvert(
          'sections',
          (v) => (v as List<dynamic>)
              .map((e) => HomeSectionDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$HomeDtoToJson(HomeDto instance) => <String, dynamic>{
  'mode': _$HomeDtoModeEnumEnumMap[instance.mode]!,
  'sections': instance.sections.map((e) => e.toJson()).toList(),
};

const _$HomeDtoModeEnumEnumMap = {
  HomeDtoModeEnum.lunch: 'lunch',
  HomeDtoModeEnum.tonight: 'tonight',
  HomeDtoModeEnum.explore: 'explore',
};
