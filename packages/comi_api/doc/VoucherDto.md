# comi_api.model.VoucherDto

## Load the model package
```dart
import 'package:comi_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**code** | **String** |  | 
**restaurantId** | **String** |  | [optional] 
**fundedBy** | [**VoucherFunder**](VoucherFunder.md) |  | 
**type** | [**VoucherType**](VoucherType.md) |  | 
**value** | **num** |  | 
**maxDiscount** | **num** |  | [optional] 
**minOrder** | **num** |  | 
**startsAt** | **String** |  | 
**endsAt** | **String** |  | 
**totalLimit** | **num** |  | [optional] 
**perUserLimit** | **num** |  | 
**firstOrderOnly** | **bool** |  | 
**usedCount** | **num** |  | 
**isActive** | **bool** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


