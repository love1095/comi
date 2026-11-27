# comi_api.api.CustomerDiscoveryApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**discoveryDetail**](CustomerDiscoveryApi.md#discoverydetail) | **GET** /api/v1/restaurants/{slug} | 
[**discoveryHome**](CustomerDiscoveryApi.md#discoveryhome) | **GET** /api/v1/home | 
[**discoveryMap**](CustomerDiscoveryApi.md#discoverymap) | **GET** /api/v1/restaurants/map | 
[**discoveryMenu**](CustomerDiscoveryApi.md#discoverymenu) | **GET** /api/v1/restaurants/{id}/menu | 
[**discoveryNearby**](CustomerDiscoveryApi.md#discoverynearby) | **GET** /api/v1/restaurants | 
[**discoverySuggest**](CustomerDiscoveryApi.md#discoverysuggest) | **GET** /api/v1/search/suggest | 


# **discoveryDetail**
> RestaurantDetailDto discoveryDetail(slug, acceptLanguage, acceptLanguage2)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerDiscoveryApi();
final String slug = slug_example; // String | 
final String acceptLanguage = acceptLanguage_example; // String | 
final String acceptLanguage2 = acceptLanguage_example; // String | vi | en | ko | zh | ja (fallback → en → vi)

try {
    final response = api.discoveryDetail(slug, acceptLanguage, acceptLanguage2);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerDiscoveryApi->discoveryDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**|  | 
 **acceptLanguage** | **String**|  | 
 **acceptLanguage2** | **String**| vi | en | ko | zh | ja (fallback → en → vi) | [optional] 

### Return type

[**RestaurantDetailDto**](RestaurantDetailDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **discoveryHome**
> HomeDto discoveryHome(lat, lng, acceptLanguage, acceptLanguage2)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerDiscoveryApi();
final num lat = 8.14; // num | 
final num lng = 8.14; // num | 
final String acceptLanguage = acceptLanguage_example; // String | 
final String acceptLanguage2 = acceptLanguage_example; // String | vi | en | ko | zh | ja (fallback → en → vi)

try {
    final response = api.discoveryHome(lat, lng, acceptLanguage, acceptLanguage2);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerDiscoveryApi->discoveryHome: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **lat** | **num**|  | 
 **lng** | **num**|  | 
 **acceptLanguage** | **String**|  | 
 **acceptLanguage2** | **String**| vi | en | ko | zh | ja (fallback → en → vi) | [optional] 

### Return type

[**HomeDto**](HomeDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **discoveryMap**
> List<MapPinDto> discoveryMap(bbox)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerDiscoveryApi();
final String bbox = 106.68,10.76,106.71,10.79; // String | minLng,minLat,maxLng,maxLat

try {
    final response = api.discoveryMap(bbox);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerDiscoveryApi->discoveryMap: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bbox** | **String**| minLng,minLat,maxLng,maxLat | 

### Return type

[**List&lt;MapPinDto&gt;**](MapPinDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **discoveryMenu**
> List<PublicMenuCategoryDto> discoveryMenu(id, acceptLanguage, acceptLanguage2)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerDiscoveryApi();
final String id = id_example; // String | 
final String acceptLanguage = acceptLanguage_example; // String | 
final String acceptLanguage2 = acceptLanguage_example; // String | vi | en | ko | zh | ja (fallback → en → vi)

try {
    final response = api.discoveryMenu(id, acceptLanguage, acceptLanguage2);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerDiscoveryApi->discoveryMenu: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **acceptLanguage** | **String**|  | 
 **acceptLanguage2** | **String**| vi | en | ko | zh | ja (fallback → en → vi) | [optional] 

### Return type

[**List&lt;PublicMenuCategoryDto&gt;**](PublicMenuCategoryDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **discoveryNearby**
> RestaurantPageDto discoveryNearby(lat, lng, acceptLanguage, radius, q, cuisine, priceMax, minRating, openNow, maxMainPrice, groupSize, openLate, privateRoom, mode, sort, cursor, limit, acceptLanguage2)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerDiscoveryApi();
final num lat = 8.14; // num | 
final num lng = 8.14; // num | 
final String acceptLanguage = acceptLanguage_example; // String | 
final num radius = 8.14; // num | meters
final String q = q_example; // String | name, accent-insensitive
final String cuisine = cuisine_example; // String | comma separated, e.g. com,nhau
final num priceMax = 8.14; // num | 
final num minRating = 8.14; // num | 
final bool openNow = true; // bool | 
final num maxMainPrice = 8.14; // num | \"Under 60k\": has a main dish at or below this price
final num groupSize = 8.14; // num | \"Groups 10+\"
final bool openLate = true; // bool | Open until 23:00 or later today
final bool privateRoom = true; // bool | 
final String mode = mode_example; // String | 
final String sort = sort_example; // String | 
final num cursor = 8.14; // num | Offset from the previous page
final num limit = 8.14; // num | 
final String acceptLanguage2 = acceptLanguage_example; // String | vi | en | ko | zh | ja (fallback → en → vi)

try {
    final response = api.discoveryNearby(lat, lng, acceptLanguage, radius, q, cuisine, priceMax, minRating, openNow, maxMainPrice, groupSize, openLate, privateRoom, mode, sort, cursor, limit, acceptLanguage2);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerDiscoveryApi->discoveryNearby: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **lat** | **num**|  | 
 **lng** | **num**|  | 
 **acceptLanguage** | **String**|  | 
 **radius** | **num**| meters | [optional] [default to 3000]
 **q** | **String**| name, accent-insensitive | [optional] 
 **cuisine** | **String**| comma separated, e.g. com,nhau | [optional] 
 **priceMax** | **num**|  | [optional] 
 **minRating** | **num**|  | [optional] 
 **openNow** | **bool**|  | [optional] 
 **maxMainPrice** | **num**| \"Under 60k\": has a main dish at or below this price | [optional] 
 **groupSize** | **num**| \"Groups 10+\" | [optional] 
 **openLate** | **bool**| Open until 23:00 or later today | [optional] 
 **privateRoom** | **bool**|  | [optional] 
 **mode** | **String**|  | [optional] 
 **sort** | **String**|  | [optional] 
 **cursor** | **num**| Offset from the previous page | [optional] 
 **limit** | **num**|  | [optional] [default to 20]
 **acceptLanguage2** | **String**| vi | en | ko | zh | ja (fallback → en → vi) | [optional] 

### Return type

[**RestaurantPageDto**](RestaurantPageDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **discoverySuggest**
> SuggestDto discoverySuggest(q, lat, lng)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerDiscoveryApi();
final String q = q_example; // String | 
final num lat = 8.14; // num | 
final num lng = 8.14; // num | 

try {
    final response = api.discoverySuggest(q, lat, lng);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerDiscoveryApi->discoverySuggest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**|  | 
 **lat** | **num**|  | [optional] 
 **lng** | **num**|  | [optional] 

### Return type

[**SuggestDto**](SuggestDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

