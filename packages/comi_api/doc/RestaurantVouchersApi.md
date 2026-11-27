# comi_api.api.RestaurantVouchersApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**restaurantVouchersActive**](RestaurantVouchersApi.md#restaurantvouchersactive) | **PATCH** /api/v1/restaurant/vouchers/{id} | 
[**restaurantVouchersCreate**](RestaurantVouchersApi.md#restaurantvoucherscreate) | **POST** /api/v1/restaurant/vouchers | 
[**restaurantVouchersList**](RestaurantVouchersApi.md#restaurantvoucherslist) | **GET** /api/v1/restaurant/vouchers | 


# **restaurantVouchersActive**
> VoucherDto restaurantVouchersActive(id, xRestaurantId, voucherActiveDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantVouchersApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final VoucherActiveDto voucherActiveDto = ; // VoucherActiveDto | 

try {
    final response = api.restaurantVouchersActive(id, xRestaurantId, voucherActiveDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantVouchersApi->restaurantVouchersActive: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **voucherActiveDto** | [**VoucherActiveDto**](VoucherActiveDto.md)|  | 

### Return type

[**VoucherDto**](VoucherDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantVouchersCreate**
> VoucherDto restaurantVouchersCreate(xRestaurantId, voucherInputDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantVouchersApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final VoucherInputDto voucherInputDto = ; // VoucherInputDto | 

try {
    final response = api.restaurantVouchersCreate(xRestaurantId, voucherInputDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantVouchersApi->restaurantVouchersCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **voucherInputDto** | [**VoucherInputDto**](VoucherInputDto.md)|  | 

### Return type

[**VoucherDto**](VoucherDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantVouchersList**
> List<VoucherDto> restaurantVouchersList(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantVouchersApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantVouchersList(xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantVouchersApi->restaurantVouchersList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

[**List&lt;VoucherDto&gt;**](VoucherDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

