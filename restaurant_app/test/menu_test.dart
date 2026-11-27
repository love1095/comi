import 'dart:typed_data';

import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:restaurant_app/data/session.dart';
import 'package:restaurant_app/data/token_store.dart';
import 'package:restaurant_app/features/menu/import_screen.dart';
import 'package:restaurant_app/features/menu/item_editor_screen.dart';
import 'package:restaurant_app/features/menu/menu_repository.dart';
import 'package:restaurant_app/features/menu/menu_screen.dart';
import 'package:shared_ui/shared_ui.dart';

StaffMenuItemDto menuItem(
  String id,
  String name, {
  String cat = 'c1',
  num price = 50000,
  bool available = true,
  List<OptionGroupResponseDto> groups = const [],
}) => StaffMenuItemDto(
  id: id,
  categoryId: cat,
  name: name,
  price: price,
  course: Course.MAIN,
  kind: ItemKind.DISH,
  prepMinutes: 15,
  isAvailable: available,
  isPreorderable: true,
  isAlcohol: false,
  leadHours: 0,
  tags: const [],
  sortOrder: 0,
  photos: const [],
  optionGroups: groups,
  translations: const [],
);

class FakeMenuRepository implements MenuRepository {
  FakeMenuRepository(this.cats);
  List<StaffMenuCategoryDto> cats;
  final calls = <String>[];
  MenuItemDto? created;
  UpdateMenuItemDto? updated;
  ImportPreviewDto preview = ImportPreviewDto(items: const [], errors: const []);

  StaffMenuCategoryDto _cat(StaffMenuCategoryDto c, List<StaffMenuItemDto> items) =>
      StaffMenuCategoryDto(id: c.id, name: c.name, sortOrder: c.sortOrder, items: items);

  @override
  Future<List<StaffMenuCategoryDto>> getMenu() async => cats;

  @override
  Future<MenuCategoryResponseDto> createCategory(String name) async {
    calls.add('createCategory $name');
    final c = StaffMenuCategoryDto(id: 'c${cats.length + 1}', name: name, sortOrder: cats.length, items: const []);
    cats = [...cats, c];
    return MenuCategoryResponseDto(id: c.id, name: name, sortOrder: c.sortOrder);
  }

  @override
  Future<MenuCategoryResponseDto> renameCategory(String id, String name) async {
    calls.add('rename $id $name');
    return MenuCategoryResponseDto(id: id, name: name, sortOrder: 0);
  }

  @override
  Future<void> deleteCategory(String id) async => calls.add('deleteCategory $id');

  @override
  Future<void> reorderCategories(List<String> ids) async => calls.add('reorderCategories ${ids.join(',')}');

  @override
  Future<StaffMenuItemDto> createItem(MenuItemDto dto) async {
    created = dto;
    final item = menuItem('new', dto.name, cat: dto.categoryId, price: dto.price);
    cats = [
      for (final c in cats) c.id == dto.categoryId ? _cat(c, [...c.items, item]) : c,
    ];
    return item;
  }

  @override
  Future<StaffMenuItemDto> updateItem(String id, UpdateMenuItemDto dto) async {
    updated = dto;
    return menuItem(id, dto.name!, cat: dto.categoryId!, price: dto.price!);
  }

  @override
  Future<void> setAvailability(String id, bool available) async {
    calls.add('availability $id $available');
    cats = [
      for (final c in cats)
        _cat(c, [
          for (final i in c.items) i.id == id ? menuItem(i.id, i.name, cat: i.categoryId, price: i.price, available: available) : i,
        ]),
    ];
  }

  @override
  Future<void> deleteItem(String id) async => calls.add('deleteItem $id');

  @override
  Future<void> reorderItems(List<String> ids) async => calls.add('reorderItems ${ids.join(',')}');

  @override
  Future<ImportPreviewDto> importPreview(Uint8List bytes, String filename) async {
    calls.add('preview $filename');
    return preview;
  }

  @override
  Future<ImportResultDto> importConfirm(Uint8List bytes, String filename) async {
    calls.add('confirm $filename');
    return ImportResultDto(created: preview.items.length, categories: 1);
  }

  @override
  Future<UploadSignatureDto> uploadSignature(String kind) => throw UnimplementedError();

  @override
  Future<MenuPhotoDto> addPhoto(String itemId, String publicId, {int? width, int? height}) => throw UnimplementedError();

  @override
  Future<void> deletePhoto(String photoId) async => calls.add('deletePhoto $photoId');
}

