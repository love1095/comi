# comi_api.model.BookingDetailDto

## Load the model package
```dart
import 'package:comi_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**code** | **String** |  | 
**partySize** | **num** |  | 
**arrivalAt** | **String** |  | 
**endsAt** | **String** |  | 
**status** | [**BookingStatus**](BookingStatus.md) |  | 
**paymentMode** | [**PaymentMode**](PaymentMode.md) |  | 
**needsApproval** | **bool** |  | 
**note** | **String** |  | [optional] 
**tableId** | **String** |  | [optional] 
**extraTableIds** | **List&lt;String&gt;** |  | 
**table** | [**BoardTableDto**](BoardTableDto.md) |  | [optional] 
**user** | [**BoardUserDto**](BoardUserDto.md) |  | 
**order** | [**BookingDetailOrderDto**](BookingDetailOrderDto.md) |  | [optional] 
**payments** | [**List&lt;BookingPaymentDto&gt;**](BookingPaymentDto.md) |  | 
**refunds** | [**List&lt;BookingRefundDto&gt;**](BookingRefundDto.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


