# comi_api.api.CustomerAvailabilityApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**availabilityGet**](CustomerAvailabilityApi.md#availabilityget) | **GET** /api/v1/restaurants/{id}/availability | 
[**availabilityHold**](CustomerAvailabilityApi.md#availabilityhold) | **POST** /api/v1/restaurants/{id}/table-holds | 
[**availabilityRelease**](CustomerAvailabilityApi.md#availabilityrelease) | **DELETE** /api/v1/table-holds/{holdId} | 
[**availabilityTableMap**](CustomerAvailabilityApi.md#availabilitytablemap) | **GET** /api/v1/restaurants/{id}/table-map | 


# **availabilityGet**
> List<SlotDto> availabilityGet(id, date, partySize, areaId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerAvailabilityApi();
final String id = id_example; // String | 
final String date = 2026-12-02; // String | 
final num partySize = 8.14; // num | 
final String areaId = areaId_example; // String | 

try {
    final response = api.availabilityGet(id, date, partySize, areaId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerAvailabilityApi->availabilityGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **date** | **String**|  | 
 **partySize** | **num**|  | 
 **areaId** | **String**|  | [optional] 

### Return type

[**List&lt;SlotDto&gt;**](SlotDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **availabilityHold**
> HoldDto availabilityHold(id, createHoldDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerAvailabilityApi();
final String id = id_example; // String | 
final CreateHoldDto createHoldDto = ; // CreateHoldDto | 

try {
    final response = api.availabilityHold(id, createHoldDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerAvailabilityApi->availabilityHold: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **createHoldDto** | [**CreateHoldDto**](CreateHoldDto.md)|  | 

### Return type

[**HoldDto**](HoldDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **availabilityRelease**
> availabilityRelease(holdId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerAvailabilityApi();
final String holdId = holdId_example; // String | 

try {
    api.availabilityRelease(holdId);
} on DioException catch (e) {
    print('Exception when calling CustomerAvailabilityApi->availabilityRelease: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **holdId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **availabilityTableMap**
> TableMapDto availabilityTableMap(id, arrivalAt, partySize, areaId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerAvailabilityApi();
final String id = id_example; // String | 
final String arrivalAt = arrivalAt_example; // String | 
final num partySize = 8.14; // num | 
final String areaId = areaId_example; // String | 

try {
    final response = api.availabilityTableMap(id, arrivalAt, partySize, areaId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerAvailabilityApi->availabilityTableMap: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **arrivalAt** | **String**|  | 
 **partySize** | **num**|  | 
 **areaId** | **String**|  | [optional] 

### Return type

[**TableMapDto**](TableMapDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

