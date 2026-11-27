// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReplyDtoCWProxy {
  ReplyDto reply(String reply);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReplyDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReplyDto(...).copyWith(id: 12, name: "My name")
  /// ```
  ReplyDto call({String reply});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReplyDto.copyWith(...)` or call `instanceOfReplyDto.copyWith.fieldName(value)` for a single field.
class _$ReplyDtoCWProxyImpl implements _$ReplyDtoCWProxy {
  const _$ReplyDtoCWProxyImpl(this._value);

  final ReplyDto _value;

  @override
  ReplyDto reply(String reply) => call(reply: reply);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ReplyDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReplyDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ReplyDto call({Object? reply = const $CopyWithPlaceholder()}) {
    return ReplyDto(
      reply: reply == const $CopyWithPlaceholder() || reply == null
          ? _value.reply
          // ignore: cast_nullable_to_non_nullable
          : reply as String,
    );
  }
}

extension $ReplyDtoCopyWith on ReplyDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReplyDto.copyWith(...)` or `instanceOfReplyDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReplyDtoCWProxy get copyWith => _$ReplyDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyDto _$ReplyDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReplyDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['reply']);
      final val = ReplyDto(reply: $checkedConvert('reply', (v) => v as String));
      return val;
    });

Map<String, dynamic> _$ReplyDtoToJson(ReplyDto instance) => <String, dynamic>{
  'reply': instance.reply,
};
