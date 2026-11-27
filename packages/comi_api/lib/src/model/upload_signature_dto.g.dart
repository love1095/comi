// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_signature_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UploadSignatureDtoCWProxy {
  UploadSignatureDto cloudName(String cloudName);

  UploadSignatureDto apiKey(String apiKey);

  UploadSignatureDto timestamp(num timestamp);

  UploadSignatureDto folder(String folder);

  UploadSignatureDto signature(String signature);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UploadSignatureDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UploadSignatureDto(...).copyWith(id: 12, name: "My name")
  /// ```
  UploadSignatureDto call({
    String cloudName,
    String apiKey,
    num timestamp,
    String folder,
    String signature,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUploadSignatureDto.copyWith(...)` or call `instanceOfUploadSignatureDto.copyWith.fieldName(value)` for a single field.
class _$UploadSignatureDtoCWProxyImpl implements _$UploadSignatureDtoCWProxy {
  const _$UploadSignatureDtoCWProxyImpl(this._value);

  final UploadSignatureDto _value;

  @override
  UploadSignatureDto cloudName(String cloudName) => call(cloudName: cloudName);

  @override
  UploadSignatureDto apiKey(String apiKey) => call(apiKey: apiKey);

  @override
  UploadSignatureDto timestamp(num timestamp) => call(timestamp: timestamp);

  @override
  UploadSignatureDto folder(String folder) => call(folder: folder);

  @override
  UploadSignatureDto signature(String signature) => call(signature: signature);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `UploadSignatureDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UploadSignatureDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  UploadSignatureDto call({
    Object? cloudName = const $CopyWithPlaceholder(),
    Object? apiKey = const $CopyWithPlaceholder(),
    Object? timestamp = const $CopyWithPlaceholder(),
    Object? folder = const $CopyWithPlaceholder(),
    Object? signature = const $CopyWithPlaceholder(),
  }) {
    return UploadSignatureDto(
      cloudName: cloudName == const $CopyWithPlaceholder() || cloudName == null
          ? _value.cloudName
          // ignore: cast_nullable_to_non_nullable
          : cloudName as String,
      apiKey: apiKey == const $CopyWithPlaceholder() || apiKey == null
          ? _value.apiKey
          // ignore: cast_nullable_to_non_nullable
          : apiKey as String,
      timestamp: timestamp == const $CopyWithPlaceholder() || timestamp == null
          ? _value.timestamp
          // ignore: cast_nullable_to_non_nullable
          : timestamp as num,
      folder: folder == const $CopyWithPlaceholder() || folder == null
          ? _value.folder
          // ignore: cast_nullable_to_non_nullable
          : folder as String,
      signature: signature == const $CopyWithPlaceholder() || signature == null
          ? _value.signature
          // ignore: cast_nullable_to_non_nullable
          : signature as String,
    );
  }
}

extension $UploadSignatureDtoCopyWith on UploadSignatureDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUploadSignatureDto.copyWith(...)` or `instanceOfUploadSignatureDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UploadSignatureDtoCWProxy get copyWith =>
      _$UploadSignatureDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadSignatureDto _$UploadSignatureDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UploadSignatureDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'cloudName',
          'apiKey',
          'timestamp',
          'folder',
          'signature',
        ],
      );
      final val = UploadSignatureDto(
        cloudName: $checkedConvert('cloudName', (v) => v as String),
        apiKey: $checkedConvert('apiKey', (v) => v as String),
        timestamp: $checkedConvert('timestamp', (v) => v as num),
        folder: $checkedConvert('folder', (v) => v as String),
        signature: $checkedConvert('signature', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$UploadSignatureDtoToJson(UploadSignatureDto instance) =>
    <String, dynamic>{
      'cloudName': instance.cloudName,
      'apiKey': instance.apiKey,
      'timestamp': instance.timestamp,
      'folder': instance.folder,
      'signature': instance.signature,
    };
