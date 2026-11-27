import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/api_error.dart';
import 'menu_repository.dart';

const translationLocales = {'en': 'English', 'ko': '한국어', 'zh': '中文', 'ja': '日本語'};

/// Menu translation editor (§17.2). Machine translations fill in automatically; a fix made here is
/// marked "đã sửa" and is never overwritten.
class TranslationsScreen extends ConsumerStatefulWidget {
  const TranslationsScreen({super.key});

  @override
  ConsumerState<TranslationsScreen> createState() => _TranslationsScreenState();
}

class _TranslationsScreenState extends ConsumerState<TranslationsScreen> {
  var _locale = 'en';

  Future<void> _edit(TranslationRowDto r) async {
    final saved = await showDialog<(String, String?)>(
      context: context,
      builder: (_) => _EditDialog(row: r, language: translationLocales[_locale]!),
    );
    if (saved == null || !mounted) return;
    try {
      await ref.read(menuRepositoryProvider).putTranslation(r.itemId, _locale, saved.$1, saved.$2);
      ref.invalidate(translationRowsProvider(_locale));
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(content: Text('Đã lưu bản dịch')));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ApiError.from(e).userMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rows = ref.watch(translationRowsProvider(_locale));
    return Scaffold(
      appBar: AppBar(title: const Text('Bản dịch thực đơn')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SegmentedButton<String>(
              segments: [for (final e in translationLocales.entries) ButtonSegment(value: e.key, label: Text(e.value))],
              selected: {_locale},
              onSelectionChanged: (s) => setState(() => _locale = s.first),
            ),
          ),
          Expanded(
            child: rows.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(ApiError.from(e).userMessage)),
              data: (list) => ListView.separated(
                itemCount: list.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (_, i) {
                  final r = list[i];
                  final (label, color) = switch (r.state) {
                    TranslationRowDtoStateEnum.human => ('Đã sửa', Colors.green),
                    TranslationRowDtoStateEnum.machine => ('Dịch tự động', Colors.orange),
                    _ => ('Chưa dịch', theme.colorScheme.outline),
                  };
                  return ListTile(
                    title: Text(r.name ?? '—'),
                    subtitle: Text(r.sourceName),
                    trailing: Text(label, style: theme.textTheme.labelSmall?.copyWith(color: color)),
                    onTap: () => _edit(r),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditDialog extends StatefulWidget {
  const _EditDialog({required this.row, required this.language});
  final TranslationRowDto row;
  final String language;

  @override
  State<_EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<_EditDialog> {
  late final _name = TextEditingController(text: widget.row.name ?? '');
  late final _desc = TextEditingController(text: widget.row.description ?? '');

  @override
  void dispose() {
    _name.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.row;
    return AlertDialog(
      title: Text(r.sourceName),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (r.sourceDescription != null) Text(r.sourceDescription!, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 12),
            TextField(
              controller: _name,
              maxLength: 120,
              decoration: InputDecoration(labelText: 'Tên món (${widget.language})', border: const OutlineInputBorder()),
              onChanged: (_) => setState(() {}),
            ),
            if (r.sourceDescription != null)
              TextField(
                controller: _desc,
                maxLines: 3,
                maxLength: 1000,
                decoration: InputDecoration(labelText: 'Mô tả (${widget.language})', border: const OutlineInputBorder()),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
        FilledButton(
          onPressed: _name.text.trim().isEmpty
              ? null
              : () => Navigator.pop(context, (_name.text.trim(), _desc.text.trim().isEmpty ? null : _desc.text.trim())),
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}
