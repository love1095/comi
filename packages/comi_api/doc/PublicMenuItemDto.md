# comi_api.model.PublicMenuItemDto

## Load the model package
```dart
import 'package:comi_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**name** | **String** |  | 
**description** | **String** |  | [optional] 
**translated** | **String** | machine = show \"auto-translated\" | 
**originalName** | **String** | Vietnamese name (show to staff / taxi) | 
**price** | **num** |  | 
**course** | [**Course**](Course.md) |  | 
**kind** | [**ItemKind**](ItemKind.md) |  | 
**prepMinutes** | **num** |  | 
**isAvailable** | **bool** |  | 
**isPreorderable** | **bool** |  | 
**isAlcohol** | **bool** |  | 
**leadHours** | **num** |  | 
**tags** | **List&lt;String&gt;** |  | 
**photos** | [**List&lt;PublicPhotoDto&gt;**](PublicPhotoDto.md) |  | 
**optionGroups** | [**List&lt;PublicOptionGroupDto&gt;**](PublicOptionGroupDto.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


