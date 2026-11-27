# comi_api.model.BoardOrderItemDto

## Load the model package
```dart
import 'package:comi_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**nameSnapshot** | **String** |  | 
**unitPrice** | **num** |  | 
**quantity** | **num** |  | 
**optionsSnapshot** | [**List&lt;OptionSnapshotDto&gt;**](OptionSnapshotDto.md) |  | 
**note** | **String** |  | [optional] 
**course** | [**Course**](Course.md) |  | 
**kitchenStatus** | [**KitchenStatus**](KitchenStatus.md) |  | 
**round** | **num** | 0 = pre-order, 1..n = ordered at the table | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


