# comi_api.model.StatementDetailDto

## Load the model package
```dart
import 'package:comi_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**restaurantId** | **String** |  | 
**periodMonth** | **String** |  | 
**bookingCount** | **num** |  | 
**totalBase** | **num** |  | 
**totalFee** | **num** |  | 
**platformVoucherCredit** | **num** |  | 
**amountDue** | **num** | Negative = comi pays the restaurant | 
**status** | **String** |  | 
**issuedAt** | **String** |  | [optional] 
**paidAt** | **String** |  | [optional] 
**dueAt** | **String** |  | [optional] 
**transferMemo** | **String** | Write this on the bank transfer | 
**vietQrUrl** | **String** | VietQR image to scan with a bank app | [optional] 
**lines** | [**List&lt;StatementLineDto&gt;**](StatementLineDto.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


