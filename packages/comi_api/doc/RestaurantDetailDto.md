# comi_api.model.RestaurantDetailDto

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
**originalName** | **String** | Vietnamese name (for the taxi card) | 
**description** | **String** |  | [optional] 
**translated** | **String** | none = Vietnamese original shown | 
**phone** | **String** |  | 
**address** | **String** |  | 
**lat** | **num** |  | [optional] 
**lng** | **num** |  | [optional] 
**timezone** | **String** |  | 
**cuisineTags** | **List&lt;String&gt;** |  | 
**ambienceTags** | **List&lt;String&gt;** |  | 
**priceLevel** | **num** |  | 
**coverPhotoUrl** | **String** |  | [optional] 
**ratingAvg** | **num** |  | 
**ratingCount** | **num** |  | 
**servesLunch** | **bool** |  | 
**servesNhau** | **bool** |  | 
**allowTableChoice** | **bool** |  | 
**allowCod** | **bool** |  | 
**prepaidAvailable** | **bool** | Guests can prepay online (the restaurant connected PayOS) | 
**googleRating** | **num** | Rating on Google Maps (refreshed weekly) | [optional] 
**googleRatingCount** | **num** |  | [optional] 
**maxGroupSize** | **num** |  | 
**confirmGroupsOver** | **num** |  | 
**cancelCutoffMinutes** | **num** |  | 
**isOpenNow** | **bool** |  | 
**openingHours** | [**List&lt;OpeningHoursDto&gt;**](OpeningHoursDto.md) |  | 
**closures** | [**List&lt;ClosureInfoDto&gt;**](ClosureInfoDto.md) |  | 
**areas** | [**List&lt;AreaBriefDto&gt;**](AreaBriefDto.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


