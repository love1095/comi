import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../app/home_shell.dart';
import '../../data/api_error.dart';
import 'import_screen.dart';
import 'item_editor_screen.dart';
import 'menu_repository.dart';
import 'translations_screen.dart';

/// Menu: categories (left / chips) and their dishes. Drag to reorder, switch to mark sold out.
class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  String? _selectedId;

  /// Optimistic copy after a drag, until the server answers.
  List<StaffMenuCategoryDto>? _local;

  MenuRepository get _repo => ref.read(menuRepositoryProvider);

  void _toast(String text) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  Future<bool> _run(Future<void> Function() action, {String? done}) async {
    try {
      await action();
      if (done != null && mounted) _toast(done);
      return true;
    } catch (e) {
      if (mounted) _toast(_menuError(e));
      return false;
    } finally {
      ref.invalidate(menuProvider);
    }
  }

  Future<void> _addCategory() async {
    final name = await askText(context, title: 'Danh mục mới', label: 'Tên', hint: 'Món nhậu, Cơm trưa, Đồ uống…');
    if (name == null) return;
    late MenuCategoryResponseDto created;
    if (await _run(() async => created = await _repo.createCategory(name))) setState(() => _selectedId = created.id);
  }

  Future<void> _renameCategory(StaffMenuCategoryDto c) async {
    final name = await askText(context, title: 'Đổi tên danh mục', label: 'Tên', initial: c.name);
    if (name != null && name != c.name) await _run(() => _repo.renameCategory(c.id, name));
  }

  Future<void> _deleteCategory(StaffMenuCategoryDto c) async {
    if (c.items.isNotEmpty) {
      _toast('Chuyển hoặc xoá ${c.items.length} món trong "${c.name}" trước');
      return;
    }
    if (await confirm(context, 'Xoá danh mục "${c.name}"?')) {
      if (await _run(() => _repo.deleteCategory(c.id), done: 'Đã xoá danh mục')) setState(() => _selectedId = null);
    }
  }

  Future<void> _reorderCategories(List<StaffMenuCategoryDto> cats, int from, int to) async {
    final list = [...cats];
    final moved = list.removeAt(from);
    list.insert(to, moved);
    setState(() => _local = list);
    await _run(() => _repo.reorderCategories([for (final c in list) c.id]));
  }

  Future<void> _reorderItems(List<StaffMenuCategoryDto> cats, StaffMenuCategoryDto cat, int from, int to) async {
    final items = [...cat.items];
    final moved = items.removeAt(from);
    items.insert(to, moved);
    setState(
      () => _local = [
        for (final c in cats) c.id == cat.id ? StaffMenuCategoryDto(id: c.id, name: c.name, sortOrder: c.sortOrder, items: items) : c,
      ],
    );
    await _run(() => _repo.reorderItems([for (final i in items) i.id]));
  }

  Future<void> _toggle(StaffMenuItemDto item, bool available) =>
      _run(() => _repo.setAvailability(item.id, available), done: available ? '${item.name}: còn món' : '${item.name}: hết món');

  Future<void> _openItem(List<StaffMenuCategoryDto> cats, {StaffMenuItemDto? item, String? categoryId}) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ItemEditorScreen(categories: cats, item: item, categoryId: categoryId),
      ),
    );
    ref.invalidate(menuProvider);
  }

  Future<void> _openImport() async {
    final changed = await Navigator.of(context).push<bool>(MaterialPageRoute(builder: (_) => const ImportScreen()));
    if (changed == true) ref.invalidate(menuProvider);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(menuProvider, (_, next) {
      if (next.hasValue && !next.isLoading) setState(() => _local = null);
    });
    final menu = ref.watch(menuProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thực đơn'),
        actions: [
          IconButton(tooltip: 'Nhập từ Excel', onPressed: _openImport, icon: const Icon(Icons.upload_file)),
          IconButton(
            tooltip: 'Bản dịch',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const TranslationsScreen())),
            icon: const Icon(Icons.translate),
          ),
          const AccountMenu(),
        ],
      ),
      body: menu.when(
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(ApiError.from(e).userMessage),
              TextButton(onPressed: () => ref.invalidate(menuProvider), child: const Text('Thử lại')),
            ],
          ),
        ),
        data: (serverCats) {
          final cats = _local ?? serverCats;
          if (cats.isEmpty) return _EmptyMenu(onAddCategory: _addCategory, onImport: _openImport);
          final selected = cats.firstWhere((c) => c.id == _selectedId, orElse: () => cats.first);
          final items = _ItemsPane(
            category: selected,
            onReorder: (a, b) => _reorderItems(cats, selected, a, b),
            onToggle: _toggle,
            onOpen: (i) => _openItem(cats, item: i),
            onAdd: () => _openItem(cats, categoryId: selected.id),
          );

          return LayoutBuilder(
            builder: (context, c) {
              final categoryList = _CategoryList(
                categories: cats,
                selectedId: selected.id,
                onSelect: (cat) => setState(() => _selectedId = cat.id),
                onReorder: (a, b) => _reorderCategories(cats, a, b),
                onRename: _renameCategory,
                onDelete: _deleteCategory,
                onAdd: _addCategory,
              );
              if (c.maxWidth >= 720) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(width: 260, child: categoryList),
                    const VerticalDivider(width: 1),
                    Expanded(child: items),
                  ],
                );
              }
              return Column(
                children: [
                  SizedBox(
                    height: 56,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      children: [
                        for (final cat in cats)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text('${cat.name} (${cat.items.length})'),
                              selected: cat.id == selected.id,
                              onSelected: (_) => setState(() => _selectedId = cat.id),
                            ),
                          ),
                        ActionChip(
                          avatar: const Icon(Icons.tune, size: 18),
                          label: const Text('Danh mục'),
                          onPressed: () => showModalBottomSheet<void>(
                            context: context,
                            builder: (_) => Consumer(
                              builder: (context, ref, _) {
                                final fresh = ref.watch(menuProvider).value ?? cats;
                                return _CategoryList(
                                  categories: fresh,
                                  selectedId: selected.id,
                                  onSelect: (cat) {
                                    setState(() => _selectedId = cat.id);
                                    Navigator.pop(context);
                                  },
                                  onReorder: (a, b) => _reorderCategories(fresh, a, b),
                                  onRename: _renameCategory,
                                  onDelete: _deleteCategory,
                                  onAdd: _addCategory,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(child: items),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

String _menuError(Object e) {
  final err = ApiError.from(e);
  return switch (err.code) {
    'CONFLICT' => err.message.contains('dishes') ? 'Chuyển hoặc xoá các món trong danh mục trước' : err.userMessage,
    'SERVICE_UNAVAILABLE' => 'Chưa cấu hình tải ảnh (Cloudinary)',
    _ => err.userMessage,
  };
}

class _EmptyMenu extends StatelessWidget {
  const _EmptyMenu({required this.onAddCategory, required this.onImport});
  final VoidCallback onAddCategory;
  final VoidCallback onImport;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.restaurant_menu, size: 56),
          const SizedBox(height: 12),
          const Text('Chưa có món nào'),
          const SizedBox(height: 16),
          FilledButton.icon(onPressed: onImport, icon: const Icon(Icons.upload_file), label: const Text('Nhập từ file Excel')),
          const SizedBox(height: 8),
          OutlinedButton.icon(onPressed: onAddCategory, icon: const Icon(Icons.add), label: const Text('Tạo danh mục')),
        ],
      ),
    ),
  );
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({
    required this.categories,
    required this.selectedId,
    required this.onSelect,
    required this.onReorder,
    required this.onRename,
    required this.onDelete,
    required this.onAdd,
  });

  final List<StaffMenuCategoryDto> categories;
  final String selectedId;
  final void Function(StaffMenuCategoryDto) onSelect;
  final void Function(int, int) onReorder;
  final void Function(StaffMenuCategoryDto) onRename;
  final void Function(StaffMenuCategoryDto) onDelete;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: ReorderableListView(
          buildDefaultDragHandles: false,
          onReorderItem: onReorder,
          children: [
            for (final (i, c) in categories.indexed)
              ListTile(
                key: ValueKey(c.id),
                selected: c.id == selectedId,
                leading: ReorderableDragStartListener(index: i, child: const Icon(Icons.drag_indicator)),
                title: Text(c.name),
                subtitle: Text('${c.items.length} món'),
                onTap: () => onSelect(c),
                trailing: PopupMenuButton<String>(
                  tooltip: 'Tuỳ chọn danh mục',
                  onSelected: (v) => v == 'rename' ? onRename(c) : onDelete(c),
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'rename', child: Text('Đổi tên')),
                    PopupMenuItem(value: 'delete', child: Text('Xoá')),
                  ],
                ),
              ),
          ],
        ),
      ),
      const Divider(height: 1),
      Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: double.infinity,
          child: TextButton.icon(onPressed: onAdd, icon: const Icon(Icons.add), label: const Text('Thêm danh mục')),
        ),
      ),
    ],
  );
}

