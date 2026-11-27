# comi_api.api.RestaurantMenuApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**menuAddPhoto**](RestaurantMenuApi.md#menuaddphoto) | **POST** /api/v1/restaurant/menu/items/{id}/photos | 
[**menuAvailability**](RestaurantMenuApi.md#menuavailability) | **PATCH** /api/v1/restaurant/menu/items/{id}/availability | 
[**menuCreateCategory**](RestaurantMenuApi.md#menucreatecategory) | **POST** /api/v1/restaurant/menu/categories | 
[**menuCreateItem**](RestaurantMenuApi.md#menucreateitem) | **POST** /api/v1/restaurant/menu/items | 
[**menuDeleteCategory**](RestaurantMenuApi.md#menudeletecategory) | **DELETE** /api/v1/restaurant/menu/categories/{id} | 
[**menuDeleteItem**](RestaurantMenuApi.md#menudeleteitem) | **DELETE** /api/v1/restaurant/menu/items/{id} | 
[**menuDeletePhoto**](RestaurantMenuApi.md#menudeletephoto) | **DELETE** /api/v1/restaurant/menu/photos/{photoId} | 
[**menuGet**](RestaurantMenuApi.md#menuget) | **GET** /api/v1/restaurant/menu | 
[**menuImportConfirm**](RestaurantMenuApi.md#menuimportconfirm) | **POST** /api/v1/restaurant/menu/import/confirm | 
[**menuImportPreview**](RestaurantMenuApi.md#menuimportpreview) | **POST** /api/v1/restaurant/menu/import/preview | 
[**menuReorderCategories**](RestaurantMenuApi.md#menureordercategories) | **PUT** /api/v1/restaurant/menu/categories/order | 
[**menuReorderItems**](RestaurantMenuApi.md#menureorderitems) | **PUT** /api/v1/restaurant/menu/items/order | 
[**menuReorderPhotos**](RestaurantMenuApi.md#menureorderphotos) | **PUT** /api/v1/restaurant/menu/items/{id}/photos/order | 
[**menuTemplate**](RestaurantMenuApi.md#menutemplate) | **GET** /api/v1/restaurant/menu/import/template | 
[**menuTranslation**](RestaurantMenuApi.md#menutranslation) | **PUT** /api/v1/restaurant/menu/items/{id}/translations/{locale} | 
[**menuUpdateCategory**](RestaurantMenuApi.md#menuupdatecategory) | **PATCH** /api/v1/restaurant/menu/categories/{id} | 
[**menuUpdateItem**](RestaurantMenuApi.md#menuupdateitem) | **PATCH** /api/v1/restaurant/menu/items/{id} | 


# **menuAddPhoto**
> MenuPhotoDto menuAddPhoto(id, xRestaurantId, addPhotoDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final AddPhotoDto addPhotoDto = ; // AddPhotoDto | 

try {
    final response = api.menuAddPhoto(id, xRestaurantId, addPhotoDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuAddPhoto: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **addPhotoDto** | [**AddPhotoDto**](AddPhotoDto.md)|  | 

### Return type

[**MenuPhotoDto**](MenuPhotoDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuAvailability**
> AvailabilityResultDto menuAvailability(id, xRestaurantId, availabilityDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final AvailabilityDto availabilityDto = ; // AvailabilityDto | 

try {
    final response = api.menuAvailability(id, xRestaurantId, availabilityDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuAvailability: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **availabilityDto** | [**AvailabilityDto**](AvailabilityDto.md)|  | 

### Return type

[**AvailabilityResultDto**](AvailabilityResultDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuCreateCategory**
> MenuCategoryResponseDto menuCreateCategory(xRestaurantId, categoryDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final CategoryDto categoryDto = ; // CategoryDto | 

try {
    final response = api.menuCreateCategory(xRestaurantId, categoryDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuCreateCategory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **categoryDto** | [**CategoryDto**](CategoryDto.md)|  | 

### Return type

[**MenuCategoryResponseDto**](MenuCategoryResponseDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuCreateItem**
> StaffMenuItemDto menuCreateItem(xRestaurantId, menuItemDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final MenuItemDto menuItemDto = ; // MenuItemDto | 

try {
    final response = api.menuCreateItem(xRestaurantId, menuItemDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuCreateItem: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **menuItemDto** | [**MenuItemDto**](MenuItemDto.md)|  | 

### Return type

[**StaffMenuItemDto**](StaffMenuItemDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuDeleteCategory**
> menuDeleteCategory(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.menuDeleteCategory(id, xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuDeleteCategory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuDeleteItem**
> menuDeleteItem(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.menuDeleteItem(id, xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuDeleteItem: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuDeletePhoto**
> menuDeletePhoto(photoId, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String photoId = photoId_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.menuDeletePhoto(photoId, xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuDeletePhoto: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **photoId** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuGet**
> List<StaffMenuCategoryDto> menuGet(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.menuGet(xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

[**List&lt;StaffMenuCategoryDto&gt;**](StaffMenuCategoryDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuImportConfirm**
> ImportResultDto menuImportConfirm(xRestaurantId, file)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.menuImportConfirm(xRestaurantId, file);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuImportConfirm: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **file** | **MultipartFile**|  | [optional] 

### Return type

[**ImportResultDto**](ImportResultDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuImportPreview**
> ImportPreviewDto menuImportPreview(xRestaurantId, file)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.menuImportPreview(xRestaurantId, file);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuImportPreview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **file** | **MultipartFile**|  | [optional] 

### Return type

[**ImportPreviewDto**](ImportPreviewDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuReorderCategories**
> menuReorderCategories(xRestaurantId, reorderDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final ReorderDto reorderDto = ; // ReorderDto | 

try {
    api.menuReorderCategories(xRestaurantId, reorderDto);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuReorderCategories: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **reorderDto** | [**ReorderDto**](ReorderDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuReorderItems**
> menuReorderItems(xRestaurantId, reorderDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final ReorderDto reorderDto = ; // ReorderDto | 

try {
    api.menuReorderItems(xRestaurantId, reorderDto);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuReorderItems: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **reorderDto** | [**ReorderDto**](ReorderDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuReorderPhotos**
> menuReorderPhotos(id, xRestaurantId, reorderDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final ReorderDto reorderDto = ; // ReorderDto | 

try {
    api.menuReorderPhotos(id, xRestaurantId, reorderDto);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuReorderPhotos: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **reorderDto** | [**ReorderDto**](ReorderDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuTemplate**
> menuTemplate(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.menuTemplate(xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuTranslation**
> menuTranslation(locale, id, xRestaurantId, translationDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String locale = locale_example; // String | 
final Object id = ; // Object | 
final String xRestaurantId = xRestaurantId_example; // String | 
final TranslationDto translationDto = ; // TranslationDto | 

try {
    api.menuTranslation(locale, id, xRestaurantId, translationDto);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuTranslation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **locale** | **String**|  | 
 **id** | [**Object**](.md)|  | 
 **xRestaurantId** | **String**|  | 
 **translationDto** | [**TranslationDto**](TranslationDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuUpdateCategory**
> MenuCategoryResponseDto menuUpdateCategory(id, xRestaurantId, updateCategoryDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final UpdateCategoryDto updateCategoryDto = ; // UpdateCategoryDto | 

try {
    final response = api.menuUpdateCategory(id, xRestaurantId, updateCategoryDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuUpdateCategory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **updateCategoryDto** | [**UpdateCategoryDto**](UpdateCategoryDto.md)|  | 

### Return type

[**MenuCategoryResponseDto**](MenuCategoryResponseDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuUpdateItem**
> StaffMenuItemDto menuUpdateItem(id, xRestaurantId, updateMenuItemDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantMenuApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final UpdateMenuItemDto updateMenuItemDto = ; // UpdateMenuItemDto | 

try {
    final response = api.menuUpdateItem(id, xRestaurantId, updateMenuItemDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantMenuApi->menuUpdateItem: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **updateMenuItemDto** | [**UpdateMenuItemDto**](UpdateMenuItemDto.md)|  | 

### Return type

[**StaffMenuItemDto**](StaffMenuItemDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

