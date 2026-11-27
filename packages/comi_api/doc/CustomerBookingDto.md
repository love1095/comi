# comi_api.model.CustomerBookingDto

## Load the model package
```dart
import 'package:comi_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**code** | **String** |  | 
**restaurantId** | **String** |  | 
**partySize** | **num** |  | 
**arrivalAt** | **String** |  | 
**endsAt** | **String** |  | 
**paymentMode** | [**PaymentMode**](PaymentMode.md) |  | 
**serveStyle** | [**ServeStyle**](ServeStyle.md) |  | 
**status** | [**BookingStatus**](BookingStatus.md) |  | 
**note** | **String** |  | [optional] 
**needsApproval** | **bool** |  | 
**extraTableIds** | **List&lt;String&gt;** |  | 
**cancelledAt** | **String** |  | [optional] 
**cancelReason** | **String** |  | [optional] 
**cancelledBy** | **String** | USER | RESTAURANT | SYSTEM | [optional] 
**checkedInAt** | **String** |  | [optional] 
**createdAt** | **String** |  | 
**restaurant** | [**BookingRestaurantDto**](BookingRestaurantDto.md) |  | 
**table** | [**BookingTableDto**](BookingTableDto.md) |  | [optional] 
**order** | [**CustomerOrderDto**](CustomerOrderDto.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


