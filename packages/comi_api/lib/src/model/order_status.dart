//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum OrderStatus {
  @JsonValue(r'DRAFT')
  DRAFT(r'DRAFT'),
  @JsonValue(r'PLACED')
  PLACED(r'PLACED'),
  @JsonValue(r'IN_KITCHEN')
  IN_KITCHEN(r'IN_KITCHEN'),
  @JsonValue(r'SERVED')
  SERVED(r'SERVED'),
  @JsonValue(r'CANCELLED')
  CANCELLED(r'CANCELLED');

  const OrderStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
