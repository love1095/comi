# comi_api.api.RestaurantAtTheTableApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**restaurantTableApproveRound**](RestaurantAtTheTableApi.md#restauranttableapproveround) | **POST** /api/v1/restaurant/bookings/{id}/rounds/{round}/approve | 
[**restaurantTableBill**](RestaurantAtTheTableApi.md#restauranttablebill) | **GET** /api/v1/restaurant/bookings/{id}/bill | 
[**restaurantTableCheckIn**](RestaurantAtTheTableApi.md#restauranttablecheckin) | **POST** /api/v1/restaurant/bookings/{id}/check-in | 
[**restaurantTableClose**](RestaurantAtTheTableApi.md#restauranttableclose) | **POST** /api/v1/restaurant/bookings/{id}/close | 
[**restaurantTableDone**](RestaurantAtTheTableApi.md#restauranttabledone) | **POST** /api/v1/restaurant/service-requests/{id}/done | 
[**restaurantTableExtendGrace**](RestaurantAtTheTableApi.md#restauranttableextendgrace) | **POST** /api/v1/restaurant/bookings/{id}/extend-grace | 
[**restaurantTableOrder**](RestaurantAtTheTableApi.md#restauranttableorder) | **POST** /api/v1/restaurant/bookings/{id}/orders | 
[**restaurantTableRequests**](RestaurantAtTheTableApi.md#restauranttablerequests) | **GET** /api/v1/restaurant/service-requests | 


# **restaurantTableApproveRound**
> FireResultDto restaurantTableApproveRound(id, round, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantAtTheTableApi();
final String id = id_example; // String | 
final num round = 8.14; // num | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantTableApproveRound(id, round, xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantAtTheTableApi->restaurantTableApproveRound: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **round** | **num**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

[**FireResultDto**](FireResultDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantTableBill**
> BillDto restaurantTableBill(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantAtTheTableApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantTableBill(id, xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantAtTheTableApi->restaurantTableBill: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

[**BillDto**](BillDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantTableCheckIn**
> BookingDetailDto restaurantTableCheckIn(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantAtTheTableApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantTableCheckIn(id, xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantAtTheTableApi->restaurantTableCheckIn: $e\n');
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

# **restaurantTableClose**
> BookingDetailDto restaurantTableClose(id, xRestaurantId, closeBillDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantAtTheTableApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final CloseBillDto closeBillDto = ; // CloseBillDto | 

try {
    final response = api.restaurantTableClose(id, xRestaurantId, closeBillDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantAtTheTableApi->restaurantTableClose: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **closeBillDto** | [**CloseBillDto**](CloseBillDto.md)|  | 

### Return type

[**BookingDetailDto**](BookingDetailDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantTableDone**
> ServiceRequestDto restaurantTableDone(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantAtTheTableApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantTableDone(id, xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantAtTheTableApi->restaurantTableDone: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

[**ServiceRequestDto**](ServiceRequestDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantTableExtendGrace**
> BookingDetailDto restaurantTableExtendGrace(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantAtTheTableApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantTableExtendGrace(id, xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantAtTheTableApi->restaurantTableExtendGrace: $e\n');
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

# **restaurantTableOrder**
> RoundResultDto restaurantTableOrder(id, xRestaurantId, tableOrderDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantAtTheTableApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final TableOrderDto tableOrderDto = ; // TableOrderDto | 

try {
    final response = api.restaurantTableOrder(id, xRestaurantId, tableOrderDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantAtTheTableApi->restaurantTableOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **tableOrderDto** | [**TableOrderDto**](TableOrderDto.md)|  | 

### Return type

[**RoundResultDto**](RoundResultDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantTableRequests**
> List<ServiceRequestDto> restaurantTableRequests(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantAtTheTableApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantTableRequests(xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantAtTheTableApi->restaurantTableRequests: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

[**List&lt;ServiceRequestDto&gt;**](ServiceRequestDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

