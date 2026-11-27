# comi_api.api.CustomerReviewsApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**reviewsCreate**](CustomerReviewsApi.md#reviewscreate) | **POST** /api/v1/bookings/{id}/review | 
[**reviewsList**](CustomerReviewsApi.md#reviewslist) | **GET** /api/v1/restaurants/{id}/reviews | 
[**reviewsMine**](CustomerReviewsApi.md#reviewsmine) | **GET** /api/v1/bookings/{id}/review | 


# **reviewsCreate**
> ReviewDto reviewsCreate(id, createReviewDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerReviewsApi();
final String id = id_example; // String | 
final CreateReviewDto createReviewDto = ; // CreateReviewDto | 

try {
    final response = api.reviewsCreate(id, createReviewDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerReviewsApi->reviewsCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **createReviewDto** | [**CreateReviewDto**](CreateReviewDto.md)|  | 

### Return type

[**ReviewDto**](ReviewDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewsList**
> ReviewPageDto reviewsList(id, cursor)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerReviewsApi();
final String id = id_example; // String | 
final String cursor = cursor_example; // String | 

try {
    final response = api.reviewsList(id, cursor);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerReviewsApi->reviewsList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **cursor** | **String**|  | [optional] 

### Return type

[**ReviewPageDto**](ReviewPageDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewsMine**
> ReviewDto reviewsMine(id)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getCustomerReviewsApi();
final String id = id_example; // String | 

try {
    final response = api.reviewsMine(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomerReviewsApi->reviewsMine: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ReviewDto**](ReviewDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

