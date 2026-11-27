//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum Course {
  @JsonValue(r'DRINK')
  DRINK(r'DRINK'),
  @JsonValue(r'STARTER')
  STARTER(r'STARTER'),
  @JsonValue(r'MAIN')
  MAIN(r'MAIN'),
  @JsonValue(r'DESSERT')
  DESSERT(r'DESSERT');

  const Course(this.value);

  final String value;

  @override
  String toString() => value;
}
