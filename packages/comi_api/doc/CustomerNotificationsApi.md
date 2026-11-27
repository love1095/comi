# comi_api.api.CustomerNotificationsApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**notificationsList**](CustomerNotificationsApi.md#notificationslist) | **GET** /api/v1/notifications | 
[**notificationsReadAll**](CustomerNotificationsApi.md#notificationsreadall) | **POST** /api/v1/notifications/read-all | 
[**notificationsReadOne**](CustomerNotificationsApi.md#notificationsreadone) | **POST** /api/v1/notifications/{id}/read | 


# **notificationsList**
> NotificationPageDto notificationsList(cursor)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerNotificationsApi();
final String cursor = cursor_example; // String | 

try {
    final response = api.notificationsList(cursor);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerNotificationsApi->notificationsList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 

### Return type

[**NotificationPageDto**](NotificationPageDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationsReadAll**
> UnreadDto notificationsReadAll()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerNotificationsApi();

try {
    final response = api.notificationsReadAll();
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerNotificationsApi->notificationsReadAll: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UnreadDto**](UnreadDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationsReadOne**
> UnreadDto notificationsReadOne(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerNotificationsApi();
final String id = id_example; // String | 

try {
    final response = api.notificationsReadOne(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerNotificationsApi->notificationsReadOne: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**UnreadDto**](UnreadDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

