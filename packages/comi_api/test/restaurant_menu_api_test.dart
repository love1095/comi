import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for RestaurantMenuApi
void main() {
  final instance = ComiApi().getRestaurantMenuApi();

  group(RestaurantMenuApi, () {
    //Future menuAddPhoto(String id, String xRestaurantId, AddPhotoDto addPhotoDto) async
    test('test menuAddPhoto', () async {
      // TODO
    });

    //Future menuAvailability(String id, String xRestaurantId, AvailabilityDto availabilityDto) async
    test('test menuAvailability', () async {
      // TODO
    });

    //Future menuCreateCategory(String xRestaurantId, CategoryDto categoryDto) async
    test('test menuCreateCategory', () async {
      // TODO
    });

    //Future menuCreateItem(String xRestaurantId, MenuItemDto menuItemDto) async
    test('test menuCreateItem', () async {
      // TODO
    });

    //Future menuDeleteCategory(String id, String xRestaurantId) async
    test('test menuDeleteCategory', () async {
      // TODO
    });

    //Future menuDeleteItem(String id, String xRestaurantId) async
    test('test menuDeleteItem', () async {
      // TODO
    });

    //Future menuDeletePhoto(String photoId, String xRestaurantId) async
    test('test menuDeletePhoto', () async {
      // TODO
    });

    //Future menuGet(String xRestaurantId) async
    test('test menuGet', () async {
      // TODO
    });

    //Future menuImportConfirm(String xRestaurantId, { MultipartFile file }) async
    test('test menuImportConfirm', () async {
      // TODO
    });

    //Future menuImportPreview(String xRestaurantId, { MultipartFile file }) async
    test('test menuImportPreview', () async {
      // TODO
    });

    //Future menuReorderCategories(String xRestaurantId, ReorderDto reorderDto) async
    test('test menuReorderCategories', () async {
      // TODO
    });

    //Future menuReorderItems(String xRestaurantId, ReorderDto reorderDto) async
    test('test menuReorderItems', () async {
      // TODO
    });

    //Future menuReorderPhotos(String id, String xRestaurantId, ReorderDto reorderDto) async
    test('test menuReorderPhotos', () async {
      // TODO
    });

    //Future menuTemplate(String xRestaurantId) async
    test('test menuTemplate', () async {
      // TODO
    });

    //Future menuTranslation(String locale, Object id, String xRestaurantId, TranslationDto translationDto) async
    test('test menuTranslation', () async {
      // TODO
    });

    //Future menuUpdateCategory(String id, String xRestaurantId, UpdateCategoryDto updateCategoryDto) async
    test('test menuUpdateCategory', () async {
      // TODO
    });

    //Future menuUpdateItem(String id, String xRestaurantId, UpdateMenuItemDto updateMenuItemDto) async
    test('test menuUpdateItem', () async {
      // TODO
    });

  });
}
