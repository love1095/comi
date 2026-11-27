# comi_api.api.CustomerGroupOrderApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**customerGroupLock**](CustomerGroupOrderApi.md#customergrouplock) | **POST** /api/v1/bookings/{id}/group/lock | 
[**customerGroupSaveSplit**](CustomerGroupOrderApi.md#customergroupsavesplit) | **POST** /api/v1/bookings/{id}/split | 
[**customerGroupSplit**](CustomerGroupOrderApi.md#customergroupsplit) | **GET** /api/v1/bookings/{id}/split | 
[**customerGroupStart**](CustomerGroupOrderApi.md#customergroupstart) | **POST** /api/v1/bookings/{id}/group | 


# **customerGroupLock**
> GroupViewDto customerGroupLock(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerGroupOrderApi();
final String id = id_example; // String | 

try {
    final response = api.customerGroupLock(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerGroupOrderApi->customerGroupLock: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**GroupViewDto**](GroupViewDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **customerGroupSaveSplit**
> SplitDto customerGroupSaveSplit(id, saveSplitDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerGroupOrderApi();
final String id = id_example; // String | 
final SaveSplitDto saveSplitDto = ; // SaveSplitDto | 

try {
    final response = api.customerGroupSaveSplit(id, saveSplitDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerGroupOrderApi->customerGroupSaveSplit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **saveSplitDto** | [**SaveSplitDto**](SaveSplitDto.md)|  | 

### Return type

[**SplitDto**](SplitDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **customerGroupSplit**
> SplitDto customerGroupSplit(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerGroupOrderApi();
final String id = id_example; // String | 

try {
    final response = api.customerGroupSplit(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerGroupOrderApi->customerGroupSplit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**SplitDto**](SplitDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **customerGroupStart**
> GroupMemberDto customerGroupStart(id, startGroupDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerGroupOrderApi();
final String id = id_example; // String | 
final StartGroupDto startGroupDto = ; // StartGroupDto | 

try {
    final response = api.customerGroupStart(id, startGroupDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerGroupOrderApi->customerGroupStart: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **startGroupDto** | [**StartGroupDto**](StartGroupDto.md)|  | 

### Return type

[**GroupMemberDto**](GroupMemberDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

