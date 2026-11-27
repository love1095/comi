import 'dart:ui' as ui;

import 'package:comi_api/comi_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import 'crop_screen.dart';
import 'menu_repository.dart';
import 'menu_screen.dart' show PhotoThumb, confirm;

/// `45k` → 45000, `45.000` → 45000, `1,2tr` → 1200000. Null when not a price.
int? parsePrice(String raw) {
  final s = raw.trim().toLowerCase().replaceAll(' ', '').replaceAll('đ', '').replaceAll('₫', '').replaceAll('vnd', '');
  if (s.isEmpty) return null;
  final m = RegExp(r'^(\d+(?:[.,]\d+)?)(k|tr)$').firstMatch(s);
  if (m != null) {
    final n = double.tryParse(m.group(1)!.replaceAll(',', '.'));
    if (n == null) return null;
    return (n * (m.group(2) == 'k' ? 1000 : 1000000)).round();
  }
  if (!RegExp(r'^[\d.,]+$').hasMatch(s)) return null;
  return int.tryParse(s.replaceAll('.', '').replaceAll(',', ''));
}

/// Picks an image from the gallery. Overridden in tests.
final pickImageProvider = Provider<Future<Uint8List?> Function()>(
  (ref) => () async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 3000);
    return file?.readAsBytes();
  },
);

/// Editable option; a stable object so its text fields keep state while typing.
class _Opt {
  _Opt([this.name = '', this.price = 0]);
  String name;
  int price;
}

/// Editable copy of an option group.
class _Group {
  _Group({this.name = '', this.min = 0, this.max = 1, List<_Opt>? options}) : options = options ?? [_Opt()];
  String name;
  int min;
  int max;
  List<_Opt> options;

  OptionGroupDto toDto() => OptionGroupDto(
    name: name.trim(),
    minSelect: min,
    maxSelect: max,
    options: [for (final o in options) OptionDto(name: o.name.trim(), priceDelta: o.price)],
  );

  String? get problem {
    if (name.trim().isEmpty) return 'Nhóm tuỳ chọn cần tên';
    if (options.isEmpty || options.any((o) => o.name.trim().isEmpty)) return 'Tuỳ chọn "${name.trim()}" có dòng chưa có tên';
    if (max < 1 || min > max) return 'Số chọn của "${name.trim()}" không hợp lệ';
    if (min > options.length) return '"${name.trim()}" bắt chọn nhiều hơn số tuỳ chọn';
    return null;
  }
}

/// Add or edit one dish. A new dish is saved first, then photos can be added.
class ItemEditorScreen extends ConsumerStatefulWidget {
  const ItemEditorScreen({super.key, required this.categories, this.item, this.categoryId});

  final List<StaffMenuCategoryDto> categories;
  final StaffMenuItemDto? item;
  final String? categoryId;

  @override
  ConsumerState<ItemEditorScreen> createState() => _ItemEditorScreenState();
}

class _ItemEditorScreenState extends ConsumerState<ItemEditorScreen> {
  StaffMenuItemDto? _item;
  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();
  late String _categoryId;
  var _course = Course.MAIN;
  var _kind = ItemKind.DISH;
  var _prep = 15;
  var _lead = 0;
  var _preorder = true;
  var _alcohol = false;
  var _available = true;
  var _tags = <String>[];
  var _groups = <_Group>[];
  var _saving = false;
  var _uploading = false;
  var _dirty = false;

  MenuRepository get _repo => ref.read(menuRepositoryProvider);

  @override
  void initState() {
    super.initState();
    _categoryId = widget.item?.categoryId ?? widget.categoryId ?? widget.categories.first.id;
    final it = widget.item;
    if (it != null) _load(it);
    for (final c in [_name, _desc, _price]) {
      c.addListener(() => _dirty = true);
    }
  }

  void _load(StaffMenuItemDto it) {
    _item = it;
    _name.text = it.name;
    _desc.text = it.description ?? '';
    _price.text = it.price.toInt().toString();
    _categoryId = it.categoryId;
    _course = it.course;
    _kind = it.kind;
    _prep = it.prepMinutes.toInt();
    _lead = it.leadHours.toInt();
    _preorder = it.isPreorderable;
    _alcohol = it.isAlcohol;
    _available = it.isAvailable;
    _tags = [...it.tags];
    _groups = [
      for (final g in it.optionGroups)
        _Group(
          name: g.name,
          min: g.minSelect.toInt(),
          max: g.maxSelect.toInt(),
          options: [for (final o in g.options) _Opt(o.name, o.priceDelta.toInt())],
        ),
    ];
    _dirty = false;
  }

