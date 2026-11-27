# comi_api.api.RestaurantPaymentsApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**restaurantPaymentsAccount**](RestaurantPaymentsApi.md#restaurantpaymentsaccount) | **GET** /api/v1/restaurant/payment-account | 
[**restaurantPaymentsConnect**](RestaurantPaymentsApi.md#restaurantpaymentsconnect) | **PUT** /api/v1/restaurant/payment-account | 
[**restaurantPaymentsDisconnect**](RestaurantPaymentsApi.md#restaurantpaymentsdisconnect) | **DELETE** /api/v1/restaurant/payment-account | 
[**restaurantPaymentsDone**](RestaurantPaymentsApi.md#restaurantpaymentsdone) | **POST** /api/v1/restaurant/refunds/{id}/done | 
[**restaurantPaymentsRefunds**](RestaurantPaymentsApi.md#restaurantpaymentsrefunds) | **GET** /api/v1/restaurant/refunds | 


# **restaurantPaymentsAccount**
> PaymentAccountStatusDto restaurantPaymentsAccount(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantPaymentsApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantPaymentsAccount(xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantPaymentsApi->restaurantPaymentsAccount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

[**PaymentAccountStatusDto**](PaymentAccountStatusDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantPaymentsConnect**
> PaymentAccountStatusDto restaurantPaymentsConnect(xRestaurantId, connectPayOsDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantPaymentsApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final ConnectPayOsDto connectPayOsDto = ; // ConnectPayOsDto | 

try {
    final response = api.restaurantPaymentsConnect(xRestaurantId, connectPayOsDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantPaymentsApi->restaurantPaymentsConnect: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **connectPayOsDto** | [**ConnectPayOsDto**](ConnectPayOsDto.md)|  | 

### Return type

[**PaymentAccountStatusDto**](PaymentAccountStatusDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantPaymentsDisconnect**
> PaymentAccountStatusDto restaurantPaymentsDisconnect(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantPaymentsApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantPaymentsDisconnect(xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantPaymentsApi->restaurantPaymentsDisconnect: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

[**PaymentAccountStatusDto**](PaymentAccountStatusDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantPaymentsDone**
> RefundDto restaurantPaymentsDone(id, xRestaurantId, refundDoneDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantPaymentsApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final RefundDoneDto refundDoneDto = ; // RefundDoneDto | 

try {
    final response = api.restaurantPaymentsDone(id, xRestaurantId, refundDoneDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantPaymentsApi->restaurantPaymentsDone: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **refundDoneDto** | [**RefundDoneDto**](RefundDoneDto.md)|  | 

### Return type

[**RefundDto**](RefundDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantPaymentsRefunds**
> List<RefundDto> restaurantPaymentsRefunds(xRestaurantId, status)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantPaymentsApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final String status = status_example; // String | 

try {
    final response = api.restaurantPaymentsRefunds(xRestaurantId, status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantPaymentsApi->restaurantPaymentsRefunds: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **status** | **String**|  | [optional] 

### Return type

[**List&lt;RefundDto&gt;**](RefundDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

