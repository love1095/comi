# comi_api.api.RestaurantSettingsApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**diningRulesCreate**](RestaurantSettingsApi.md#diningrulescreate) | **POST** /api/v1/restaurant/dining-rules | 
[**diningRulesList**](RestaurantSettingsApi.md#diningruleslist) | **GET** /api/v1/restaurant/dining-rules | 
[**diningRulesRemove**](RestaurantSettingsApi.md#diningrulesremove) | **DELETE** /api/v1/restaurant/dining-rules/{id} | 


# **diningRulesCreate**
> diningRulesCreate(xRestaurantId, diningRuleDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantSettingsApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final DiningRuleDto diningRuleDto = ; // DiningRuleDto | 

try {
    api.diningRulesCreate(xRestaurantId, diningRuleDto);
} on DioException catch (e) {
    print('Exception when calling RestaurantSettingsApi->diningRulesCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **diningRuleDto** | [**DiningRuleDto**](DiningRuleDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **diningRulesList**
> diningRulesList(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantSettingsApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.diningRulesList(xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantSettingsApi->diningRulesList: $e\n');
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

# **diningRulesRemove**
> diningRulesRemove(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantSettingsApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.diningRulesRemove(id, xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantSettingsApi->diningRulesRemove: $e\n');
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

