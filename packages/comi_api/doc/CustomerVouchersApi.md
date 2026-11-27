# comi_api.api.CustomerVouchersApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**customerVouchersCheck**](CustomerVouchersApi.md#customervoucherscheck) | **POST** /api/v1/vouchers/check | 


# **customerVouchersCheck**
> VoucherCheckResultDto customerVouchersCheck(voucherCheckDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerVouchersApi();
final VoucherCheckDto voucherCheckDto = ; // VoucherCheckDto | 

try {
    final response = api.customerVouchersCheck(voucherCheckDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerVouchersApi->customerVouchersCheck: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **voucherCheckDto** | [**VoucherCheckDto**](VoucherCheckDto.md)|  | 

### Return type

[**VoucherCheckResultDto**](VoucherCheckResultDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

