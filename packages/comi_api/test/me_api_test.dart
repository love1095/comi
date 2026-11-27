import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for MeApi
void main() {
  final instance = ComiApi().getMeApi();

  group(MeApi, () {
    //Future meExtrasAddFavorite(FavoriteDto favoriteDto) async
    test('test meExtrasAddFavorite', () async {
      // TODO
    });

    //Future meExtrasDeleteSavedOrder(String id) async
    test('test meExtrasDeleteSavedOrder', () async {
      // TODO
    });

    //Future meExtrasFavorites() async
    test('test meExtrasFavorites', () async {
      // TODO
    });

    //Future meExtrasPreferences() async
    test('test meExtrasPreferences', () async {
      // TODO
    });

    //Future meExtrasRemoveFavorite(String menuItemId) async
    test('test meExtrasRemoveFavorite', () async {
      // TODO
    });

    //Future meExtrasSaveOrder(SavedOrderDto savedOrderDto) async
    test('test meExtrasSaveOrder', () async {
      // TODO
    });

    //Future meExtrasSavedOrders() async
    test('test meExtrasSavedOrders', () async {
      // TODO
    });

    //Future meExtrasUpdatePreferences(PreferencesDto preferencesDto) async
    test('test meExtrasUpdatePreferences', () async {
      // TODO
    });

    //Future usersAddDeviceToken(DeviceTokenDto deviceTokenDto) async
    test('test usersAddDeviceToken', () async {
      // TODO
    });

    //Future usersMe() async
    test('test usersMe', () async {
      // TODO
    });

    //Future usersRemove() async
    test('test usersRemove', () async {
      // TODO
    });

    //Future usersUpdate(UpdateMeDto updateMeDto) async
    test('test usersUpdate', () async {
      // TODO
    });

  });
}
