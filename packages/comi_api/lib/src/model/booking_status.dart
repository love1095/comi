//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum BookingStatus {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'CONFIRMED')
  CONFIRMED(r'CONFIRMED'),
  @JsonValue(r'CHECKED_IN')
  CHECKED_IN(r'CHECKED_IN'),
  @JsonValue(r'COMPLETED')
  COMPLETED(r'COMPLETED'),
  @JsonValue(r'CANCELLED')
  CANCELLED(r'CANCELLED'),
  @JsonValue(r'NO_SHOW')
  NO_SHOW(r'NO_SHOW'),
  @JsonValue(r'EXPIRED')
  EXPIRED(r'EXPIRED');

  const BookingStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
