# comi_api.api.PublicGroupOrderApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**groupPaymentsPay**](PublicGroupOrderApi.md#grouppaymentspay) | **POST** /api/v1/groups/{token}/pay | 
[**publicGroupAdd**](PublicGroupOrderApi.md#publicgroupadd) | **POST** /api/v1/groups/{token}/items | 
[**publicGroupGet**](PublicGroupOrderApi.md#publicgroupget) | **GET** /api/v1/groups/{token} | 
[**publicGroupJoin**](PublicGroupOrderApi.md#publicgroupjoin) | **POST** /api/v1/groups/{token}/join | 
[**publicGroupRemove**](PublicGroupOrderApi.md#publicgroupremove) | **POST** /api/v1/groups/{token}/items/{itemId}/remove | 


# **groupPaymentsPay**
> PaymentDto groupPaymentsPay(token, guestKeyPayDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getPublicGroupOrderApi();
final String token = token_example; // String | 
final GuestKeyPayDto guestKeyPayDto = ; // GuestKeyPayDto | 

try {
    final response = api.groupPaymentsPay(token, guestKeyPayDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PublicGroupOrderApi->groupPaymentsPay: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**|  | 
 **guestKeyPayDto** | [**GuestKeyPayDto**](GuestKeyPayDto.md)|  | 

### Return type

[**PaymentDto**](PaymentDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publicGroupAdd**
> GroupViewDto publicGroupAdd(token, groupItemsDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getPublicGroupOrderApi();
final String token = token_example; // String | 
final GroupItemsDto groupItemsDto = ; // GroupItemsDto | 

try {
    final response = api.publicGroupAdd(token, groupItemsDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PublicGroupOrderApi->publicGroupAdd: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**|  | 
 **groupItemsDto** | [**GroupItemsDto**](GroupItemsDto.md)|  | 

### Return type

[**GroupViewDto**](GroupViewDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publicGroupGet**
> GroupViewDto publicGroupGet(token)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getPublicGroupOrderApi();
final String token = token_example; // String | 

try {
    final response = api.publicGroupGet(token);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PublicGroupOrderApi->publicGroupGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**|  | 

### Return type

[**GroupViewDto**](GroupViewDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publicGroupJoin**
> GroupMemberDto publicGroupJoin(token, joinGroupDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getPublicGroupOrderApi();
final String token = token_example; // String | 
final JoinGroupDto joinGroupDto = ; // JoinGroupDto | 

try {
    final response = api.publicGroupJoin(token, joinGroupDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PublicGroupOrderApi->publicGroupJoin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**|  | 
 **joinGroupDto** | [**JoinGroupDto**](JoinGroupDto.md)|  | 

### Return type

[**GroupMemberDto**](GroupMemberDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **publicGroupRemove**
> GroupViewDto publicGroupRemove(token, itemId, guestKeyDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getPublicGroupOrderApi();
final String token = token_example; // String | 
final String itemId = itemId_example; // String | 
final GuestKeyDto guestKeyDto = ; // GuestKeyDto | 

try {
    final response = api.publicGroupRemove(token, itemId, guestKeyDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PublicGroupOrderApi->publicGroupRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**|  | 
 **itemId** | **String**|  | 
 **guestKeyDto** | [**GuestKeyDto**](GuestKeyDto.md)|  | 

### Return type

[**GroupViewDto**](GroupViewDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

