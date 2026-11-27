import 'package:material_ui/material_ui.dart';

/// comi brand: warm chili orange (food, energy) on neutral surfaces.
class ComiColors {
  static const brand = Color(0xFFE4572E);

  // Table map states (§8.6) — chosen to stay distinguishable for colour-blind users
  // together with the icon/label shown on each table.
  static const available = Color(0xFF2E9E5B);
  static const booked = Color(0xFF9AA0A6);
  static const held = Color(0xFFF2A03D);
  static const selected = brand;
  static const unfit = Color(0xFFD7DADD);
}

class ComiTheme {
  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(seedColor: ComiColors.brand, brightness: brightness);
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
      inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
      cardTheme: const CardThemeData(margin: EdgeInsets.zero, clipBehavior: Clip.antiAlias),
    );
  }
}
