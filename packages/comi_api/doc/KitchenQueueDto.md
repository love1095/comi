# comi_api.model.KitchenQueueDto

## Load the model package
```dart
import 'package:comi_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**now** | **String** | Server time, for \"late by\" timers | 
**active** | [**List&lt;KitchenItemDto&gt;**](KitchenItemDto.md) | COOKING first, then by fire time | 
**ready** | [**List&lt;KitchenItemDto&gt;**](KitchenItemDto.md) | Done, waiting for a waiter | 
**upcoming** | [**List&lt;KitchenItemDto&gt;**](KitchenItemDto.md) | SCHEDULED (next 2 h) and HOLD (COD guest not here yet) | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


