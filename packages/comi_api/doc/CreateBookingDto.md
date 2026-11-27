# comi_api.model.CreateBookingDto

## Load the model package
```dart
import 'package:comi_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**restaurantId** | **String** |  | 
**arrivalAt** | **String** | Exact slot start from /availability (ISO) | 
**partySize** | **num** |  | 
**areaId** | **String** |  | [optional] 
**holdId** | **String** | From POST /restaurants/:id/table-holds | [optional] 
**paymentMode** | **String** |  | 
**serveStyle** | **String** |  | [optional] 
**note** | **String** |  | [optional] 
**occasion** | **String** |  | [optional] 
**ageConfirmed** | **bool** | Required when the order contains alcohol | [optional] 
**voucherCode** | **String** | One voucher per booking (§12); never discounts alcohol | [optional] 
**items** | [**List&lt;CartLineDto&gt;**](CartLineDto.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