class _ItemsPane extends StatelessWidget {
  const _ItemsPane({required this.category, required this.onReorder, required this.onToggle, required this.onOpen, required this.onAdd});

  final StaffMenuCategoryDto category;
  final void Function(int, int) onReorder;
  final void Function(StaffMenuItemDto, bool) onToggle;
  final void Function(StaffMenuItemDto) onOpen;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final items = category.items;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: onAdd, icon: const Icon(Icons.add), label: const Text('Thêm món')),
      body: items.isEmpty
          ? Center(child: Text('"${category.name}" chưa có món'))
          : ReorderableListView(
              buildDefaultDragHandles: false,
              padding: const EdgeInsets.only(bottom: 96),
              onReorderItem: onReorder,
              children: [
                for (final (i, item) in items.indexed)
                  _ItemTile(key: ValueKey(item.id), item: item, index: i, onTap: () => onOpen(item), onToggle: (v) => onToggle(item, v)),
              ],
            ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({super.key, required this.item, required this.index, required this.onTap, required this.onToggle});
  final StaffMenuItemDto item;
  final int index;
  final VoidCallback onTap;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final details = [
      courseName(item.course),
      if (item.isAlcohol) 'có cồn',
      if (!item.isPreorderable) 'chỉ gọi tại bàn',
      if (item.optionGroups.isNotEmpty) '${item.optionGroups.length} nhóm tuỳ chọn',
      ...item.tags,
    ];
    return ListTile(
      onTap: onTap,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ReorderableDragStartListener(index: index, child: const Icon(Icons.drag_indicator)),
          const SizedBox(width: 8),
          PhotoThumb(publicId: item.photos.isEmpty ? null : item.photos.first.publicId, size: 56),
        ],
      ),
      title: Text(
        item.isAvailable ? item.name : '${item.name} · Hết món',
        style: item.isAvailable ? null : TextStyle(color: theme.colorScheme.outline),
      ),
      subtitle: Text('${formatVnd(item.price)} · ${details.join(' · ')}', maxLines: 2, overflow: TextOverflow.ellipsis),
      trailing: Tooltip(
        message: item.isAvailable ? 'Đang bán — tắt khi hết món' : 'Hết món — bật khi có lại',
        child: Switch(value: item.isAvailable, onChanged: onToggle),
      ),
    );
  }
}

