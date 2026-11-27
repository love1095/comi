import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../../data/location.dart';
import '../../widgets/restaurant_card.dart';
import '../discovery/discovery_repository.dart';

/// Home: sections change with the time of day — lunch around noon, groups in the evening (§0.5).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static String greeting(String mode) => switch (mode) {
    'lunch' => 'Trưa nay ăn gì?',
    'tonight' => 'Tối nay đi đâu?',
    _ => 'Tìm quán ngon gần bạn',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final home = ref.watch(homeProvider);
    final location = ref.watch(locationProvider).value;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(locationProvider);
            ref.invalidate(homeProvider);
            await ref.read(homeProvider.future);
          },
          child: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Row(
                  children: [
                    Text(
                      'comi',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: ComiColors.brand),
                    ),
                    const Spacer(),
                    Icon(Icons.place_outlined, size: 18, color: theme.colorScheme.outline),
                    Text(
                      location == null ? 'Đang tìm vị trí…' : (location.approximate ? 'Quận 1 (gần đúng)' : 'Gần bạn'),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(greeting(home.value?.mode.value ?? ''), style: theme.textTheme.headlineSmall),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () => context.push('/search'),
                  borderRadius: BorderRadius.circular(28),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Tìm quán, món (phở, lẩu, ốc…)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
                      isDense: true,
                    ),
                    child: Text('Tìm quán, món (phở, lẩu, ốc…)', style: TextStyle(color: theme.colorScheme.outline)),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    for (final (label, query) in const [
                      ('Cơm trưa', 'mode=lunch'),
                      ('Dưới 60k', 'under60k=1'),
                      ('Đi nhóm 10+', 'groups10=1'),
                      ('Quán nhậu', 'mode=nhau'),
                      ('Mở khuya', 'openLate=1'),
                      ('Trong 500 m', 'within500m=1'),
                    ])
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ActionChip(label: Text(label), onPressed: () => context.push('/list?$query')),
                      ),
                  ],
                ),
              ),
              ...home.when(
                loading: () => const [
                  Padding(
                    padding: EdgeInsets.all(48),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
                error: (e, _) => [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Text(ApiError.from(e).userMessage, textAlign: TextAlign.center),
                        TextButton(onPressed: () => ref.invalidate(homeProvider), child: const Text('Thử lại')),
                      ],
                    ),
                  ),
                ],
                data: (h) => h.sections.isEmpty
                    ? [
                        const Padding(
                          padding: EdgeInsets.all(32),
                          child: Text('Chưa có quán nào gần đây. comi đang mở rộng — quay lại sớm nhé!', textAlign: TextAlign.center),
                        ),
                      ]
                    : [
                        for (final s in h.sections) ...[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 20, 8, 8),
                            child: Row(
                              children: [
                                Expanded(child: Text(sectionTitle(s.key), style: theme.textTheme.titleMedium)),
                                TextButton(onPressed: () => context.push('/list?section=${s.key}'), child: const Text('Xem tất cả')),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 230,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: s.items.length,
                              separatorBuilder: (_, _) => const SizedBox(width: 12),
                              itemBuilder: (_, i) =>
                                  RestaurantCard(restaurant: s.items[i], onTap: () => context.push('/r/${s.items[i].slug}')),
                            ),
                          ),
                        ],
                      ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Filters for a home section's "Xem tất cả".
SearchFilters filtersForSection(String key) => switch (key) {
  'lunch_near_you' => const SearchFilters(mode: 'lunch', openNow: true),
  'under_60k' => const SearchFilters(under60k: true),
  'tonight_groups' => const SearchFilters(mode: 'nhau', groups10: true),
  'open_late' => const SearchFilters(openLate: true),
  'top_rated' => const SearchFilters(sortByRating: true),
  _ => const SearchFilters(),
};

/// Filters from `/list?...` query parameters.
SearchFilters filtersFromQuery(Map<String, String> q) {
  if (q['section'] != null) return filtersForSection(q['section']!);
  bool on(String k) => q[k] == '1' || q[k] == 'true';
  return SearchFilters(
    q: q['q'],
    mode: q['mode'],
    under60k: on('under60k'),
    within500m: on('within500m'),
    groups10: on('groups10'),
    openLate: on('openLate'),
    openNow: on('openNow'),
  );
}
