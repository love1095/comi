# comi_api.api.WebhooksApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**webhooksPayos**](WebhooksApi.md#webhookspayos) | **POST** /api/v1/webhooks/payos | 


# **webhooksPayos**
> webhooksPayos()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getWebhooksApi();

try {
    api.webhooksPayos();
} on DioException catch (e) {
    print('Exception when calling WebhooksApi->webhooksPayos: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

