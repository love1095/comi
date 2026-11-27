# comi_api.model.ReportDto

## Load the model package
```dart
import 'package:comi_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**from** | **String** |  | 
**to** | **String** |  | 
**bookings** | **num** |  | 
**completed** | **num** |  | 
**cancelled** | **num** |  | 
**noShows** | **num** |  | 
**noShowRate** | **num** | Percent of ended bookings | 
**guests** | **num** |  | 
**revenue** | **num** | Sum of closed bills (VND) | 
**averageBill** | **num** |  | 
**preOrderValue** | **num** |  | 
**platformFees** | **num** |  | 
**byDay** | [**List&lt;ReportDayDto&gt;**](ReportDayDto.md) |  | 
**topDishes** | [**List&lt;ReportDishDto&gt;**](ReportDishDto.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


