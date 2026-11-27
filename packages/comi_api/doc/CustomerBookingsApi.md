# comi_api.api.CustomerBookingsApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**bookingsCancel**](CustomerBookingsApi.md#bookingscancel) | **POST** /api/v1/bookings/{id}/cancel | 
[**bookingsCreate**](CustomerBookingsApi.md#bookingscreate) | **POST** /api/v1/bookings | 
[**bookingsGet**](CustomerBookingsApi.md#bookingsget) | **GET** /api/v1/bookings/{id} | 
[**bookingsList**](CustomerBookingsApi.md#bookingslist) | **GET** /api/v1/bookings | 
[**bookingsReorder**](CustomerBookingsApi.md#bookingsreorder) | **POST** /api/v1/bookings/{id}/reorder | 


# **bookingsCancel**
> CustomerBookingDto bookingsCancel(id, cancelDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerBookingsApi();
final String id = id_example; // String | 
final CancelDto cancelDto = ; // CancelDto | 

try {
    final response = api.bookingsCancel(id, cancelDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerBookingsApi->bookingsCancel: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **cancelDto** | [**CancelDto**](CancelDto.md)|  | 

### Return type

[**CustomerBookingDto**](CustomerBookingDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsCreate**
> CustomerBookingDto bookingsCreate(idempotencyKey, createBookingDto, idempotencyKey2)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerBookingsApi();
final String idempotencyKey = idempotencyKey_example; // String | 
final CreateBookingDto createBookingDto = ; // CreateBookingDto | 
final String idempotencyKey2 = idempotencyKey_example; // String | Random per checkout; retries return the first result

try {
    final response = api.bookingsCreate(idempotencyKey, createBookingDto, idempotencyKey2);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerBookingsApi->bookingsCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idempotencyKey** | **String**|  | 
 **createBookingDto** | [**CreateBookingDto**](CreateBookingDto.md)|  | 
 **idempotencyKey2** | **String**| Random per checkout; retries return the first result | [optional] 

### Return type

[**CustomerBookingDto**](CustomerBookingDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsGet**
> CustomerBookingDto bookingsGet(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerBookingsApi();
final String id = id_example; // String | 

try {
    final response = api.bookingsGet(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerBookingsApi->bookingsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**CustomerBookingDto**](CustomerBookingDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsList**
> MyBookingsPageDto bookingsList(status, cursor, limit)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerBookingsApi();
final String status = status_example; // String | 
final String cursor = cursor_example; // String | 
final num limit = 8.14; // num | 

try {
    final response = api.bookingsList(status, cursor, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerBookingsApi->bookingsList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**|  | [optional] 
 **cursor** | **String**|  | [optional] 
 **limit** | **num**|  | [optional] 

### Return type

[**MyBookingsPageDto**](MyBookingsPageDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsReorder**
> ReorderDraftDto bookingsReorder(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerBookingsApi();
final String id = id_example; // String | 

try {
    final response = api.bookingsReorder(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerBookingsApi->bookingsReorder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ReorderDraftDto**](ReorderDraftDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

