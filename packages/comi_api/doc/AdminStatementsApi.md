# comi_api.api.AdminStatementsApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminStatementsGenerate**](AdminStatementsApi.md#adminstatementsgenerate) | **POST** /api/v1/admin/statements/generate | 
[**adminStatementsList**](AdminStatementsApi.md#adminstatementslist) | **GET** /api/v1/admin/statements | 
[**adminStatementsPaid**](AdminStatementsApi.md#adminstatementspaid) | **POST** /api/v1/admin/statements/{id}/paid | 


# **adminStatementsGenerate**
> adminStatementsGenerate(month)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminStatementsApi();
final String month = 2026-12; // String | 

try {
    api.adminStatementsGenerate(month);
} on DioException catch (e) {
    print('Exception when calling AdminStatementsApi->adminStatementsGenerate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **month** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminStatementsList**
> List<StatementDto> adminStatementsList(status)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminStatementsApi();
final String status = status_example; // String | 

try {
    final response = api.adminStatementsList(status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminStatementsApi->adminStatementsList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**|  | [optional] 

### Return type

[**List&lt;StatementDto&gt;**](StatementDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminStatementsPaid**
> StatementDetailDto adminStatementsPaid(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminStatementsApi();
final String id = id_example; // String | 

try {
    final response = api.adminStatementsPaid(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminStatementsApi->adminStatementsPaid: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**StatementDetailDto**](StatementDetailDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

