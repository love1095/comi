# comi_api.api.CustomerPaymentsApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**customerPaymentsPay**](CustomerPaymentsApi.md#customerpaymentspay) | **POST** /api/v1/bookings/{id}/pay | 
[**customerPaymentsRefundAccount**](CustomerPaymentsApi.md#customerpaymentsrefundaccount) | **PUT** /api/v1/bookings/{id}/refund-account | 


# **customerPaymentsPay**
> PaymentDto customerPaymentsPay(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerPaymentsApi();
final String id = id_example; // String | 

try {
    final response = api.customerPaymentsPay(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerPaymentsApi->customerPaymentsPay: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**PaymentDto**](PaymentDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **customerPaymentsRefundAccount**
> UpdatedDto customerPaymentsRefundAccount(id, refundAccountDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerPaymentsApi();
final String id = id_example; // String | 
final RefundAccountDto refundAccountDto = ; // RefundAccountDto | 

try {
    final response = api.customerPaymentsRefundAccount(id, refundAccountDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerPaymentsApi->customerPaymentsRefundAccount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **refundAccountDto** | [**RefundAccountDto**](RefundAccountDto.md)|  | 

### Return type

[**UpdatedDto**](UpdatedDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

