import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';

// tests for OpeningHoursItemDto
void main() {
  final OpeningHoursItemDto? instance = /* OpeningHoursItemDto(...) */ null;
  // TODO add properties to the entity

  group(OpeningHoursItemDto, () {
    // 0 = Sunday
    // num weekday
    test('to test the property `weekday`', () async {
      // TODO
    });

    // Minutes from 00:00
    // num openMinute
    test('to test the property `openMinute`', () async {
      // TODO
    });

    // May be > 1440 for after midnight
    // num closeMinute
    test('to test the property `closeMinute`', () async {
      // TODO
    });

    // num lastOrderMinute
    test('to test the property `lastOrderMinute`', () async {
      // TODO
    });

  });
}
