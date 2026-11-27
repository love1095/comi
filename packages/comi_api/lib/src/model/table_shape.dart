//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum TableShape {
  @JsonValue(r'RECT')
  RECT(r'RECT'),
  @JsonValue(r'ROUND')
  ROUND(r'ROUND'),
  @JsonValue(r'SQUARE')
  SQUARE(r'SQUARE'),
  @JsonValue(r'BOOTH')
  BOOTH(r'BOOTH'),
  @JsonValue(r'BAR_SEAT')
  BAR_SEAT(r'BAR_SEAT');

  const TableShape(this.value);

  final String value;

  @override
  String toString() => value;
}
