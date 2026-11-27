//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ServiceType {
  @JsonValue(r'CALL_WAITER')
  CALL_WAITER(r'CALL_WAITER'),
  @JsonValue(r'MORE_ICE')
  MORE_ICE(r'MORE_ICE'),
  @JsonValue(r'MORE_BOWLS')
  MORE_BOWLS(r'MORE_BOWLS'),
  @JsonValue(r'BILL_PLEASE')
  BILL_PLEASE(r'BILL_PLEASE'),
  @JsonValue(r'OTHER')
  OTHER(r'OTHER');

  const ServiceType(this.value);

  final String value;

  @override
  String toString() => value;
}
