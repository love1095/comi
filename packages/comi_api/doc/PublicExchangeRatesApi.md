# comi_api.api.PublicExchangeRatesApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**placesRates**](PublicExchangeRatesApi.md#placesrates) | **GET** /api/v1/exchange-rates | 
[**placesSetRates**](PublicExchangeRatesApi.md#placessetrates) | **PUT** /api/v1/admin/exchange-rates | 


# **placesRates**
> List<ExchangeRateDto> placesRates()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getPublicExchangeRatesApi();

try {
    final response = api.placesRates();
    print(response);
} on DioException catch (e) {
    print('Exception when calling PublicExchangeRatesApi->placesRates: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List&lt;ExchangeRateDto&gt;**](ExchangeRateDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesSetRates**
> List<ExchangeRateDto> placesSetRates(ratesDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getPublicExchangeRatesApi();
final RatesDto ratesDto = ; // RatesDto | 

try {
    final response = api.placesSetRates(ratesDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PublicExchangeRatesApi->placesSetRates: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ratesDto** | [**RatesDto**](RatesDto.md)|  | 

### Return type

[**List&lt;ExchangeRateDto&gt;**](ExchangeRateDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

