import 'package:comi_api/comi_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../cart/cart.dart';

/// Pick options (size, spice, add-ons), quantity and a note. Pops with a [CartLine].
class ItemSheet extends StatefulWidget {
  const ItemSheet({super.key, required this.item});
  final PublicMenuItemDto item;

  @override
  State<ItemSheet> createState() => _ItemSheetState();
}

class _ItemSheetState extends State<ItemSheet> {
  /// groupId → chosen options. Single-choice groups with a minimum start on the first option.
  late final Map<String, List<PublicOptionDto>> _chosen = {
    for (final g in widget.item.optionGroups) g.id: [if (g.minSelect >= 1 && g.maxSelect == 1 && g.options.isNotEmpty) g.options.first],
  };
  var _qty = 1;
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  List<PublicOptionDto> get _options => [for (final g in widget.item.optionGroups) ..._chosen[g.id]!];

  int get _unit => widget.item.price.toInt() + _options.fold<int>(0, (s, o) => s + o.priceDelta.toInt());

  String? get _missing {
    for (final g in widget.item.optionGroups) {
      if (_chosen[g.id]!.length < g.minSelect) return 'Chọn ${g.name.toLowerCase()}';
    }
    return null;
  }

  void _toggle(PublicOptionGroupDto g, PublicOptionDto o) => setState(() {
    final list = _chosen[g.id]!;
    if (g.maxSelect == 1) {
      if (list.any((x) => x.id == o.id) && g.minSelect == 0) {
        list.clear();
      } else {
        list
          ..clear()
          ..add(o);
      }
    } else if (list.any((x) => x.id == o.id)) {
      list.removeWhere((x) => x.id == o.id);
    } else if (list.length < g.maxSelect) {
      list.add(o);
    }
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final item = widget.item;
    final missing = _missing;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.85),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(item.name, style: theme.textTheme.titleLarge),
                    if (item.description != null) Text(item.description!, style: theme.textTheme.bodyMedium),
                    for (final g in item.optionGroups) ...[
                      const SizedBox(height: 16),
                      Text(
                        '${g.name}${g.minSelect > 0 ? ' · bắt buộc' : ''}${g.maxSelect > 1 ? ' · tối đa ${g.maxSelect}' : ''}',
                        style: theme.textTheme.titleSmall,
                      ),
                      for (final o in g.options)
                        CheckboxListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(o.name),
                          secondary: o.priceDelta == 0 ? null : Text('${o.priceDelta > 0 ? '+' : ''}${formatVnd(o.priceDelta)}'),
                          value: _chosen[g.id]!.any((x) => x.id == o.id),
                          onChanged: (_) => _toggle(g, o),
                        ),
                    ],
                    const SizedBox(height: 12),
                    TextField(
                      controller: _note,
                      maxLength: 200,
                      decoration: const InputDecoration(
                        labelText: 'Ghi chú cho bếp',
                        hintText: 'Ít cay, không hành…',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  children: [
                    IconButton.outlined(
                      tooltip: 'Bớt',
                      onPressed: _qty > 1 ? () => setState(() => _qty--) : null,
                      icon: const Icon(Icons.remove),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('$_qty', style: theme.textTheme.titleMedium),
                    ),
                    IconButton.outlined(
                      tooltip: 'Thêm',
                      onPressed: _qty < 99 ? () => setState(() => _qty++) : null,
                      icon: const Icon(Icons.add),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                        onPressed: missing != null
                            ? null
                            : () => Navigator.pop(
                                context,
                                CartLine(
                                  item: item,
                                  quantity: _qty,
                                  options: _options,
                                  note: _note.text.trim().isEmpty ? null : _note.text.trim(),
                                ),
                              ),
                        child: Text(missing ?? 'Thêm · ${formatVnd(_unit * _qty)}'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
