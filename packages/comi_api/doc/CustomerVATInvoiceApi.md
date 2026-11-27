# comi_api.api.CustomerVATInvoiceApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**customerInvoiceGet**](CustomerVATInvoiceApi.md#customerinvoiceget) | **GET** /api/v1/bookings/{id}/invoice | 
[**customerInvoiceProfiles**](CustomerVATInvoiceApi.md#customerinvoiceprofiles) | **GET** /api/v1/me/invoice-profiles | 
[**customerInvoiceRequest**](CustomerVATInvoiceApi.md#customerinvoicerequest) | **POST** /api/v1/bookings/{id}/invoice | 


# **customerInvoiceGet**
> InvoiceRequestDto customerInvoiceGet(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerVATInvoiceApi();
final String id = id_example; // String | 

try {
    final response = api.customerInvoiceGet(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerVATInvoiceApi->customerInvoiceGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**InvoiceRequestDto**](InvoiceRequestDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **customerInvoiceProfiles**
> List<InvoiceProfileDto> customerInvoiceProfiles()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerVATInvoiceApi();

try {
    final response = api.customerInvoiceProfiles();
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerVATInvoiceApi->customerInvoiceProfiles: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List&lt;InvoiceProfileDto&gt;**](InvoiceProfileDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **customerInvoiceRequest**
> InvoiceRequestDto customerInvoiceRequest(id, invoiceRequestCreateDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerVATInvoiceApi();
final String id = id_example; // String | 
final InvoiceRequestCreateDto invoiceRequestCreateDto = ; // InvoiceRequestCreateDto | 

try {
    final response = api.customerInvoiceRequest(id, invoiceRequestCreateDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerVATInvoiceApi->customerInvoiceRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **invoiceRequestCreateDto** | [**InvoiceRequestCreateDto**](InvoiceRequestCreateDto.md)|  | 

### Return type

[**InvoiceRequestDto**](InvoiceRequestDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

