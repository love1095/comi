import 'package:comi_api/comi_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../features/discovery/discovery_repository.dart';

/// Cover photo (full URL from the API) or a soft placeholder.
class CoverImage extends StatelessWidget {
  const CoverImage({super.key, required this.url, this.aspectRatio = 16 / 9, this.radius = 12});
  final String? url;
  final double aspectRatio;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final placeholder = ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Center(child: Icon(Icons.restaurant, color: scheme.outline, size: 36)),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: url == null ? placeholder : Image.network(url!, fit: BoxFit.cover, errorBuilder: (_, _, _) => placeholder),
      ),
    );
  }
}

/// `★ 4,6 (120) · ₫₫ · 350 m`
String cardMeta(RestaurantCardDto r) => [
  if (r.ratingCount > 0) '★ ${r.ratingAvg.toStringAsFixed(1).replaceAll('.', ',')} (${r.ratingCount})',
  '₫' * r.priceLevel.toInt(),
  if (r.distanceM != null) formatDistance(r.distanceM!),
].join(' · ');

/// Carousel card on the home screen.
class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, required this.restaurant, required this.onTap, this.width = 240});
  final RestaurantCardDto restaurant;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = restaurant;
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CoverImage(url: r.coverPhotoUrl),
            const SizedBox(height: 6),
            Text(r.name, style: theme.textTheme.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
            Text(cardMeta(r), style: theme.textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
            if (r.minMainPrice != null)
              Text(
                'Món chính từ ${formatVnd(r.minMainPrice!)}',
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
              ),
          ],
        ),
      ),
    );
  }
}

/// Row in the restaurant list.
class RestaurantTile extends StatelessWidget {
  const RestaurantTile({super.key, required this.restaurant, required this.onTap});
  final RestaurantCardDto restaurant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = restaurant;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 112,
              child: CoverImage(url: r.coverPhotoUrl, aspectRatio: 4 / 3, radius: 8),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r.name, style: theme.textTheme.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(cardMeta(r), style: theme.textTheme.bodySmall),
                  if (r.cuisineTags.isNotEmpty) Text(r.cuisineTags.take(3).join(' · '), style: theme.textTheme.bodySmall, maxLines: 1),
                  if (r.minMainPrice != null)
                    Text(
                      'Món chính từ ${formatVnd(r.minMainPrice!)}',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
                    ),
                  Text(
                    r.address,
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
