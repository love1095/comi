// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_account_status_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentAccountStatusDtoCWProxy {
  PaymentAccountStatusDto provider(
    PaymentAccountStatusDtoProviderEnum provider,
  );

  PaymentAccountStatusDto connected(bool connected);

  PaymentAccountStatusDto clientIdHint(String? clientIdHint);

  PaymentAccountStatusDto serverReady(bool serverReady);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PaymentAccountStatusDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentAccountStatusDto(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentAccountStatusDto call({
    PaymentAccountStatusDtoProviderEnum provider,
    bool connected,
    String? clientIdHint,
    bool serverReady,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPaymentAccountStatusDto.copyWith(...)` or call `instanceOfPaymentAccountStatusDto.copyWith.fieldName(value)` for a single field.
class _$PaymentAccountStatusDtoCWProxyImpl
    implements _$PaymentAccountStatusDtoCWProxy {
  const _$PaymentAccountStatusDtoCWProxyImpl(this._value);

  final PaymentAccountStatusDto _value;

  @override
  PaymentAccountStatusDto provider(
    PaymentAccountStatusDtoProviderEnum provider,
  ) => call(provider: provider);

  @override
  PaymentAccountStatusDto connected(bool connected) =>
      call(connected: connected);

  @override
  PaymentAccountStatusDto clientIdHint(String? clientIdHint) =>
      call(clientIdHint: clientIdHint);

  @override
  PaymentAccountStatusDto serverReady(bool serverReady) =>
      call(serverReady: serverReady);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PaymentAccountStatusDto(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentAccountStatusDto(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  PaymentAccountStatusDto call({
    Object? provider = const $CopyWithPlaceholder(),
    Object? connected = const $CopyWithPlaceholder(),
    Object? clientIdHint = const $CopyWithPlaceholder(),
    Object? serverReady = const $CopyWithPlaceholder(),
  }) {
    return PaymentAccountStatusDto(
      provider: provider == const $CopyWithPlaceholder() || provider == null
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as PaymentAccountStatusDtoProviderEnum,
      connected: connected == const $CopyWithPlaceholder() || connected == null
          ? _value.connected
          // ignore: cast_nullable_to_non_nullable
          : connected as bool,
      clientIdHint: clientIdHint == const $CopyWithPlaceholder()
          ? _value.clientIdHint
          // ignore: cast_nullable_to_non_nullable
          : clientIdHint as String?,
      serverReady:
          serverReady == const $CopyWithPlaceholder() || serverReady == null
          ? _value.serverReady
          // ignore: cast_nullable_to_non_nullable
          : serverReady as bool,
    );
  }
}

extension $PaymentAccountStatusDtoCopyWith on PaymentAccountStatusDto {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPaymentAccountStatusDto.copyWith(...)` or `instanceOfPaymentAccountStatusDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentAccountStatusDtoCWProxy get copyWith =>
      _$PaymentAccountStatusDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentAccountStatusDto _$PaymentAccountStatusDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PaymentAccountStatusDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['provider', 'connected', 'serverReady'],
  );
  final val = PaymentAccountStatusDto(
    provider: $checkedConvert(
      'provider',
      (v) => $enumDecode(_$PaymentAccountStatusDtoProviderEnumEnumMap, v),
    ),
    connected: $checkedConvert('connected', (v) => v as bool),
    clientIdHint: $checkedConvert('clientIdHint', (v) => v as String?),
    serverReady: $checkedConvert('serverReady', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$PaymentAccountStatusDtoToJson(
  PaymentAccountStatusDto instance,
) => <String, dynamic>{
  'provider': _$PaymentAccountStatusDtoProviderEnumEnumMap[instance.provider]!,
  'connected': instance.connected,
  'clientIdHint': ?instance.clientIdHint,
  'serverReady': instance.serverReady,
};

const _$PaymentAccountStatusDtoProviderEnumEnumMap = {
  PaymentAccountStatusDtoProviderEnum.PAYOS: 'PAYOS',
};
