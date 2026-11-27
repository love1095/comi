# comi_api.api.AdminVouchersApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminVouchersActive**](AdminVouchersApi.md#adminvouchersactive) | **PATCH** /api/v1/admin/vouchers/{id} | 
[**adminVouchersCreate**](AdminVouchersApi.md#adminvoucherscreate) | **POST** /api/v1/admin/vouchers | 
[**adminVouchersList**](AdminVouchersApi.md#adminvoucherslist) | **GET** /api/v1/admin/vouchers | 


# **adminVouchersActive**
> VoucherDto adminVouchersActive(id, voucherActiveDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminVouchersApi();
final String id = id_example; // String | 
final VoucherActiveDto voucherActiveDto = ; // VoucherActiveDto | 

try {
    final response = api.adminVouchersActive(id, voucherActiveDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminVouchersApi->adminVouchersActive: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **voucherActiveDto** | [**VoucherActiveDto**](VoucherActiveDto.md)|  | 

### Return type

[**VoucherDto**](VoucherDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminVouchersCreate**
> VoucherDto adminVouchersCreate(adminVoucherInputDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminVouchersApi();
final AdminVoucherInputDto adminVoucherInputDto = ; // AdminVoucherInputDto | 

try {
    final response = api.adminVouchersCreate(adminVoucherInputDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminVouchersApi->adminVouchersCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **adminVoucherInputDto** | [**AdminVoucherInputDto**](AdminVoucherInputDto.md)|  | 

### Return type

[**VoucherDto**](VoucherDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminVouchersList**
> List<VoucherDto> adminVouchersList()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminVouchersApi();

try {
    final response = api.adminVouchersList();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminVouchersApi->adminVouchersList: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List&lt;VoucherDto&gt;**](VoucherDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

