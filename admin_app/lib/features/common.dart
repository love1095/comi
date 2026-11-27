import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../data/api_error.dart';

/// Runs an admin action with a snackbar for success or the API error. Returns true on success.
Future<bool> runAction(BuildContext context, Future<Object?> Function() action, {required String done}) async {
  final messenger = ScaffoldMessenger.of(context);
  try {
    await action();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(done)));
    return true;
  } catch (e) {
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(ApiError.from(e).userMessage)));
    return false;
  }
}

/// Text prompt (reason for rejecting, blocking…). Null when cancelled.
Future<String?> askText(BuildContext context, {required String title, required String label, int minLength = 3, String ok = 'Xác nhận'}) =>
    showDialog<String>(
      context: context,
      builder: (_) => _AskDialog(title: title, label: label, minLength: minLength, ok: ok),
    );

class _AskDialog extends StatefulWidget {
  const _AskDialog({required this.title, required this.label, required this.minLength, required this.ok});
  final String title;
  final String label;
  final int minLength;
  final String ok;

  @override
  State<_AskDialog> createState() => _AskDialogState();
}

class _AskDialogState extends State<_AskDialog> {
  final _c = TextEditingController();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: SizedBox(
      width: 420,
      child: TextField(
        controller: _c,
        autofocus: true,
        maxLines: 3,
        maxLength: 500,
        decoration: InputDecoration(labelText: widget.label, border: const OutlineInputBorder()),
        onChanged: (_) => setState(() {}),
      ),
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
      FilledButton(
        onPressed: _c.text.trim().length < widget.minLength ? null : () => Navigator.pop(context, _c.text.trim()),
        child: Text(widget.ok),
      ),
    ],
  );
}

Future<bool> confirm(BuildContext context, String title, String body, {String ok = 'Đồng ý'}) async =>
    await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Huỷ')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: Text(ok)),
        ],
      ),
    ) ??
    false;

/// Loading / error / data for a page, with a retry button on errors.
class AsyncPage<T> extends StatelessWidget {
  const AsyncPage({super.key, required this.value, required this.onRetry, required this.data});
  final AsyncValue<T> value;
  final VoidCallback onRetry;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) => value.when(
    skipLoadingOnRefresh: true,
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (e, _) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(ApiError.from(e).userMessage),
          const SizedBox(height: 8),
          OutlinedButton(onPressed: onRetry, child: const Text('Thử lại')),
        ],
      ),
    ),
    data: data,
  );
}

/// Page header: title + actions, same on every page.
class PageHeader extends StatelessWidget {
  const PageHeader(this.title, {super.key, this.actions = const []});
  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
    child: Row(
      children: [
        Expanded(child: Text(title, style: Theme.of(context).textTheme.headlineSmall)),
        ...actions,
      ],
    ),
  );
}

String dateTime(String iso) {
  final t = toVietnamTime(DateTime.parse(iso));
  String two(int n) => n.toString().padLeft(2, '0');
  return '${two(t.day)}/${two(t.month)}/${t.year} ${two(t.hour)}:${two(t.minute)}';
}

String date(String iso) => dateTime(iso).substring(0, 10);
