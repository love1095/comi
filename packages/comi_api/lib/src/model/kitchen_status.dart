//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum KitchenStatus {
  @JsonValue(r'HOLD')
  HOLD(r'HOLD'),
  @JsonValue(r'SCHEDULED')
  SCHEDULED(r'SCHEDULED'),
  @JsonValue(r'QUEUED')
  QUEUED(r'QUEUED'),
  @JsonValue(r'COOKING')
  COOKING(r'COOKING'),
  @JsonValue(r'READY')
  READY(r'READY'),
  @JsonValue(r'SERVED')
  SERVED(r'SERVED'),
  @JsonValue(r'CANCELLED')
  CANCELLED(r'CANCELLED');

  const KitchenStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
