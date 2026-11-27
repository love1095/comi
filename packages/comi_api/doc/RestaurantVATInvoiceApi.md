# comi_api.api.RestaurantVATInvoiceApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**restaurantInvoiceIssued**](RestaurantVATInvoiceApi.md#restaurantinvoiceissued) | **POST** /api/v1/restaurant/invoice-requests/{id}/issued | 
[**restaurantInvoiceList**](RestaurantVATInvoiceApi.md#restaurantinvoicelist) | **GET** /api/v1/restaurant/invoice-requests | 
[**restaurantInvoiceReject**](RestaurantVATInvoiceApi.md#restaurantinvoicereject) | **POST** /api/v1/restaurant/invoice-requests/{id}/reject | 


# **restaurantInvoiceIssued**
> InvoiceRequestDto restaurantInvoiceIssued(id, xRestaurantId, markIssuedDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantVATInvoiceApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final MarkIssuedDto markIssuedDto = ; // MarkIssuedDto | 

try {
    final response = api.restaurantInvoiceIssued(id, xRestaurantId, markIssuedDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantVATInvoiceApi->restaurantInvoiceIssued: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **markIssuedDto** | [**MarkIssuedDto**](MarkIssuedDto.md)|  | 

### Return type

[**InvoiceRequestDto**](InvoiceRequestDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantInvoiceList**
> List<InvoiceRequestDto> restaurantInvoiceList(xRestaurantId, all)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantVATInvoiceApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final String all = all_example; // String | true = include issued and rejected

try {
    final response = api.restaurantInvoiceList(xRestaurantId, all);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantVATInvoiceApi->restaurantInvoiceList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **all** | **String**| true = include issued and rejected | [optional] 

### Return type

[**List&lt;InvoiceRequestDto&gt;**](InvoiceRequestDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantInvoiceReject**
> InvoiceRequestDto restaurantInvoiceReject(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantVATInvoiceApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.restaurantInvoiceReject(id, xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantVATInvoiceApi->restaurantInvoiceReject: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

[**InvoiceRequestDto**](InvoiceRequestDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

