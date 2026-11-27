import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// One dish in the cart with its chosen options.
class CartLine {
  const CartLine({required this.item, required this.quantity, this.options = const [], this.note});

  final PublicMenuItemDto item;
  final int quantity;
  final List<PublicOptionDto> options;
  final String? note;

  int get unitPrice => item.price.toInt() + options.fold<int>(0, (s, o) => s + o.priceDelta.toInt());
  int get total => unitPrice * quantity;

  /// Same dish + same options + same note → merge into one line.
  String get key => '${item.id}|${(options.map((o) => o.id).toList()..sort()).join(',')}|${note ?? ''}';

  CartLine copyWith({int? quantity}) => CartLine(item: item, quantity: quantity ?? this.quantity, options: options, note: note);

  CartLineDto toDto() =>
      CartLineDto(menuItemId: item.id, quantity: quantity, optionIds: options.isEmpty ? null : [for (final o in options) o.id], note: note);
}

/// Pre-order cart. One restaurant at a time (§8.2).
class CartState {
  const CartState({this.restaurantId, this.restaurantSlug, this.restaurantName, this.lines = const []});

  final String? restaurantId;
  final String? restaurantSlug;
  final String? restaurantName;
  final List<CartLine> lines;

  int get count => lines.fold(0, (s, l) => s + l.quantity);
  int get total => lines.fold(0, (s, l) => s + l.total);
  bool get isEmpty => lines.isEmpty;
  bool get hasAlcohol => lines.any((l) => l.item.isAlcohol);

  int quantityOf(String itemId) => lines.where((l) => l.item.id == itemId).fold(0, (s, l) => s + l.quantity);

  /// Lines grouped by course, in serving order (drinks first, §7).
  Map<Course, List<CartLine>> get byCourse => {
    for (final c in Course.values)
      if (lines.any((l) => l.item.course == c)) c: lines.where((l) => l.item.course == c).toList(),
  };
}

class CartController extends Notifier<CartState> {
  @override
  CartState build() => const CartState();

  /// True when adding would replace another restaurant's cart (ask the user first).
  bool belongsToOther(String restaurantId) => state.restaurantId != null && state.restaurantId != restaurantId && !state.isEmpty;

  void add(RestaurantRef r, CartLine line) {
    final base = belongsToOther(r.id) || state.restaurantId != r.id
        ? CartState(restaurantId: r.id, restaurantSlug: r.slug, restaurantName: r.name)
        : state;
    final i = base.lines.indexWhere((l) => l.key == line.key);
    final lines = [...base.lines];
    if (i >= 0) {
      lines[i] = lines[i].copyWith(quantity: (lines[i].quantity + line.quantity).clamp(1, 99));
    } else {
      lines.add(line);
    }
    state = CartState(
      restaurantId: base.restaurantId,
      restaurantSlug: base.restaurantSlug,
      restaurantName: base.restaurantName,
      lines: lines,
    );
  }

  void setQuantity(String key, int quantity) {
    final lines = [
      for (final l in state.lines)
        if (l.key != key) l else if (quantity > 0) l.copyWith(quantity: quantity.clamp(1, 99)),
    ];
    state = CartState(
      restaurantId: state.restaurantId,
      restaurantSlug: state.restaurantSlug,
      restaurantName: state.restaurantName,
      lines: lines,
    );
  }

  /// Removes one of a dish (newest line first) — the "−" on the menu.
  void removeOne(String itemId) {
    final i = state.lines.lastIndexWhere((l) => l.item.id == itemId);
    if (i < 0) return;
    setQuantity(state.lines[i].key, state.lines[i].quantity - 1);
  }

  void clear() => state = const CartState();
}

final cartProvider = NotifierProvider<CartController, CartState>(CartController.new);

typedef RestaurantRef = ({String id, String slug, String name});

String courseName(Course c) => switch (c) {
  Course.DRINK => 'Đồ uống',
  Course.STARTER => 'Khai vị',
  Course.MAIN => 'Món chính',
  Course.DESSERT => 'Tráng miệng',
};
