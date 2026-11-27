# comi_api.api.AdminApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminRestaurantsApprove**](AdminApi.md#adminrestaurantsapprove) | **POST** /api/v1/admin/restaurants/{id}/approve | 
[**adminRestaurantsGet**](AdminApi.md#adminrestaurantsget) | **GET** /api/v1/admin/restaurants/{id} | 
[**adminRestaurantsList**](AdminApi.md#adminrestaurantslist) | **GET** /api/v1/admin/restaurants | 
[**adminRestaurantsPause**](AdminApi.md#adminrestaurantspause) | **POST** /api/v1/admin/restaurants/{id}/pause | 
[**adminRestaurantsReject**](AdminApi.md#adminrestaurantsreject) | **POST** /api/v1/admin/restaurants/{id}/reject | 


# **adminRestaurantsApprove**
> adminRestaurantsApprove(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String id = id_example; // String | 

try {
    api.adminRestaurantsApprove(id);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminRestaurantsApprove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminRestaurantsGet**
> adminRestaurantsGet(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String id = id_example; // String | 

try {
    api.adminRestaurantsGet(id);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminRestaurantsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminRestaurantsList**
> adminRestaurantsList(status)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String status = status_example; // String | 

try {
    api.adminRestaurantsList(status);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminRestaurantsList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminRestaurantsPause**
> adminRestaurantsPause(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String id = id_example; // String | 

try {
    api.adminRestaurantsPause(id);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminRestaurantsPause: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminRestaurantsReject**
> adminRestaurantsReject(id, rejectDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String id = id_example; // String | 
final RejectDto rejectDto = ; // RejectDto | 

try {
    api.adminRestaurantsReject(id, rejectDto);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminRestaurantsReject: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **rejectDto** | [**RejectDto**](RejectDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

