import 'dart:async';

import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/location.dart';
import 'discovery_repository.dart';

/// Type-ahead: restaurants and dishes, accent-insensitive ("pho" finds "Phở").
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _text = TextEditingController();
  Timer? _debounce;
  SuggestDto? _result;
  var _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _text.dispose();
    super.dispose();
  }

  void _changed(String v) {
    _debounce?.cancel();
    final q = v.trim();
    if (q.length < 2) {
      setState(() => _result = null);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      final at = await ref.read(locationProvider.future);
      try {
        final r = await ref.read(discoveryRepositoryProvider).suggest(q, at);
        if (mounted && _text.text.trim() == q) {
          setState(() {
            _result = r;
            _query = q;
          });
        }
      } catch (_) {
        // Keep the old suggestions; the full search below still works.
      }
    });
  }

  void _searchAll() {
    final q = _text.text.trim();
    if (q.isNotEmpty) context.push('/list?q=${Uri.encodeQueryComponent(q)}');
  }

  @override
  Widget build(BuildContext context) {
    final r = _result;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _text,
          autofocus: true,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(hintText: 'Tìm quán, món…', border: InputBorder.none),
          onChanged: _changed,
          onSubmitted: (_) => _searchAll(),
        ),
      ),
      body: ListView(
        children: [
          if (_text.text.trim().isNotEmpty)
            ListTile(leading: const Icon(Icons.search), title: Text('Tìm quán có "${_text.text.trim()}"'), onTap: _searchAll),
          if (r != null && r.restaurants.isNotEmpty) ...[
            const _Header('Quán'),
            for (final x in r.restaurants)
              ListTile(leading: const Icon(Icons.storefront_outlined), title: Text(x.name), onTap: () => context.push('/r/${x.slug}')),
          ],
          if (r != null && r.dishes.isNotEmpty) ...[
            const _Header('Món'),
            for (final d in r.dishes)
              ListTile(
                leading: const Icon(Icons.ramen_dining_outlined),
                title: Text(d.name),
                subtitle: Text(d.restaurantName),
                trailing: Text(formatVnd(d.price)),
                onTap: () => context.push('/r/${d.restaurantSlug}'),
              ),
          ],
          if (r != null && r.restaurants.isEmpty && r.dishes.isEmpty)
            Padding(padding: const EdgeInsets.all(24), child: Text('Không thấy gợi ý cho "$_query"')),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
    child: Text(text, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
  );
}
