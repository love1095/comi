# comi_api.model.KitchenItemDto

## Load the model package
```dart
import 'package:comi_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**bookingId** | **String** |  | 
**bookingCode** | **String** |  | 
**tableCode** | **String** |  | [optional] 
**partySize** | **num** |  | 
**arrivalAt** | **String** |  | 
**guestArrived** | **bool** | Booking is CHECKED_IN | 
**nameSnapshot** | **String** |  | 
**quantity** | **num** |  | 
**optionsSnapshot** | [**List&lt;OptionSnapshotDto&gt;**](OptionSnapshotDto.md) |  | 
**note** | **String** |  | [optional] 
**course** | [**Course**](Course.md) |  | 
**prepMinutes** | **num** |  | 
**kitchenStatus** | [**KitchenStatus**](KitchenStatus.md) |  | 
**round** | **num** | 0 = pre-order, 1..n = ordered at the table | 
**scheduledStartAt** | **String** |  | [optional] 
**releasedAt** | **String** |  | [optional] 
**startedAt** | **String** |  | [optional] 
**readyAt** | **String** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