  @override
  void dispose() {
    _name.dispose();
    _desc.dispose();
    _price.dispose();
    super.dispose();
  }

  void _edit(VoidCallback f) => setState(() {
    f();
    _dirty = true;
  });

  void _toast(String text) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  List<String> get _problems => [
    if (_name.text.trim().isEmpty) 'Nhập tên món',
    if (parsePrice(_price.text) == null) 'Giá chưa đúng (ví dụ 45000 hoặc 45k)',
    for (final g in _groups) ?g.problem,
  ];

  Future<void> _save() async {
    final problems = _problems;
    if (problems.isNotEmpty) {
      _toast(problems.first);
      return;
    }
    setState(() => _saving = true);
    final price = parsePrice(_price.text)!;
    final desc = _desc.text.trim();
    try {
      final StaffMenuItemDto saved;
      if (_item == null) {
        saved = await _repo.createItem(
          MenuItemDto(
            categoryId: _categoryId,
            name: _name.text.trim(),
            description: desc.isEmpty ? null : desc,
            price: price,
            course: MenuItemDtoCourseEnum.values.byName(_course.name),
            kind: MenuItemDtoKindEnum.values.byName(_kind.name),
            prepMinutes: _prep,
            leadHours: _lead,
            isPreorderable: _preorder,
            isAlcohol: _alcohol,
            isAvailable: _available,
            tags: _tags,
            optionGroups: [for (final g in _groups) g.toDto()],
          ),
        );
      } else {
        saved = await _repo.updateItem(
          _item!.id,
          UpdateMenuItemDto(
            categoryId: _categoryId,
            name: _name.text.trim(),
            description: desc,
            price: price,
            course: UpdateMenuItemDtoCourseEnum.values.byName(_course.name),
            kind: UpdateMenuItemDtoKindEnum.values.byName(_kind.name),
            prepMinutes: _prep,
            leadHours: _lead,
            isPreorderable: _preorder,
            isAlcohol: _alcohol,
            isAvailable: _available,
            tags: _tags,
            optionGroups: [for (final g in _groups) g.toDto()],
          ),
        );
      }
      final wasNew = _item == null;
      if (!mounted) return;
      setState(() => _load(saved));
      _toast(wasNew ? 'Đã thêm món — giờ có thể thêm ảnh' : 'Đã lưu');
    } catch (e) {
      if (mounted) _toast(ApiError.from(e).userMessage);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    if (!await confirm(context, 'Xoá món "${_item!.name}"?')) return;
    try {
      await _repo.deleteItem(_item!.id);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) _toast(ApiError.from(e).userMessage);
    }
  }

