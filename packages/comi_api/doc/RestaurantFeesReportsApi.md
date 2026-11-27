# comi_api.api.RestaurantFeesReportsApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**restaurantFeesPdf**](RestaurantFeesReportsApi.md#restaurantfeespdf) | **GET** /api/v1/restaurant/statements/{id}/pdf | 
[**restaurantFeesReport**](RestaurantFeesReportsApi.md#restaurantfeesreport) | **GET** /api/v1/restaurant/reports | 
[**restaurantFeesStatement**](RestaurantFeesReportsApi.md#restaurantfeesstatement) | **GET** /api/v1/restaurant/statements/{id} | 
[**restaurantFeesStatements**](RestaurantFeesReportsApi.md#restaurantfeesstatements) | **GET** /api/v1/restaurant/statements | 


# **restaurantFeesPdf**
> restaurantFeesPdf(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantFeesReportsApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.restaurantFeesPdf(id, xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantFeesReportsApi->restaurantFeesPdf: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantFeesReport**
> ReportDto restaurantFeesReport(from, to, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantFeesReportsApi();
final String from = 2026-12-01; // String | 
final String to = 2026-12-31; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantFeesReport(from, to, xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantFeesReportsApi->restaurantFeesReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **String**|  | 
 **to** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

[**ReportDto**](ReportDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantFeesStatement**
> StatementDetailDto restaurantFeesStatement(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantFeesReportsApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantFeesStatement(id, xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantFeesReportsApi->restaurantFeesStatement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

[**StatementDetailDto**](StatementDetailDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantFeesStatements**
> List<StatementDto> restaurantFeesStatements(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantFeesReportsApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantFeesStatements(xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantFeesReportsApi->restaurantFeesStatements: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

[**List&lt;StatementDto&gt;**](StatementDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

