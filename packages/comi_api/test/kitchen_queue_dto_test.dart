import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';

// tests for KitchenQueueDto
void main() {
  final KitchenQueueDto? instance = /* KitchenQueueDto(...) */ null;
  // TODO add properties to the entity

  group(KitchenQueueDto, () {
    // Server time, for \"late by\" timers
    // String now
    test('to test the property `now`', () async {
      // TODO
    });

    // COOKING first, then by fire time
    // List<KitchenItemDto> active
    test('to test the property `active`', () async {
      // TODO
    });

    // Done, waiting for a waiter
    // List<KitchenItemDto> ready
    test('to test the property `ready`', () async {
      // TODO
    });

    // SCHEDULED (next 2 h) and HOLD (COD guest not here yet)
    // List<KitchenItemDto> upcoming
    test('to test the property `upcoming`', () async {
      // TODO
    });

  });
}
