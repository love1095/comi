# comi_api.api.RestaurantTablesApi

## Load the API package
```dart
import 'package:comi_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**tablesCreateArea**](RestaurantTablesApi.md#tablescreatearea) | **POST** /api/v1/restaurant/areas | 
[**tablesCreateTable**](RestaurantTablesApi.md#tablescreatetable) | **POST** /api/v1/restaurant/tables | 
[**tablesDeleteArea**](RestaurantTablesApi.md#tablesdeletearea) | **DELETE** /api/v1/restaurant/areas/{id} | 
[**tablesDeleteTable**](RestaurantTablesApi.md#tablesdeletetable) | **DELETE** /api/v1/restaurant/tables/{id} | 
[**tablesEntranceQr**](RestaurantTablesApi.md#tablesentranceqr) | **GET** /api/v1/restaurant/qr/entrance | 
[**tablesGetLayout**](RestaurantTablesApi.md#tablesgetlayout) | **GET** /api/v1/restaurant/areas/{id}/layout | 
[**tablesListAreas**](RestaurantTablesApi.md#tableslistareas) | **GET** /api/v1/restaurant/areas | 
[**tablesListTables**](RestaurantTablesApi.md#tableslisttables) | **GET** /api/v1/restaurant/tables | 
[**tablesPrintQr**](RestaurantTablesApi.md#tablesprintqr) | **GET** /api/v1/restaurant/qr/print | 
[**tablesRotateQr**](RestaurantTablesApi.md#tablesrotateqr) | **POST** /api/v1/restaurant/tables/{id}/rotate-qr | 
[**tablesSaveLayout**](RestaurantTablesApi.md#tablessavelayout) | **PUT** /api/v1/restaurant/areas/{id}/layout | 
[**tablesTableQr**](RestaurantTablesApi.md#tablestableqr) | **GET** /api/v1/restaurant/tables/{id}/qr | 
[**tablesUpdateArea**](RestaurantTablesApi.md#tablesupdatearea) | **PATCH** /api/v1/restaurant/areas/{id} | 
[**tablesUpdateTable**](RestaurantTablesApi.md#tablesupdatetable) | **PATCH** /api/v1/restaurant/tables/{id} | 


# **tablesCreateArea**
> AreaSummaryDto tablesCreateArea(xRestaurantId, areaDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final AreaDto areaDto = ; // AreaDto | 

try {
    final response = api.tablesCreateArea(xRestaurantId, areaDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesCreateArea: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **areaDto** | [**AreaDto**](AreaDto.md)|  | 

### Return type

[**AreaSummaryDto**](AreaSummaryDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tablesCreateTable**
> tablesCreateTable(xRestaurantId, createTableDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final CreateTableDto createTableDto = ; // CreateTableDto | 

try {
    api.tablesCreateTable(xRestaurantId, createTableDto);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesCreateTable: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **createTableDto** | [**CreateTableDto**](CreateTableDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tablesDeleteArea**
> tablesDeleteArea(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.tablesDeleteArea(id, xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesDeleteArea: $e\n');
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

# **tablesDeleteTable**
> tablesDeleteTable(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.tablesDeleteTable(id, xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesDeleteTable: $e\n');
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

# **tablesEntranceQr**
> tablesEntranceQr(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.tablesEntranceQr(xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesEntranceQr: $e\n');
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

# **tablesGetLayout**
> AreaLayoutDto tablesGetLayout(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.tablesGetLayout(id, xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesGetLayout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 

### Return type

[**AreaLayoutDto**](AreaLayoutDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tablesListAreas**
> List<AreaSummaryDto> tablesListAreas(xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    final response = api.tablesListAreas(xRestaurantId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesListAreas: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 

### Return type

[**List&lt;AreaSummaryDto&gt;**](AreaSummaryDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tablesListTables**
> List<TableDto> tablesListTables(xRestaurantId, areaId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final String areaId = areaId_example; // String | 

try {
    final response = api.tablesListTables(xRestaurantId, areaId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesListTables: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **areaId** | **String**|  | [optional] 

### Return type

[**List&lt;TableDto&gt;**](TableDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tablesPrintQr**
> tablesPrintQr(xRestaurantId, areaId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String xRestaurantId = xRestaurantId_example; // String | 
final String areaId = areaId_example; // String | 

try {
    api.tablesPrintQr(xRestaurantId, areaId);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesPrintQr: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xRestaurantId** | **String**|  | 
 **areaId** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tablesRotateQr**
> tablesRotateQr(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.tablesRotateQr(id, xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesRotateQr: $e\n');
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

# **tablesSaveLayout**
> AreaLayoutDto tablesSaveLayout(id, xRestaurantId, saveLayoutDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final SaveLayoutDto saveLayoutDto = ; // SaveLayoutDto | 

try {
    final response = api.tablesSaveLayout(id, xRestaurantId, saveLayoutDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesSaveLayout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **saveLayoutDto** | [**SaveLayoutDto**](SaveLayoutDto.md)|  | 

### Return type

[**AreaLayoutDto**](AreaLayoutDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tablesTableQr**
> tablesTableQr(id, xRestaurantId)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 

try {
    api.tablesTableQr(id, xRestaurantId);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesTableQr: $e\n');
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

# **tablesUpdateArea**
> tablesUpdateArea(id, xRestaurantId, updateAreaDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final UpdateAreaDto updateAreaDto = ; // UpdateAreaDto | 

try {
    api.tablesUpdateArea(id, xRestaurantId, updateAreaDto);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesUpdateArea: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **updateAreaDto** | [**UpdateAreaDto**](UpdateAreaDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tablesUpdateTable**
> tablesUpdateTable(id, xRestaurantId, updateTableDto)



### Example
```dart
import 'package:comi_api/api.dart';

final api = ComiApi().getRestaurantTablesApi();
final String id = id_example; // String | 
final String xRestaurantId = xRestaurantId_example; // String | 
final UpdateTableDto updateTableDto = ; // UpdateTableDto | 

try {
    api.tablesUpdateTable(id, xRestaurantId, updateTableDto);
} on DioException catch (e) {
    print('Exception when calling RestaurantTablesApi->tablesUpdateTable: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **xRestaurantId** | **String**|  | 
 **updateTableDto** | [**UpdateTableDto**](UpdateTableDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

