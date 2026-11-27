# comi_api.model.AdminVoucherInputDto

## Load the model package
```dart
import 'package:comi_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**code** | **String** |  | 
**type** | [**VoucherType**](VoucherType.md) |  | 
**value** | **num** | VND for FIXED, basis points for PERCENT (2000 = 20%) | 
**maxDiscount** | **num** |  | [optional] 
**minOrder** | **num** |  | [optional] 
**startsAt** | **String** |  | 
**endsAt** | **String** |  | 
**totalLimit** | **num** |  | [optional] 
**perUserLimit** | **num** |  | [optional] 
**firstOrderOnly** | **bool** |  | [optional] 
**restaurantId** | **String** | Limit to one restaurant (platform still pays) | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


