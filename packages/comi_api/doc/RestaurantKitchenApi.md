# comi_api.api.RestaurantKitchenApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**kitchenFire**](RestaurantKitchenApi.md#kitchenfire) | **POST** /api/v1/restaurant/kitchen/bookings/{id}/fire | 
[**kitchenQueue**](RestaurantKitchenApi.md#kitchenqueue) | **GET** /api/v1/restaurant/kitchen/queue | 
[**kitchenReplaceRules**](RestaurantKitchenApi.md#kitchenreplacerules) | **PUT** /api/v1/restaurant/kitchen/capacity-rules | 
[**kitchenRules**](RestaurantKitchenApi.md#kitchenrules) | **GET** /api/v1/restaurant/kitchen/capacity-rules | 
[**kitchenSetStatus**](RestaurantKitchenApi.md#kitchensetstatus) | **POST** /api/v1/restaurant/kitchen/items/{id}/status | 


# **kitchenFire**
> FireResultDto kitchenFire(id, xRestaurantId, fireDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantKitchenApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final FireDto fireDto = ; // FireDto | 

try {
    final response = api.kitchenFire(id, xRestaurantId, fireDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantKitchenApi->kitchenFire: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **fireDto** | [**FireDto**](FireDto.md)|  | 

### Return type

[**FireResultDto**](FireResultDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kitchenQueue**
> KitchenQueueDto kitchenQueue(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantKitchenApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.kitchenQueue(xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantKitchenApi->kitchenQueue: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

[**KitchenQueueDto**](KitchenQueueDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kitchenReplaceRules**
> List<CapacityRuleDto> kitchenReplaceRules(xRestaurantId, capacityRulesDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantKitchenApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final CapacityRulesDto capacityRulesDto = ; // CapacityRulesDto | 

try {
    final response = api.kitchenReplaceRules(xRestaurantId, capacityRulesDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantKitchenApi->kitchenReplaceRules: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **capacityRulesDto** | [**CapacityRulesDto**](CapacityRulesDto.md)|  | 

### Return type

[**List&lt;CapacityRuleDto&gt;**](CapacityRuleDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kitchenRules**
> List<CapacityRuleDto> kitchenRules(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantKitchenApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.kitchenRules(xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantKitchenApi->kitchenRules: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

[**List&lt;CapacityRuleDto&gt;**](CapacityRuleDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **kitchenSetStatus**
> KitchenItemDto kitchenSetStatus(id, xRestaurantId, kitchenStatusDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantKitchenApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final KitchenStatusDto kitchenStatusDto = ; // KitchenStatusDto | 

try {
    final response = api.kitchenSetStatus(id, xRestaurantId, kitchenStatusDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantKitchenApi->kitchenSetStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **kitchenStatusDto** | [**KitchenStatusDto**](KitchenStatusDto.md)|  | 

### Return type

[**KitchenItemDto**](KitchenItemDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

