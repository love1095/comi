# comi_api.api.RestaurantReviewsApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**restaurantReviewsList**](RestaurantReviewsApi.md#restaurantreviewslist) | **GET** /api/v1/restaurant/reviews | 
[**restaurantReviewsReply**](RestaurantReviewsApi.md#restaurantreviewsreply) | **POST** /api/v1/restaurant/reviews/{id}/reply | 
[**restaurantReviewsReport**](RestaurantReviewsApi.md#restaurantreviewsreport) | **POST** /api/v1/restaurant/reviews/{id}/report | 


# **restaurantReviewsList**
> ReviewPageDto restaurantReviewsList(xRestaurantId, cursor)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantReviewsApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final String cursor = cursor_example; // String | 

try {
    final response = api.restaurantReviewsList(xRestaurantId, cursor);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantReviewsApi->restaurantReviewsList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **cursor** | **String**|  | [optional] 

### Return type

[**ReviewPageDto**](ReviewPageDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantReviewsReply**
> ReviewDto restaurantReviewsReply(id, xRestaurantId, replyDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantReviewsApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final ReplyDto replyDto = ; // ReplyDto | 

try {
    final response = api.restaurantReviewsReply(id, xRestaurantId, replyDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantReviewsApi->restaurantReviewsReply: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **replyDto** | [**ReplyDto**](ReplyDto.md)|  | 

### Return type

[**ReviewDto**](ReviewDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantReviewsReport**
> ReviewDto restaurantReviewsReport(id, xRestaurantId, reportReviewDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantReviewsApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final ReportReviewDto reportReviewDto = ; // ReportReviewDto | 

try {
    final response = api.restaurantReviewsReport(id, xRestaurantId, reportReviewDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantReviewsApi->restaurantReviewsReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **reportReviewDto** | [**ReportReviewDto**](ReportReviewDto.md)|  | 

### Return type

[**ReviewDto**](ReviewDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

