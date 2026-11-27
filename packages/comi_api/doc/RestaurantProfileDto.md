# comi_api.model.RestaurantProfileDto

## Load the model package
```dart
import 'package:comi_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**slug** | **String** |  | 
**name** | **String** |  | 
**description** | **String** |  | [optional] 
**phone** | **String** |  | 
**address** | **String** |  | 
**provinceCode** | **String** |  | 
**lat** | **num** |  | [optional] 
**lng** | **num** |  | [optional] 
**timezone** | **String** |  | 
**cuisineTags** | **List&lt;String&gt;** |  | 
**ambienceTags** | **List&lt;String&gt;** |  | 
**priceLevel** | **num** |  | 
**coverPhotoUrl** | **String** |  | [optional] 
**status** | [**RestaurantStatus**](RestaurantStatus.md) |  | 
**rejectReason** | **String** |  | [optional] 
**slotMinutes** | **num** |  | 
**diningMinutes** | **num** |  | 
**graceMinutes** | **num** |  | 
**minLeadMinutes** | **num** |  | 
**maxDaysAhead** | **num** |  | 
**allowCod** | **bool** |  | 
**servesLunch** | **bool** |  | 
**servesNhau** | **bool** |  | 
**maxGroupSize** | **num** |  | 
**confirmGroupsOver** | **num** |  | 
**allowTableChoice** | **bool** |  | 
**cancelCutoffMinutes** | **num** |  | 
**ratingAvg** | **num** |  | 
**ratingCount** | **num** |  | 
**openingHours** | [**List&lt;OpeningHoursDto&gt;**](OpeningHoursDto.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


