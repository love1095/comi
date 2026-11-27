# comi_api.api.RestaurantSplitBillApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**restaurantSplitPaid**](RestaurantSplitBillApi.md#restaurantsplitpaid) | **POST** /api/v1/restaurant/bookings/{id}/guests/{guestId}/paid | 
[**restaurantSplitSaveSplit**](RestaurantSplitBillApi.md#restaurantsplitsavesplit) | **POST** /api/v1/restaurant/bookings/{id}/split | 
[**restaurantSplitSplit**](RestaurantSplitBillApi.md#restaurantsplitsplit) | **GET** /api/v1/restaurant/bookings/{id}/split | 


# **restaurantSplitPaid**
> SplitDto restaurantSplitPaid(id, guestId, xRestaurantId, markPaidDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantSplitBillApi();
final String id = id_example; // String | 
final String guestId = guestId_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final MarkPaidDto markPaidDto = ; // MarkPaidDto | 

try {
    final response = api.restaurantSplitPaid(id, guestId, xRestaurantId, markPaidDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantSplitBillApi->restaurantSplitPaid: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **guestId** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **markPaidDto** | [**MarkPaidDto**](MarkPaidDto.md)|  | 

### Return type

[**SplitDto**](SplitDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantSplitSaveSplit**
> SplitDto restaurantSplitSaveSplit(id, xRestaurantId, saveSplitDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantSplitBillApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final SaveSplitDto saveSplitDto = ; // SaveSplitDto | 

try {
    final response = api.restaurantSplitSaveSplit(id, xRestaurantId, saveSplitDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantSplitBillApi->restaurantSplitSaveSplit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **saveSplitDto** | [**SaveSplitDto**](SaveSplitDto.md)|  | 

### Return type

[**SplitDto**](SplitDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantSplitSplit**
> SplitDto restaurantSplitSplit(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantSplitBillApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantSplitSplit(id, xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantSplitBillApi->restaurantSplitSplit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

[**SplitDto**](SplitDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

