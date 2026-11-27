# comi_api.api.AdminReviewsApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminReviewsDecide**](AdminReviewsApi.md#adminreviewsdecide) | **POST** /api/v1/admin/reviews/{id}/decision | 
[**adminReviewsReported**](AdminReviewsApi.md#adminreviewsreported) | **GET** /api/v1/admin/reviews/reported | 


# **adminReviewsDecide**
> ReviewDto adminReviewsDecide(id, decisionDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminReviewsApi();
final String id = id_example; // String | 
final DecisionDto decisionDto = ; // DecisionDto | 

try {
    final response = api.adminReviewsDecide(id, decisionDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminReviewsApi->adminReviewsDecide: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **decisionDto** | [**DecisionDto**](DecisionDto.md)|  | 

### Return type

[**ReviewDto**](ReviewDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminReviewsReported**
> List<ReviewDto> adminReviewsReported()



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getAdminReviewsApi();

try {
    final response = api.adminReviewsReported();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdminReviewsApi->adminReviewsReported: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List&lt;ReviewDto&gt;**](ReviewDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

