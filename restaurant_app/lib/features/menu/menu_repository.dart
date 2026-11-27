import 'dart:typed_data';

import 'package:comi_api/comi_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/session.dart';

/// Thin wrapper over the menu API so screens can be tested with a fake.
abstract class MenuRepository {
  Future<List<StaffMenuCategoryDto>> getMenu();
  Future<MenuCategoryResponseDto> createCategory(String name);
  Future<MenuCategoryResponseDto> renameCategory(String id, String name);
  Future<void> deleteCategory(String id);
  Future<void> reorderCategories(List<String> ids);
  Future<StaffMenuItemDto> createItem(MenuItemDto dto);
  Future<StaffMenuItemDto> updateItem(String id, UpdateMenuItemDto dto);
  Future<void> setAvailability(String id, bool available);
  Future<void> deleteItem(String id);
  Future<void> reorderItems(List<String> ids);
  Future<ImportPreviewDto> importPreview(Uint8List bytes, String filename);
  Future<ImportResultDto> importConfirm(Uint8List bytes, String filename);
  Future<UploadSignatureDto> uploadSignature(String kind);
  Future<MenuPhotoDto> addPhoto(String itemId, String publicId, {int? width, int? height});
  Future<void> deletePhoto(String photoId);
}

class ApiMenuRepository implements MenuRepository {
  ApiMenuRepository(this._api, this._media, this._rid);
  final RestaurantMenuApi _api;
  final MediaApi _media;
  final String _rid;

  MultipartFile _file(Uint8List bytes, String filename) => MultipartFile.fromBytes(bytes, filename: filename);

  @override
  Future<List<StaffMenuCategoryDto>> getMenu() async => (await _api.menuGet(xRestaurantId: _rid)).data ?? const [];

  @override
  Future<MenuCategoryResponseDto> createCategory(String name) async => (await _api.menuCreateCategory(
    xRestaurantId: _rid,
    categoryDto: CategoryDto(name: name),
  )).data!;

  @override
  Future<MenuCategoryResponseDto> renameCategory(String id, String name) async => (await _api.menuUpdateCategory(
    id: id,
    xRestaurantId: _rid,
    updateCategoryDto: UpdateCategoryDto(name: name),
  )).data!;

  @override
  Future<void> deleteCategory(String id) => _api.menuDeleteCategory(id: id, xRestaurantId: _rid);

  @override
  Future<void> reorderCategories(List<String> ids) => _api.menuReorderCategories(
    xRestaurantId: _rid,
    reorderDto: ReorderDto(ids: ids),
  );

  @override
  Future<StaffMenuItemDto> createItem(MenuItemDto dto) async => (await _api.menuCreateItem(xRestaurantId: _rid, menuItemDto: dto)).data!;

  @override
  Future<StaffMenuItemDto> updateItem(String id, UpdateMenuItemDto dto) async =>
      (await _api.menuUpdateItem(id: id, xRestaurantId: _rid, updateMenuItemDto: dto)).data!;

  @override
  Future<void> setAvailability(String id, bool available) => _api.menuAvailability(
    id: id,
    xRestaurantId: _rid,
    availabilityDto: AvailabilityDto(isAvailable: available),
  );

  @override
  Future<void> deleteItem(String id) => _api.menuDeleteItem(id: id, xRestaurantId: _rid);

  @override
  Future<void> reorderItems(List<String> ids) => _api.menuReorderItems(
    xRestaurantId: _rid,
    reorderDto: ReorderDto(ids: ids),
  );

  @override
  Future<ImportPreviewDto> importPreview(Uint8List bytes, String filename) async =>
      (await _api.menuImportPreview(xRestaurantId: _rid, file: _file(bytes, filename))).data!;

  @override
  Future<ImportResultDto> importConfirm(Uint8List bytes, String filename) async =>
      (await _api.menuImportConfirm(xRestaurantId: _rid, file: _file(bytes, filename))).data!;

  @override
  Future<UploadSignatureDto> uploadSignature(String kind) async => (await _media.mediaSignature(kind: kind, xRestaurantId: _rid)).data!;

  @override
  Future<MenuPhotoDto> addPhoto(String itemId, String publicId, {int? width, int? height}) async => (await _api.menuAddPhoto(
    id: itemId,
    xRestaurantId: _rid,
    addPhotoDto: AddPhotoDto(publicId: publicId, width: width, height: height),
  )).data!;

  @override
  Future<void> deletePhoto(String photoId) => _api.menuDeletePhoto(photoId: photoId, xRestaurantId: _rid);
}

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  final api = ref.watch(apiProvider);
  return ApiMenuRepository(api.getRestaurantMenuApi(), api.getMediaApi(), ref.watch(restaurantIdProvider));
});

final menuProvider = FutureProvider.autoDispose<List<StaffMenuCategoryDto>>((ref) => ref.watch(menuRepositoryProvider).getMenu());

/// Uploads straight to Cloudinary with a server signature (§16.1); the API then verifies the file.
abstract class PhotoUploader {
  /// Returns the Cloudinary public_id of the uploaded image.
  Future<String> upload(UploadSignatureDto sig, Uint8List bytes);
}

class CloudinaryUploader implements PhotoUploader {
  CloudinaryUploader([Dio? dio]) : _dio = dio ?? Dio();
  final Dio _dio;

  @override
  Future<String> upload(UploadSignatureDto sig, Uint8List bytes) async {
    final res = await _dio.post<Map<String, dynamic>>(
      'https://api.cloudinary.com/v1_1/${sig.cloudName}/image/upload',
      data: FormData.fromMap({
        'file': MultipartFile.fromBytes(bytes, filename: 'photo.jpg'),
        'api_key': sig.apiKey,
        'timestamp': sig.timestamp.toString(),
        'folder': sig.folder,
        'signature': sig.signature,
      }),
    );
    return res.data!['public_id'] as String;
  }
}

final photoUploaderProvider = Provider<PhotoUploader>((ref) => CloudinaryUploader());

// ───── labels ─────

String courseName(Course c) => switch (c) {
  Course.DRINK => 'Đồ uống',
  Course.STARTER => 'Khai vị',
  Course.MAIN => 'Món chính',
  Course.DESSERT => 'Tráng miệng',
};

String kindName(ItemKind k) => switch (k) {
  ItemKind.DISH => 'Món ăn',
  ItemKind.DRINK => 'Đồ uống',
  ItemKind.SET => 'Combo / set',
  ItemKind.ADD_ON => 'Món thêm',
};

/// Common tags staff can tap instead of typing (§14 filters use some of them).
const suggestedTags = ['cay', 'chay', 'bán chạy', 'món mới', 'đặc sản', 'nhậu'];
