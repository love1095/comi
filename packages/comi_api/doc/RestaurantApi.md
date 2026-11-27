# comi_api.api.RestaurantApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**restaurantChecklist**](RestaurantApi.md#restaurantchecklist) | **GET** /api/v1/restaurant/checklist | 
[**restaurantClosures**](RestaurantApi.md#restaurantclosures) | **GET** /api/v1/restaurant/closures | 
[**restaurantCreateClosure**](RestaurantApi.md#restaurantcreateclosure) | **POST** /api/v1/restaurant/closures | 
[**restaurantDeleteClosure**](RestaurantApi.md#restaurantdeleteclosure) | **DELETE** /api/v1/restaurant/closures/{closureId} | 
[**restaurantGeocode**](RestaurantApi.md#restaurantgeocode) | **GET** /api/v1/restaurant/geocode | 
[**restaurantMine**](RestaurantApi.md#restaurantmine) | **GET** /api/v1/restaurant/me | 
[**restaurantOpeningHours**](RestaurantApi.md#restaurantopeninghours) | **PUT** /api/v1/restaurant/opening-hours | 
[**restaurantProfile**](RestaurantApi.md#restaurantprofile) | **GET** /api/v1/restaurant/profile | 
[**restaurantRegister**](RestaurantApi.md#restaurantregister) | **POST** /api/v1/restaurant/register | 
[**restaurantSubmit**](RestaurantApi.md#restaurantsubmit) | **POST** /api/v1/restaurant/submit | 
[**restaurantUpdateProfile**](RestaurantApi.md#restaurantupdateprofile) | **PATCH** /api/v1/restaurant/profile | 
[**restaurantUpdateSettings**](RestaurantApi.md#restaurantupdatesettings) | **PATCH** /api/v1/restaurant/settings | 


# **restaurantChecklist**
> ChecklistDto restaurantChecklist(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantChecklist(xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantApi->restaurantChecklist: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

[**ChecklistDto**](ChecklistDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantClosures**
> restaurantClosures(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.restaurantClosures(xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantApi->restaurantClosures: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantCreateClosure**
> restaurantCreateClosure(xRestaurantId, closureDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final ClosureDto closureDto = ; // ClosureDto | 

try {
    api.restaurantCreateClosure(xRestaurantId, closureDto);
} on DioException catch (e) {
    print('Exception when calling RestaurantApi->restaurantCreateClosure: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **closureDto** | [**ClosureDto**](ClosureDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantDeleteClosure**
> restaurantDeleteClosure(closureId, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantApi();
final String closureId = closureId_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.restaurantDeleteClosure(closureId, xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantApi->restaurantDeleteClosure: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **closureId** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantGeocode**
> List<GeocodeResultDto> restaurantGeocode(q)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantApi();
final String q = q_example; // String | 

try {
    final response = api.restaurantGeocode(q);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantApi->restaurantGeocode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**|  | 

### Return type

[**List&lt;GeocodeResultDto&gt;**](GeocodeResultDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantMine**
> List<MembershipDto> restaurantMine()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantApi();

try {
    final response = api.restaurantMine();
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantApi->restaurantMine: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List&lt;MembershipDto&gt;**](MembershipDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantOpeningHours**
> List<OpeningHoursDto> restaurantOpeningHours(xRestaurantId, replaceOpeningHoursDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final ReplaceOpeningHoursDto replaceOpeningHoursDto = ; // ReplaceOpeningHoursDto | 

try {
    final response = api.restaurantOpeningHours(xRestaurantId, replaceOpeningHoursDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantApi->restaurantOpeningHours: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **replaceOpeningHoursDto** | [**ReplaceOpeningHoursDto**](ReplaceOpeningHoursDto.md)|  | 

### Return type

[**List&lt;OpeningHoursDto&gt;**](OpeningHoursDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantProfile**
> RestaurantProfileDto restaurantProfile(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantProfile(xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantApi->restaurantProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

[**RestaurantProfileDto**](RestaurantProfileDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantRegister**
> RestaurantProfileDto restaurantRegister(registerRestaurantDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantApi();
final RegisterRestaurantDto registerRestaurantDto = ; // RegisterRestaurantDto | 

try {
    final response = api.restaurantRegister(registerRestaurantDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantApi->restaurantRegister: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerRestaurantDto** | [**RegisterRestaurantDto**](RegisterRestaurantDto.md)|  | 

### Return type

[**RestaurantProfileDto**](RestaurantProfileDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantSubmit**
> RestaurantProfileDto restaurantSubmit(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantSubmit(xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantApi->restaurantSubmit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

[**RestaurantProfileDto**](RestaurantProfileDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantUpdateProfile**
> RestaurantProfileDto restaurantUpdateProfile(xRestaurantId, updateProfileDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final UpdateProfileDto updateProfileDto = ; // UpdateProfileDto | 

try {
    final response = api.restaurantUpdateProfile(xRestaurantId, updateProfileDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantApi->restaurantUpdateProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **updateProfileDto** | [**UpdateProfileDto**](UpdateProfileDto.md)|  | 

### Return type

[**RestaurantProfileDto**](RestaurantProfileDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantUpdateSettings**
> RestaurantProfileDto restaurantUpdateSettings(xRestaurantId, updateSettingsDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final UpdateSettingsDto updateSettingsDto = ; // UpdateSettingsDto | 

try {
    final response = api.restaurantUpdateSettings(xRestaurantId, updateSettingsDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantApi->restaurantUpdateSettings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **updateSettingsDto** | [**UpdateSettingsDto**](UpdateSettingsDto.md)|  | 

### Return type

[**RestaurantProfileDto**](RestaurantProfileDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

