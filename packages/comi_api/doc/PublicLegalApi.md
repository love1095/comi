# comi_api.api.PublicLegalApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**legalInfo**](PublicLegalApi.md#legalinfo) | **GET** /api/v1/legal | 
[**legalPage**](PublicLegalApi.md#legalpage) | **GET** /api/v1/legal/{doc} | 


# **legalInfo**
> LegalInfoDto legalInfo()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getPublicLegalApi();

try {
    final response = api.legalInfo();
    print(response);
} on DioException catch (e) {
    print('Exception when calling PublicLegalApi->legalInfo: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**LegalInfoDto**](LegalInfoDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legalPage**
> legalPage(doc, lang)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getPublicLegalApi();
final String doc = doc_example; // String | 
final String lang = lang_example; // String | 

try {
    api.legalPage(doc, lang);
} on DioException catch (e) {
    print('Exception when calling PublicLegalApi->legalPage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **doc** | **String**|  | 
 **lang** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

