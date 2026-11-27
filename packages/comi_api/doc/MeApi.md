# comi_api.api.MeApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**meExtrasAddFavorite**](MeApi.md#meextrasaddfavorite) | **POST** /api/v1/me/favorites | 
[**meExtrasDeleteSavedOrder**](MeApi.md#meextrasdeletesavedorder) | **DELETE** /api/v1/me/saved-orders/{id} | 
[**meExtrasFavorites**](MeApi.md#meextrasfavorites) | **GET** /api/v1/me/favorites | 
[**meExtrasPreferences**](MeApi.md#meextraspreferences) | **GET** /api/v1/me/preferences | 
[**meExtrasRemoveFavorite**](MeApi.md#meextrasremovefavorite) | **DELETE** /api/v1/me/favorites/{menuItemId} | 
[**meExtrasSaveOrder**](MeApi.md#meextrassaveorder) | **PUT** /api/v1/me/saved-orders | 
[**meExtrasSavedOrders**](MeApi.md#meextrassavedorders) | **GET** /api/v1/me/saved-orders | 
[**meExtrasUpdatePreferences**](MeApi.md#meextrasupdatepreferences) | **PATCH** /api/v1/me/preferences | 
[**usersAddDeviceToken**](MeApi.md#usersadddevicetoken) | **POST** /api/v1/me/device-tokens | 
[**usersConsent**](MeApi.md#usersconsent) | **POST** /api/v1/me/consent | 
[**usersExport**](MeApi.md#usersexport) | **GET** /api/v1/me/export | 
[**usersMe**](MeApi.md#usersme) | **GET** /api/v1/me | 
[**usersRemove**](MeApi.md#usersremove) | **DELETE** /api/v1/me | 
[**usersUpdate**](MeApi.md#usersupdate) | **PATCH** /api/v1/me | 


# **meExtrasAddFavorite**
> meExtrasAddFavorite(favoriteDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();
final FavoriteDto favoriteDto = ; // FavoriteDto | 

try {
    api.meExtrasAddFavorite(favoriteDto);
} on DioException catch (e) {
    print('Exception when calling MeApi->meExtrasAddFavorite: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **favoriteDto** | [**FavoriteDto**](FavoriteDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meExtrasDeleteSavedOrder**
> meExtrasDeleteSavedOrder(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();
final String id = id_example; // String | 

try {
    api.meExtrasDeleteSavedOrder(id);
} on DioException catch (e) {
    print('Exception when calling MeApi->meExtrasDeleteSavedOrder: $e\n');
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

# **meExtrasFavorites**
> meExtrasFavorites()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();

try {
    api.meExtrasFavorites();
} on DioException catch (e) {
    print('Exception when calling MeApi->meExtrasFavorites: $e\n');
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

# **meExtrasPreferences**
> meExtrasPreferences()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();

try {
    api.meExtrasPreferences();
} on DioException catch (e) {
    print('Exception when calling MeApi->meExtrasPreferences: $e\n');
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

# **meExtrasRemoveFavorite**
> meExtrasRemoveFavorite(menuItemId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();
final String menuItemId = menuItemId_example; // String | 

try {
    api.meExtrasRemoveFavorite(menuItemId);
} on DioException catch (e) {
    print('Exception when calling MeApi->meExtrasRemoveFavorite: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **menuItemId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meExtrasSaveOrder**
> meExtrasSaveOrder(savedOrderDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();
final SavedOrderDto savedOrderDto = ; // SavedOrderDto | 

try {
    api.meExtrasSaveOrder(savedOrderDto);
} on DioException catch (e) {
    print('Exception when calling MeApi->meExtrasSaveOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **savedOrderDto** | [**SavedOrderDto**](SavedOrderDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meExtrasSavedOrders**
> meExtrasSavedOrders()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();

try {
    api.meExtrasSavedOrders();
} on DioException catch (e) {
    print('Exception when calling MeApi->meExtrasSavedOrders: $e\n');
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

# **meExtrasUpdatePreferences**
> meExtrasUpdatePreferences(preferencesDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();
final PreferencesDto preferencesDto = ; // PreferencesDto | 

try {
    api.meExtrasUpdatePreferences(preferencesDto);
} on DioException catch (e) {
    print('Exception when calling MeApi->meExtrasUpdatePreferences: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **preferencesDto** | [**PreferencesDto**](PreferencesDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersAddDeviceToken**
> usersAddDeviceToken(deviceTokenDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();
final DeviceTokenDto deviceTokenDto = ; // DeviceTokenDto | 

try {
    api.usersAddDeviceToken(deviceTokenDto);
} on DioException catch (e) {
    print('Exception when calling MeApi->usersAddDeviceToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deviceTokenDto** | [**DeviceTokenDto**](DeviceTokenDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersConsent**
> MeDto usersConsent(consentDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();
final ConsentDto consentDto = ; // ConsentDto | 

try {
    final response = api.usersConsent(consentDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MeApi->usersConsent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **consentDto** | [**ConsentDto**](ConsentDto.md)|  | 

### Return type

[**MeDto**](MeDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersExport**
> usersExport()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();

try {
    api.usersExport();
} on DioException catch (e) {
    print('Exception when calling MeApi->usersExport: $e\n');
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

# **usersMe**
> MeDto usersMe()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();

try {
    final response = api.usersMe();
    print(response);
} on DioException catch (e) {
    print('Exception when calling MeApi->usersMe: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MeDto**](MeDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersRemove**
> usersRemove()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();

try {
    api.usersRemove();
} on DioException catch (e) {
    print('Exception when calling MeApi->usersRemove: $e\n');
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

# **usersUpdate**
> MeDto usersUpdate(updateMeDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMeApi();
final UpdateMeDto updateMeDto = ; // UpdateMeDto | 

try {
    final response = api.usersUpdate(updateMeDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MeApi->usersUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateMeDto** | [**UpdateMeDto**](UpdateMeDto.md)|  | 

### Return type

[**MeDto**](MeDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

