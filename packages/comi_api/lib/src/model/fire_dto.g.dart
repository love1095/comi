// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fire_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FireDtoCWProxy {
  FireDto course(Course? course);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `FireDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FireDto(...).copyWith(id: 12, name: "My name")
  /// ```
  FireDto call({Course? course});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFireDto.copyWith(...)` or call `instanceOfFireDto.copyWith.fieldName(value)` for a single field.
class _$FireDtoCWProxyImpl implements _$FireDtoCWProxy {
  const _$FireDtoCWProxyImpl(this._value);

  final FireDto _value;

  @override
  FireDto course(Course? course) => call(course: course);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `FireDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FireDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  FireDto call({Object? course = const $CopyWithPlaceholder()}) {
    return FireDto(
      course: course == const $CopyWithPlaceholder()
          ? _value.course
          // ignore: cast_nullable_to_non_nullable
          : course as Course?,
    );
  }
}

extension $FireDtoCopyWith on FireDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFireDto.copyWith(...)` or `instanceOfFireDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FireDtoCWProxy get copyWith => _$FireDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FireDto _$FireDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FireDto', json, ($checkedConvert) {
      final val = FireDto(
        course: $checkedConvert(
          'course',
          (v) => $enumDecodeNullable(_$CourseEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$FireDtoToJson(FireDto instance) => <String, dynamic>{
  'course': ?_$CourseEnumMap[instance.course],
};

const _$CourseEnumMap = {
  Course.DRINK: 'DRINK',
  Course.STARTER: 'STARTER',
  Course.MAIN: 'MAIN',
  Course.DESSERT: 'DESSERT',
};
