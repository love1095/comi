# comi_api.api.RestaurantBookingsApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**restaurantBookingsApprove**](RestaurantBookingsApi.md#restaurantbookingsapprove) | **POST** /api/v1/restaurant/bookings/{id}/approve | 
[**restaurantBookingsCancel**](RestaurantBookingsApi.md#restaurantbookingscancel) | **POST** /api/v1/restaurant/bookings/{id}/cancel | 
[**restaurantBookingsGet**](RestaurantBookingsApi.md#restaurantbookingsget) | **GET** /api/v1/restaurant/bookings/{id} | 
[**restaurantBookingsList**](RestaurantBookingsApi.md#restaurantbookingslist) | **GET** /api/v1/restaurant/bookings | 
[**restaurantBookingsMoveTable**](RestaurantBookingsApi.md#restaurantbookingsmovetable) | **POST** /api/v1/restaurant/bookings/{id}/move-table | 


# **restaurantBookingsApprove**
> BookingDetailDto restaurantBookingsApprove(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantBookingsApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantBookingsApprove(id, xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantBookingsApi->restaurantBookingsApprove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

[**BookingDetailDto**](BookingDetailDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantBookingsCancel**
> BookingDetailDto restaurantBookingsCancel(id, xRestaurantId, restaurantCancelDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantBookingsApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final RestaurantCancelDto restaurantCancelDto = ; // RestaurantCancelDto | 

try {
    final response = api.restaurantBookingsCancel(id, xRestaurantId, restaurantCancelDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantBookingsApi->restaurantBookingsCancel: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **restaurantCancelDto** | [**RestaurantCancelDto**](RestaurantCancelDto.md)|  | 

### Return type

[**BookingDetailDto**](BookingDetailDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantBookingsGet**
> BookingDetailDto restaurantBookingsGet(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantBookingsApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantBookingsGet(id, xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantBookingsApi->restaurantBookingsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

[**BookingDetailDto**](BookingDetailDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantBookingsList**
> List<BoardBookingDto> restaurantBookingsList(date, xRestaurantId, status, q)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantBookingsApi();
final String date = 2026-12-02; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final String status = status_example; // String | 
final String q = q_example; // String | Booking code or phone

try {
    final response = api.restaurantBookingsList(date, xRestaurantId, status, q);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantBookingsApi->restaurantBookingsList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **status** | **String**|  | [optional] 
 **q** | **String**| Booking code or phone | [optional] 

### Return type

[**List&lt;BoardBookingDto&gt;**](BoardBookingDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantBookingsMoveTable**
> BookingDetailDto restaurantBookingsMoveTable(id, xRestaurantId, moveTableDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantBookingsApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final MoveTableDto moveTableDto = ; // MoveTableDto | 

try {
    final response = api.restaurantBookingsMoveTable(id, xRestaurantId, moveTableDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantBookingsApi->restaurantBookingsMoveTable: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **moveTableDto** | [**MoveTableDto**](MoveTableDto.md)|  | 

### Return type

[**BookingDetailDto**](BookingDetailDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

