import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/home_shell.dart';
import '../../data/api_error.dart';
import '../../data/session.dart';
import 'tables_repository.dart';

/// Areas / floors of the restaurant (Tầng 1, Sân thượng…). Tap one to edit its table map.
class AreasScreen extends ConsumerWidget {
  const AreasScreen({super.key});

  Future<void> _create(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<(String, int)>(context: context, builder: (_) => const _NewAreaDialog());
    if (result == null) return;
    try {
      final area = await ref.read(tablesRepositoryProvider).createArea(name: result.$1, floor: result.$2, cols: 16, rows: 12);
      ref.invalidate(areasProvider);
      if (context.mounted) context.push('/areas/${area.id}');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ApiError.from(e).userMessage)));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider).value;
    final areas = ref.watch(areasProvider);

    return Scaffold(
      appBar: AppBar(title: Text(session?.restaurantName ?? 'comi'), actions: const [AccountMenu()]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _create(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Thêm khu vực'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(areasProvider.future),
        child: areas.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ListView(
            children: [
              const SizedBox(height: 120),
              Center(child: Text(ApiError.from(e).userMessage)),
              Center(
                child: TextButton(onPressed: () => ref.invalidate(areasProvider), child: const Text('Thử lại')),
              ),
            ],
          ),
          data: (list) => list.isEmpty
              ? ListView(
                  children: const [
                    SizedBox(height: 120),
                    Icon(Icons.layers_outlined, size: 56),
                    SizedBox(height: 12),
                    Center(child: Text('Chưa có khu vực nào')),
                    Center(child: Text('Ví dụ: "Tầng 1", "Sân thượng", "Phòng VIP"')),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(bottom: 96),
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final a = list[i];
                    return ListTile(
                      leading: CircleAvatar(child: Text('${a.floor}')),
                      title: Text(a.name),
                      subtitle: Text('Tầng ${a.floor} · ${a.gridCols}×${a.gridRows} ô'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/areas/${a.id}'),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _NewAreaDialog extends StatefulWidget {
  const _NewAreaDialog();

  @override
  State<_NewAreaDialog> createState() => _NewAreaDialogState();
}

class _NewAreaDialogState extends State<_NewAreaDialog> {
  final _name = TextEditingController();
  var _floor = 1;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _name.text.trim();
    if (name.isNotEmpty) Navigator.pop(context, (name, _floor));
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Khu vực mới'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _name,
          autofocus: true,
          maxLength: 60,
          decoration: const InputDecoration(labelText: 'Tên', hintText: 'Tầng 1'),
          onSubmitted: (_) => _submit(),
        ),
        Row(
          children: [
            const Expanded(child: Text('Tầng')),
            IconButton(onPressed: _floor > -3 ? () => setState(() => _floor--) : null, icon: const Icon(Icons.remove)),
            Text('$_floor'),
            IconButton(onPressed: _floor < 100 ? () => setState(() => _floor++) : null, icon: const Icon(Icons.add)),
          ],
        ),
      ],
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
      FilledButton(onPressed: _submit, child: const Text('Tạo')),
    ],
  );
}
