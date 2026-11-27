//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum RestaurantStatus {
  @JsonValue(r'DRAFT')
  DRAFT(r'DRAFT'),
  @JsonValue(r'PENDING_REVIEW')
  PENDING_REVIEW(r'PENDING_REVIEW'),
  @JsonValue(r'ACTIVE')
  ACTIVE(r'ACTIVE'),
  @JsonValue(r'PAUSED')
  PAUSED(r'PAUSED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED');

  const RestaurantStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
