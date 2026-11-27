import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for RestaurantApi
void main() {
  final instance = ComiApi().getRestaurantApi();

  group(RestaurantApi, () {
    //Future restaurantChecklist(String xRestaurantId) async
    test('test restaurantChecklist', () async {
      // TODO
    });

    //Future restaurantClosures(String xRestaurantId) async
    test('test restaurantClosures', () async {
      // TODO
    });

    //Future restaurantCreateClosure(String xRestaurantId, ClosureDto closureDto) async
    test('test restaurantCreateClosure', () async {
      // TODO
    });

    //Future restaurantDeleteClosure(String closureId, String xRestaurantId) async
    test('test restaurantDeleteClosure', () async {
      // TODO
    });

    //Future restaurantGeocode(String q) async
    test('test restaurantGeocode', () async {
      // TODO
    });

    //Future restaurantMine() async
    test('test restaurantMine', () async {
      // TODO
    });

    //Future restaurantOpeningHours(String xRestaurantId, ReplaceOpeningHoursDto replaceOpeningHoursDto) async
    test('test restaurantOpeningHours', () async {
      // TODO
    });

    //Future restaurantProfile(String xRestaurantId) async
    test('test restaurantProfile', () async {
      // TODO
    });

    //Future restaurantRegister(RegisterRestaurantDto registerRestaurantDto) async
    test('test restaurantRegister', () async {
      // TODO
    });

    //Future restaurantSubmit(String xRestaurantId) async
    test('test restaurantSubmit', () async {
      // TODO
    });

    //Future restaurantUpdateProfile(String xRestaurantId, UpdateProfileDto updateProfileDto) async
    test('test restaurantUpdateProfile', () async {
      // TODO
    });

    //Future restaurantUpdateSettings(String xRestaurantId, UpdateSettingsDto updateSettingsDto) async
    test('test restaurantUpdateSettings', () async {
      // TODO
    });

  });
}
