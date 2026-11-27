//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ItemKind {
  @JsonValue(r'DISH')
  DISH(r'DISH'),
  @JsonValue(r'DRINK')
  DRINK(r'DRINK'),
  @JsonValue(r'SET')
  SET(r'SET'),
  @JsonValue(r'ADD_ON')
  ADD_ON(r'ADD_ON');

  const ItemKind(this.value);

  final String value;

  @override
  String toString() => value;
}
