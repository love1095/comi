# comi_api.api.AuthApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authExchange**](AuthApi.md#authexchange) | **POST** /api/v1/auth/customer/exchange | 
[**authLogin**](AuthApi.md#authlogin) | **POST** /api/v1/auth/staff/login | 
[**authLogout**](AuthApi.md#authlogout) | **POST** /api/v1/auth/logout | 
[**authRefresh**](AuthApi.md#authrefresh) | **POST** /api/v1/auth/refresh | 
[**authRegister**](AuthApi.md#authregister) | **POST** /api/v1/auth/staff/register | 


# **authExchange**
> TokenPairDto authExchange(customerExchangeDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAuthApi();
final CustomerExchangeDto customerExchangeDto = ; // CustomerExchangeDto | 

try {
    final response = api.authExchange(customerExchangeDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authExchange: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **customerExchangeDto** | [**CustomerExchangeDto**](CustomerExchangeDto.md)|  | 

### Return type

[**TokenPairDto**](TokenPairDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authLogin**
> TokenPairDto authLogin(staffLoginDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAuthApi();
final StaffLoginDto staffLoginDto = ; // StaffLoginDto | 

try {
    final response = api.authLogin(staffLoginDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **staffLoginDto** | [**StaffLoginDto**](StaffLoginDto.md)|  | 

### Return type

[**TokenPairDto**](TokenPairDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authLogout**
> authLogout(refreshDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAuthApi();
final RefreshDto refreshDto = ; // RefreshDto | 

try {
    api.authLogout(refreshDto);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authLogout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshDto** | [**RefreshDto**](RefreshDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authRefresh**
> TokenPairDto authRefresh(refreshDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAuthApi();
final RefreshDto refreshDto = ; // RefreshDto | 

try {
    final response = api.authRefresh(refreshDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authRefresh: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshDto** | [**RefreshDto**](RefreshDto.md)|  | 

### Return type

[**TokenPairDto**](TokenPairDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authRegister**
> TokenPairDto authRegister(staffRegisterDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAuthApi();
final StaffRegisterDto staffRegisterDto = ; // StaffRegisterDto | 

try {
    final response = api.authRegister(staffRegisterDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authRegister: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **staffRegisterDto** | [**StaffRegisterDto**](StaffRegisterDto.md)|  | 

### Return type

[**TokenPairDto**](TokenPairDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

