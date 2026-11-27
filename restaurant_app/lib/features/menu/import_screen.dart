import 'dart:typed_data';

import 'package:comi_api/comi_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import 'menu_repository.dart';

typedef PickedFile = ({String name, Uint8List bytes});

/// Picks a .xlsx / .csv file. Overridden in tests.
final pickMenuFileProvider = Provider<Future<PickedFile?> Function()>(
  (ref) => () async {
    final files = await FilePicker.pickFiles(type: FileType.custom, allowedExtensions: const ['xlsx', 'csv']);
    if (files.isEmpty) return null;
    return (name: files.first.name, bytes: await files.first.readAsBytes());
  },
);

/// Excel / CSV import (§22.2 #9): pick → preview rows and errors → confirm (same file again).
/// Pops with true when dishes were created.
class ImportScreen extends ConsumerStatefulWidget {
  const ImportScreen({super.key});

  @override
  ConsumerState<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends ConsumerState<ImportScreen> {
  PickedFile? _file;
  ImportPreviewDto? _preview;
  var _busy = false;
  String? _error;

  Future<void> _pick() async {
    final file = await ref.read(pickMenuFileProvider)();
    if (file == null) return;
    setState(() {
      _file = file;
      _preview = null;
      _error = null;
      _busy = true;
    });
    try {
      final p = await ref.read(menuRepositoryProvider).importPreview(file.bytes, file.name);
      if (mounted) setState(() => _preview = p);
    } catch (e) {
      if (mounted) setState(() => _error = ApiError.from(e).userMessage);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _confirm() async {
    final file = _file!;
    setState(() => _busy = true);
    try {
      final r = await ref.read(menuRepositoryProvider).importConfirm(file.bytes, file.name);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đã thêm ${r.created} món')));
      Navigator.pop(context, true);
    } catch (e) {
      if (mounted) setState(() => _error = ApiError.from(e).userMessage);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = _preview;
    final canConfirm = p != null && p.errors.isEmpty && p.items.isNotEmpty && !_busy;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhập thực đơn từ Excel'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FilledButton(
              onPressed: canConfirm ? _confirm : null,
              child: Text(p == null || p.items.isEmpty ? 'Thêm món' : 'Thêm ${p.items.length} món'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('File .xlsx hoặc .csv, dòng đầu là tên cột:', style: theme.textTheme.titleSmall),
                  const SizedBox(height: 8),
                  const Text('Danh mục* · Tên món* · Giá (VND)* · Loại · Mô tả · Thời gian làm (phút) · Có cồn · Tags'),
                  const SizedBox(height: 4),
                  Text(
                    'Giá có thể ghi 55000, 55.000 hoặc 55k. Danh mục chưa có sẽ được tạo mới. Tối đa 500 dòng.',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  FilledButton.tonalIcon(
                    onPressed: _busy ? null : _pick,
                    icon: const Icon(Icons.folder_open),
                    label: Text(_file == null ? 'Chọn file' : 'Chọn file khác'),
                  ),
                  if (_file != null) Padding(padding: const EdgeInsets.only(top: 8), child: Text(_file!.name)),
                ],
              ),
            ),
          ),
          if (_busy)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
            ),
          if (p != null) ...[
            if (p.errors.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                '${p.errors.length} lỗi — sửa trong file rồi chọn lại',
                style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
              ),
              for (final e in p.errors)
                ListTile(
                  dense: true,
                  leading: Icon(Icons.error_outline, color: theme.colorScheme.error),
                  title: Text('Dòng ${e.row}${e.column == null ? '' : ' · ${e.column}'}'),
                  subtitle: Text(e.message),
                ),
            ],
            const SizedBox(height: 16),
            Text('${p.items.length} món đọc được', style: theme.textTheme.titleMedium),
            for (final it in p.items)
              ListTile(
                dense: true,
                leading: Text('${it.row}', style: theme.textTheme.bodySmall),
                title: Text(it.name),
                subtitle: Text([it.category, courseName(it.course), if (it.isAlcohol) 'có cồn', ...it.tags].join(' · ')),
                trailing: Text(formatVnd(it.price)),
              ),
          ],
        ],
      ),
    );
  }
}