void main() {
  Future<void> pump(
    WidgetTester tester,
    FakeMenuRepository repo,
    Widget screen, {
    List<Override> extra = const [],
    Size size = const Size(1280, 900),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final store = MemoryTokenStore()..value = const StoredSession(refreshToken: 'r', restaurantId: 'r1', restaurantName: 'Quán Demo');
    await tester.pumpWidget(
      ProviderScope(
        overrides: [tokenStoreProvider.overrideWithValue(store), menuRepositoryProvider.overrideWithValue(repo), ...extra],
        child: MaterialApp(theme: ComiTheme.light(), home: screen),
      ),
    );
    await tester.pumpAndSettle();
  }

  test('parsePrice understands how owners write prices', () {
    expect(parsePrice('45000'), 45000);
    expect(parsePrice('45.000'), 45000);
    expect(parsePrice('45k'), 45000);
    expect(parsePrice('45 K'), 45000);
    expect(parsePrice('1,2tr'), 1200000);
    expect(parsePrice('55.000đ'), 55000);
    expect(parsePrice('abc'), isNull);
    expect(parsePrice(''), isNull);
  });

  testWidgets('menu lists categories and dishes; sold-out switch calls the API', (tester) async {
    final repo = FakeMenuRepository([
      StaffMenuCategoryDto(id: 'c1', name: 'Cơm trưa', sortOrder: 0, items: [menuItem('i1', 'Cơm tấm sườn', price: 55000)]),
      StaffMenuCategoryDto(
        id: 'c2',
        name: 'Đồ uống',
        sortOrder: 1,
        items: [menuItem('i2', 'Trà đá', cat: 'c2', price: 5000)],
      ),
    ]);
    await pump(tester, repo, const MenuScreen());

    expect(find.text('Cơm trưa'), findsOneWidget);
    expect(find.text('Cơm tấm sườn'), findsOneWidget);
    expect(find.text('Trà đá'), findsNothing); // other category

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(repo.calls, ['availability i1 false']);
    expect(find.text('Cơm tấm sườn · Hết món'), findsOneWidget);

    await tester.tap(find.text('Đồ uống'));
    await tester.pumpAndSettle();
    expect(find.text('Trà đá'), findsOneWidget);
  });

  testWidgets('empty menu offers import and new category', (tester) async {
    final repo = FakeMenuRepository([]);
    await pump(tester, repo, const MenuScreen());
    expect(find.text('Nhập từ file Excel'), findsOneWidget);

    await tester.tap(find.text('Tạo danh mục'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Món nhậu');
    await tester.tap(find.text('Lưu'));
    await tester.pumpAndSettle();
    expect(repo.calls, ['createCategory Món nhậu']);
    expect(find.text('Món nhậu'), findsOneWidget);
  });

  group('ItemEditorScreen', () {
    final cats = [StaffMenuCategoryDto(id: 'c1', name: 'Mồi nhậu', sortOrder: 0, items: const [])];

    testWidgets('new dish: validates, saves parsed price, then offers photos', (tester) async {
      final repo = FakeMenuRepository(cats);
      await pump(
        tester,
        repo,
        ItemEditorScreen(categories: cats, categoryId: 'c1'),
        size: const Size(1280, 2600),
      );

      await tester.tap(find.text('Lưu'));
      await tester.pumpAndSettle();
      expect(find.text('Nhập tên món'), findsOneWidget);
      expect(repo.created, isNull);

      await tester.enterText(find.widgetWithText(TextField, 'Tên món *'), 'Ốc hương xào bơ');
      await tester.enterText(find.widgetWithText(TextField, 'Giá *'), '120k');
      await tester.pumpAndSettle();
      expect(find.text(formatVnd(120000)), findsOneWidget); // helper shows the parsed price
      await tester.tap(find.text('cay'));
      await tester.tap(find.text('Khai vị'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Lưu'));
      await tester.pumpAndSettle();
      final dto = repo.created!;
      expect((dto.name, dto.price, dto.course), ('Ốc hương xào bơ', 120000, MenuItemDtoCourseEnum.STARTER));
      expect(dto.tags, ['cay']);
      expect(find.text('Thêm ảnh'), findsOneWidget); // now an existing dish
    });

    testWidgets('option groups: empty option blocks saving, filled one is sent', (tester) async {
      final repo = FakeMenuRepository(cats);
      await pump(
        tester,
        repo,
        ItemEditorScreen(
          categories: cats,
          item: menuItem('i1', 'Lẩu thái', cat: 'c1', price: 250000),
        ),
        size: const Size(1280, 2600),
      );

      await tester.tap(find.text('Thêm nhóm'));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextFormField, 'Tên nhóm'), 'Size');
      await tester.pumpAndSettle();
      expect(find.text('Tuỳ chọn "Size" có dòng chưa có tên'), findsOneWidget);

      await tester.enterText(find.widgetWithText(TextFormField, 'Tuỳ chọn'), 'Nồi lớn');
      await tester.enterText(find.widgetWithText(TextFormField, '+ giá'), '50000');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Lưu'));
      await tester.pumpAndSettle();

      final g = repo.updated!.optionGroups!.single;
      expect((g.name, g.options.single.name, g.options.single.priceDelta), ('Size', 'Nồi lớn', 50000));
    });
  });

  group('ImportScreen', () {
    PickedFile file() => (name: 'menu.xlsx', bytes: Uint8List(4));

    testWidgets('errors block confirm; clean preview creates dishes', (tester) async {
      final repo = FakeMenuRepository([])
        ..preview = ImportPreviewDto(
          items: const [],
          errors: [ImportErrorDto(row: 3, column: 'Giá (VND)', message: 'Price is not a number')],
        );
      await pump(tester, repo, const ImportScreen(), extra: [pickMenuFileProvider.overrideWithValue(() async => file())]);

      await tester.tap(find.text('Chọn file'));
      await tester.pumpAndSettle();
      expect(find.text('1 lỗi — sửa trong file rồi chọn lại'), findsOneWidget);
      expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Thêm món')).onPressed, isNull);

      repo.preview = ImportPreviewDto(
        items: [
          ImportedItemDto(
            row: 2,
            category: 'Mồi nhậu',
            name: 'Ốc hương',
            price: 120000,
            course: Course.STARTER,
            kind: ItemKind.DISH,
            prepMinutes: 15,
            isAlcohol: false,
            tags: const [],
          ),
        ],
        errors: const [],
      );
      await tester.tap(find.text('Chọn file khác'));
      await tester.pumpAndSettle();
      expect(find.text('Ốc hương'), findsOneWidget);

      await tester.tap(find.text('Thêm 1 món'));
      await tester.pumpAndSettle();
      expect(repo.calls, ['preview menu.xlsx', 'preview menu.xlsx', 'confirm menu.xlsx']);
    });
  });
}
