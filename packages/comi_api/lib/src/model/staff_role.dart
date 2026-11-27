//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum StaffRole {
  @JsonValue(r'OWNER')
  OWNER(r'OWNER'),
  @JsonValue(r'MANAGER')
  MANAGER(r'MANAGER'),
  @JsonValue(r'CASHIER')
  CASHIER(r'CASHIER'),
  @JsonValue(r'KITCHEN')
  KITCHEN(r'KITCHEN');

  const StaffRole(this.value);

  final String value;

  @override
  String toString() => value;
}
