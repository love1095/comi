# comi_api.api.CustomerAtTheTableApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**customerTableBill**](CustomerAtTheTableApi.md#customertablebill) | **GET** /api/v1/bookings/{id}/bill | 
[**customerTableCheckIn**](CustomerAtTheTableApi.md#customertablecheckin) | **POST** /api/v1/bookings/{id}/check-in | 
[**customerTableDepart**](CustomerAtTheTableApi.md#customertabledepart) | **POST** /api/v1/bookings/{id}/depart | 
[**customerTableOrder**](CustomerAtTheTableApi.md#customertableorder) | **POST** /api/v1/bookings/{id}/orders | 
[**customerTableService**](CustomerAtTheTableApi.md#customertableservice) | **POST** /api/v1/bookings/{id}/service-requests | 


# **customerTableBill**
> BillDto customerTableBill(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerAtTheTableApi();
final String id = id_example; // String | 

try {
    final response = api.customerTableBill(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerAtTheTableApi->customerTableBill: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BillDto**](BillDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **customerTableCheckIn**
> CustomerBookingDto customerTableCheckIn(id, checkInDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerAtTheTableApi();
final String id = id_example; // String | 
final CheckInDto checkInDto = ; // CheckInDto | 

try {
    final response = api.customerTableCheckIn(id, checkInDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerAtTheTableApi->customerTableCheckIn: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **checkInDto** | [**CheckInDto**](CheckInDto.md)|  | 

### Return type

[**CustomerBookingDto**](CustomerBookingDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **customerTableDepart**
> DepartResultDto customerTableDepart(id, departDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerAtTheTableApi();
final String id = id_example; // String | 
final DepartDto departDto = ; // DepartDto | 

try {
    final response = api.customerTableDepart(id, departDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerAtTheTableApi->customerTableDepart: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **departDto** | [**DepartDto**](DepartDto.md)|  | 

### Return type

[**DepartResultDto**](DepartResultDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **customerTableOrder**
> RoundResultDto customerTableOrder(id, tableOrderDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerAtTheTableApi();
final String id = id_example; // String | 
final TableOrderDto tableOrderDto = ; // TableOrderDto | 

try {
    final response = api.customerTableOrder(id, tableOrderDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerAtTheTableApi->customerTableOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **tableOrderDto** | [**TableOrderDto**](TableOrderDto.md)|  | 

### Return type

[**RoundResultDto**](RoundResultDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **customerTableService**
> ServiceRequestDto customerTableService(id, serviceRequestCreateDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerAtTheTableApi();
final String id = id_example; // String | 
final ServiceRequestCreateDto serviceRequestCreateDto = ; // ServiceRequestCreateDto | 

try {
    final response = api.customerTableService(id, serviceRequestCreateDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerAtTheTableApi->customerTableService: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **serviceRequestCreateDto** | [**ServiceRequestCreateDto**](ServiceRequestCreateDto.md)|  | 

### Return type

[**ServiceRequestDto**](ServiceRequestDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

