# comi_api.model.GroupViewDto

## Load the model package
```dart
import 'package:comi_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**token** | **String** |  | 
**link** | **String** | Share this link (Zalo, Messenger) | 
**bookingId** | **String** |  | 
**status** | [**BookingStatus**](BookingStatus.md) |  | 
**restaurant** | [**GroupRestaurantDto**](GroupRestaurantDto.md) |  | 
**arrivalAt** | **String** |  | 
**partySize** | **num** |  | 
**cutoffAt** | **String** |  | 
**locked** | **bool** |  | 
**maxGuests** | **num** |  | 
**guests** | [**List&lt;GroupGuestDto&gt;**](GroupGuestDto.md) |  | 
**items** | [**List&lt;GroupItemDto&gt;**](GroupItemDto.md) |  | 
**total** | **num** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


