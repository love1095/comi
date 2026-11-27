# comi_api.api.MediaApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**mediaSignature**](MediaApi.md#mediasignature) | **GET** /api/v1/media/upload-signature | 


# **mediaSignature**
> UploadSignatureDto mediaSignature(kind, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getMediaApi();
final String kind = kind_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.mediaSignature(kind, xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MediaApi->mediaSignature: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **kind** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

[**UploadSignatureDto**](UploadSignatureDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

