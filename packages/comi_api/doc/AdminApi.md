# comi_api.api.AdminApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminAuditLog**](AdminApi.md#adminauditlog) | **GET** /api/v1/admin/audit | 
[**adminBlock**](AdminApi.md#adminblock) | **POST** /api/v1/admin/users/{id}/block | 
[**adminBookings**](AdminApi.md#adminbookings) | **GET** /api/v1/admin/bookings | 
[**adminDashboard**](AdminApi.md#admindashboard) | **GET** /api/v1/admin/dashboard | 
[**adminResetNoShow**](AdminApi.md#adminresetnoshow) | **POST** /api/v1/admin/users/{id}/reset-no-show | 
[**adminRestaurantsApprove**](AdminApi.md#adminrestaurantsapprove) | **POST** /api/v1/admin/restaurants/{id}/approve | 
[**adminRestaurantsGet**](AdminApi.md#adminrestaurantsget) | **GET** /api/v1/admin/restaurants/{id} | 
[**adminRestaurantsList**](AdminApi.md#adminrestaurantslist) | **GET** /api/v1/admin/restaurants | 
[**adminRestaurantsPause**](AdminApi.md#adminrestaurantspause) | **POST** /api/v1/admin/restaurants/{id}/pause | 
[**adminRestaurantsReject**](AdminApi.md#adminrestaurantsreject) | **POST** /api/v1/admin/restaurants/{id}/reject | 
[**adminUsers**](AdminApi.md#adminusers) | **GET** /api/v1/admin/users | 


# **adminAuditLog**
> List<AuditEntryDto> adminAuditLog(entity, entityId, actorId, before)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String entity = entity_example; // String | 
final String entityId = entityId_example; // String | 
final String actorId = actorId_example; // String | 
final String before = before_example; // String | ISO time: older entries (paging)

try {
    final response = api.adminAuditLog(entity, entityId, actorId, before);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminAuditLog: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **entity** | **String**|  | [optional] 
 **entityId** | **String**|  | [optional] 
 **actorId** | **String**|  | [optional] 
 **before** | **String**| ISO time: older entries (paging) | [optional] 

### Return type

[**List&lt;AuditEntryDto&gt;**](AuditEntryDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminBlock**
> AdminUserDto adminBlock(id, blockDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String id = id_example; // String | 
final BlockDto blockDto = ; // BlockDto | 

try {
    final response = api.adminBlock(id, blockDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminBlock: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **blockDto** | [**BlockDto**](BlockDto.md)|  | 

### Return type

[**AdminUserDto**](AdminUserDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminBookings**
> List<AdminBookingDto> adminBookings(code, userId, restaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String code = code_example; // String | 
final String userId = userId_example; // String | 
final String restaurantId = restaurantId_example; // String | 

try {
    final response = api.adminBookings(code, userId, restaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminBookings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **code** | **String**|  | [optional] 
 **userId** | **String**|  | [optional] 
 **restaurantId** | **String**|  | [optional] 

### Return type

[**List&lt;AdminBookingDto&gt;**](AdminBookingDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminDashboard**
> AdminDashboardDto adminDashboard()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();

try {
    final response = api.adminDashboard();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminDashboard: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AdminDashboardDto**](AdminDashboardDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminResetNoShow**
> AdminUserDto adminResetNoShow(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String id = id_example; // String | 

try {
    final response = api.adminResetNoShow(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminResetNoShow: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AdminUserDto**](AdminUserDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminRestaurantsApprove**
> RestaurantProfileDto adminRestaurantsApprove(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String id = id_example; // String | 

try {
    final response = api.adminRestaurantsApprove(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminRestaurantsApprove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**RestaurantProfileDto**](RestaurantProfileDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminRestaurantsGet**
> RestaurantProfileDto adminRestaurantsGet(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String id = id_example; // String | 

try {
    final response = api.adminRestaurantsGet(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminRestaurantsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**RestaurantProfileDto**](RestaurantProfileDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminRestaurantsList**
> List<AdminRestaurantRowDto> adminRestaurantsList(status)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String status = status_example; // String | 

try {
    final response = api.adminRestaurantsList(status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminRestaurantsList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**|  | [optional] 

### Return type

[**List&lt;AdminRestaurantRowDto&gt;**](AdminRestaurantRowDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminRestaurantsPause**
> RestaurantProfileDto adminRestaurantsPause(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String id = id_example; // String | 

try {
    final response = api.adminRestaurantsPause(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminRestaurantsPause: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**RestaurantProfileDto**](RestaurantProfileDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminRestaurantsReject**
> RestaurantProfileDto adminRestaurantsReject(id, rejectDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String id = id_example; // String | 
final RejectDto rejectDto = ; // RejectDto | 

try {
    final response = api.adminRestaurantsReject(id, rejectDto);
    print(response);
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

[**RestaurantProfileDto**](RestaurantProfileDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminUsers**
> List<AdminUserDto> adminUsers(q)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminApi();
final String q = q_example; // String | 

try {
    final response = api.adminUsers(q);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**|  | [optional] 

### Return type

[**List&lt;AdminUserDto&gt;**](AdminUserDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

