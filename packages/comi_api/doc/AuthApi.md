# comi_api.api.AuthApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminAuthEnable**](AuthApi.md#adminauthenable) | **POST** /api/v1/auth/admin/mfa/enable | 
[**adminAuthLogin**](AuthApi.md#adminauthlogin) | **POST** /api/v1/auth/admin/login | 
[**adminAuthSetup**](AuthApi.md#adminauthsetup) | **POST** /api/v1/auth/admin/mfa/setup | 
[**authExchange**](AuthApi.md#authexchange) | **POST** /api/v1/auth/customer/exchange | 
[**authLogin**](AuthApi.md#authlogin) | **POST** /api/v1/auth/staff/login | 
[**authLogout**](AuthApi.md#authlogout) | **POST** /api/v1/auth/logout | 
[**authRefresh**](AuthApi.md#authrefresh) | **POST** /api/v1/auth/refresh | 
[**authRegister**](AuthApi.md#authregister) | **POST** /api/v1/auth/staff/register | 
[**staffAccountRemove**](AuthApi.md#staffaccountremove) | **DELETE** /api/v1/auth/staff/me | 


# **adminAuthEnable**
> adminAuthEnable(mfaCodeDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAuthApi();
final MfaCodeDto mfaCodeDto = ; // MfaCodeDto | 

try {
    api.adminAuthEnable(mfaCodeDto);
} on DioException catch (e) {
    print('Exception when calling AuthApi->adminAuthEnable: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **mfaCodeDto** | [**MfaCodeDto**](MfaCodeDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminAuthLogin**
> AdminLoginResultDto adminAuthLogin(adminLoginDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAuthApi();
final AdminLoginDto adminLoginDto = ; // AdminLoginDto | 

try {
    final response = api.adminAuthLogin(adminLoginDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->adminAuthLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **adminLoginDto** | [**AdminLoginDto**](AdminLoginDto.md)|  | 

### Return type

[**AdminLoginResultDto**](AdminLoginResultDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminAuthSetup**
> MfaSetupDto adminAuthSetup()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAuthApi();

try {
    final response = api.adminAuthSetup();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->adminAuthSetup: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MfaSetupDto**](MfaSetupDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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

# **staffAccountRemove**
> staffAccountRemove()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAuthApi();

try {
    api.staffAccountRemove();
} on DioException catch (e) {
    print('Exception when calling AuthApi->staffAccountRemove: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