/// 4:3 photo or a placeholder icon (no photo, or Cloudinary not configured).
class PhotoThumb extends StatelessWidget {
  const PhotoThumb({super.key, required this.publicId, this.size = 56});
  final String? publicId;
  final double size;

  @override
  Widget build(BuildContext context) {
    final url = publicId == null ? null : photoUrl(publicId!, width: (size * 3).round());
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: size,
        height: size * 3 / 4,
        child: url == null
            ? ColoredBox(
                color: scheme.surfaceContainerHighest,
                child: Icon(publicId == null ? Icons.no_photography_outlined : Icons.image_outlined, size: size / 3, color: scheme.outline),
              )
            : Image.network(url, fit: BoxFit.cover, errorBuilder: (_, _, _) => const Icon(Icons.broken_image_outlined)),
      ),
    );
  }
}

/// Single text field dialog; null when cancelled or empty.
Future<String?> askText(BuildContext context, {required String title, required String label, String? hint, String? initial}) =>
    showDialog<String>(
      context: context,
      builder: (_) => _TextDialog(title: title, label: label, hint: hint, initial: initial),
    );

Future<bool> confirm(BuildContext context, String title, {String ok = 'Xoá'}) async =>
    await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Huỷ')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: Text(ok)),
        ],
      ),
    ) ??
    false;

class _TextDialog extends StatefulWidget {
  const _TextDialog({required this.title, required this.label, this.hint, this.initial});
  final String title;
  final String label;
  final String? hint;
  final String? initial;

  @override
  State<_TextDialog> createState() => _TextDialogState();
}

class _TextDialogState extends State<_TextDialog> {
  late final _text = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _submit() {
    final v = _text.text.trim();
    if (v.isNotEmpty) Navigator.pop(context, v);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: TextField(
      controller: _text,
      autofocus: true,
      maxLength: 60,
      decoration: InputDecoration(labelText: widget.label, hintText: widget.hint),
      onSubmitted: (_) => _submit(),
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
      FilledButton(onPressed: _submit, child: const Text('Lưu')),
    ],
  );
}