  Future<void> _addPhoto() async {
    final picked = await ref.read(pickImageProvider)();
    if (picked == null || !mounted) return;
    final cropped = await Navigator.of(context).push<Uint8List>(MaterialPageRoute(builder: (_) => CropScreen(image: picked)));
    if (cropped == null || !mounted) return;
    setState(() => _uploading = true);
    try {
      final size = await imageSize(cropped);
      if (size.$1 < 1200 || size.$2 < 900) {
        _toast('Ảnh nhỏ quá (${size.$1}×${size.$2}). Cần ít nhất 1200×900 — chọn ảnh rõ hơn hoặc cắt rộng hơn');
        return;
      }
      final sig = await _repo.uploadSignature('menu_item');
      final publicId = await ref.read(photoUploaderProvider).upload(sig, cropped);
      final photo = await _repo.addPhoto(_item!.id, publicId, width: size.$1, height: size.$2);
      if (!mounted) return;
      setState(() => _item = _withPhotos(_item!, [..._item!.photos, photo]));
      _toast('Đã thêm ảnh');
    } catch (e) {
      final err = ApiError.from(e);
      if (mounted) _toast(err.code == 'SERVICE_UNAVAILABLE' ? 'Chưa cấu hình tải ảnh (Cloudinary)' : err.userMessage);
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<void> _deletePhoto(MenuPhotoDto p) async {
    if (!await confirm(context, 'Xoá ảnh này?')) return;
    try {
      await _repo.deletePhoto(p.id);
      if (mounted) setState(() => _item = _withPhotos(_item!, _item!.photos.where((x) => x.id != p.id).toList()));
    } catch (e) {
      if (mounted) _toast(ApiError.from(e).userMessage);
    }
  }

  StaffMenuItemDto _withPhotos(StaffMenuItemDto i, List<MenuPhotoDto> photos) => StaffMenuItemDto(
    id: i.id,
    categoryId: i.categoryId,
    name: i.name,
    description: i.description,
    price: i.price,
    course: i.course,
    kind: i.kind,
    prepMinutes: i.prepMinutes,
    isAvailable: i.isAvailable,
    isPreorderable: i.isPreorderable,
    isAlcohol: i.isAlcohol,
    leadHours: i.leadHours,
    tags: i.tags,
    sortOrder: i.sortOrder,
    photos: photos,
    optionGroups: i.optionGroups,
    translations: i.translations,
  );

  Future<bool> _confirmLeave() async => !_dirty || await confirm(context, 'Bỏ các thay đổi chưa lưu?', ok: 'Bỏ thay đổi');

  @override
  Widget build(BuildContext context) {
    final isNew = _item == null;
    final price = parsePrice(_price.text);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (await _confirmLeave() && context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(isNew ? 'Món mới' : _item!.name),
          actions: [
            if (!isNew) IconButton(tooltip: 'Xoá món', onPressed: _delete, icon: const Icon(Icons.delete_outline)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FilledButton(onPressed: _saving ? null : _save, child: Text(_saving ? 'Đang lưu…' : 'Lưu')),
            ),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _photos(isNew),
                const SizedBox(height: 16),
                TextField(
                  controller: _name,
                  maxLength: 120,
                  decoration: const InputDecoration(labelText: 'Tên món *', border: OutlineInputBorder()),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _price,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Giá *',
                          hintText: '45000 hoặc 45k',
                          border: const OutlineInputBorder(),
                          helperText: price == null ? null : formatVnd(price),
                          errorText: _price.text.isNotEmpty && price == null ? 'Giá chưa đúng' : null,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: _categoryId,
                        decoration: const InputDecoration(labelText: 'Danh mục', border: OutlineInputBorder()),
                        items: [for (final c in widget.categories) DropdownMenuItem(value: c.id, child: Text(c.name))],
                        onChanged: (v) => _edit(() => _categoryId = v!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _desc,
                  maxLength: 1000,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Mô tả', hintText: 'Nguyên liệu, khẩu phần…', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 8),
                Text('Phục vụ theo', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 4),
                SegmentedButton<Course>(
                  showSelectedIcon: false,
                  segments: [for (final c in Course.values) ButtonSegment(value: c, label: Text(courseName(c)))],
                  selected: {_course},
                  onSelectionChanged: (s) => _edit(() => _course = s.first),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<ItemKind>(
                        initialValue: _kind,
                        decoration: const InputDecoration(labelText: 'Loại', border: OutlineInputBorder()),
                        items: [for (final k in ItemKind.values) DropdownMenuItem(value: k, child: Text(kindName(k)))],
                        onChanged: (v) => _edit(() => _kind = v!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _Stepper(
                        label: 'Thời gian làm',
                        value: _prep,
                        unit: 'phút',
                        step: 5,
                        max: 240,
                        onChanged: (v) => _edit(() => _prep = v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Còn món'),
                  subtitle: const Text('Tắt khi hết hàng hôm nay'),
                  value: _available,
                  onChanged: (v) => _edit(() => _available = v),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Cho đặt trước'),
                  subtitle: const Text('Tắt nếu món chỉ gọi khi đã ngồi tại bàn'),
                  value: _preorder,
                  onChanged: (v) => _edit(() => _preorder = v),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Đồ uống có cồn'),
                  subtitle: const Text('Khách phải xác nhận đủ 18 tuổi; không áp dụng voucher'),
                  value: _alcohol,
                  onChanged: (v) => _edit(() => _alcohol = v),
                ),
                _Stepper(
                  label: 'Đặt trước ít nhất',
                  value: _lead,
                  unit: 'giờ',
                  step: 1,
                  max: 168,
                  onChanged: (v) => _edit(() => _lead = v),
                ),
                const SizedBox(height: 16),
                Text('Nhãn', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final t in {...suggestedTags, ..._tags})
                      FilterChip(
                        label: Text(t),
                        selected: _tags.contains(t),
                        onSelected: (on) => _edit(() => on ? _tags.add(t) : _tags.remove(t)),
                      ),
                  ],
                ),
                const Divider(height: 32),
                _optionGroups(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _photos(bool isNew) {
    final theme = Theme.of(context);
    if (isNew) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.photo_camera_outlined),
          title: const Text('Ảnh món'),
          subtitle: const Text('Lưu món trước, sau đó thêm ảnh (khổ 4:3, tối thiểu 1200×900)'),
          textColor: theme.colorScheme.outline,
        ),
      );
    }
    final photos = _item!.photos;
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final p in photos)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Stack(
                children: [
                  PhotoThumb(publicId: p.publicId, size: 160),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton.filledTonal(
                      tooltip: 'Xoá ảnh',
                      iconSize: 18,
                      onPressed: () => _deletePhoto(p),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
          if (photos.length < 8)
            SizedBox(
              width: 160,
              child: OutlinedButton(
                onPressed: _uploading ? null : _addPhoto,
                child: _uploading
                    ? const CircularProgressIndicator()
                    : const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [Icon(Icons.add_a_photo_outlined), SizedBox(height: 4), Text('Thêm ảnh')],
                      ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _optionGroups() {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text('Tuỳ chọn (size, độ cay, topping…)', style: theme.textTheme.titleMedium)),
            TextButton.icon(
              onPressed: () => _edit(() => _groups.add(_Group())),
              icon: const Icon(Icons.add),
              label: const Text('Thêm nhóm'),
            ),
          ],
        ),
        for (final (gi, g) in _groups.indexed)
          Card(
            key: ObjectKey(g),
            margin: const EdgeInsets.only(top: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: g.name,
                          decoration: const InputDecoration(labelText: 'Tên nhóm', hintText: 'Size'),
                          onChanged: (v) => _edit(() => g.name = v),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Xoá nhóm',
                        onPressed: () => _edit(() => _groups.removeAt(gi)),
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      _Stepper(label: 'Bắt buộc chọn', value: g.min, unit: '', step: 1, max: 20, onChanged: (v) => _edit(() => g.min = v)),
                      _Stepper(
                        label: 'Chọn tối đa',
                        value: g.max,
                        unit: '',
                        step: 1,
                        min: 1,
                        max: 20,
                        onChanged: (v) => _edit(() => g.max = v),
                      ),
                    ],
                  ),
                  for (final (oi, o) in g.options.indexed)
                    Row(
                      key: ObjectKey(o),
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            initialValue: o.name,
                            decoration: const InputDecoration(labelText: 'Tuỳ chọn', hintText: 'Lớn'),
                            onChanged: (v) => _edit(() => o.name = v),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            initialValue: o.price == 0 ? '' : o.price.toString(),
                            decoration: const InputDecoration(labelText: '+ giá', hintText: '0'),
                            keyboardType: const TextInputType.numberWithOptions(signed: true),
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*'))],
                            onChanged: (v) => _edit(() => o.price = int.tryParse(v) ?? 0),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Xoá tuỳ chọn',
                          onPressed: g.options.length > 1 ? () => _edit(() => g.options.removeAt(oi)) : null,
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                      ],
                    ),
                  TextButton.icon(
                    onPressed: () => _edit(() => g.options.add(_Opt())),
                    icon: const Icon(Icons.add),
                    label: const Text('Thêm tuỳ chọn'),
                  ),
                  if (g.problem != null) Text(g.problem!, style: TextStyle(color: theme.colorScheme.error)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.label,
    required this.value,
    required this.unit,
    required this.step,
    required this.max,
    required this.onChanged,
    this.min = 0,
  });
  final String label;
  final int value;
  final String unit;
  final int step;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flexible(child: Text(label)),
      IconButton(
        tooltip: 'Bớt',
        onPressed: value > min ? () => onChanged((value - step).clamp(min, max)) : null,
        icon: const Icon(Icons.remove),
      ),
      Text(unit.isEmpty ? '$value' : '$value $unit'),
      IconButton(
        tooltip: 'Thêm',
        onPressed: value < max ? () => onChanged((value + step).clamp(min, max)) : null,
        icon: const Icon(Icons.add),
      ),
    ],
  );
}

/// Pixel size of encoded image bytes.
Future<(int, int)> imageSize(Uint8List bytes) async {
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  final size = (frame.image.width, frame.image.height);
  frame.image.dispose();
  codec.dispose();
  return size;
}
