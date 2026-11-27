import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../data/api_error.dart';
import '../../data/language.dart';
import '../../data/session.dart';

/// Reviews (§15): every review comes from a real booking ("verified visit").
abstract class ReviewsRepository {
  Future<ReviewPageDto> list(String restaurantId, {String? cursor});
  Future<ReviewDto> create(String bookingId, {required int rating, int? food, int? service, String? text});
  Future<ReviewDto?> mine(String bookingId);
}

class ApiReviewsRepository implements ReviewsRepository {
  ApiReviewsRepository(this._api);
  final CustomerReviewsApi _api;

  @override
  Future<ReviewPageDto> list(String restaurantId, {String? cursor}) async =>
      (await _api.reviewsList(id: restaurantId, cursor: cursor)).data!;

  @override
  Future<ReviewDto> create(String bookingId, {required int rating, int? food, int? service, String? text}) async =>
      (await _api.reviewsCreate(
        id: bookingId,
        createReviewDto: CreateReviewDto(rating: rating, foodRating: food, serviceRating: service, text: text),
      )).data!;

  @override
  Future<ReviewDto?> mine(String bookingId) async {
    try {
      return (await _api.reviewsMine(id: bookingId)).data;
    } catch (e) {
      if (ApiError.from(e).code == 'NOT_FOUND') return null;
      rethrow;
    }
  }
}

final reviewsRepositoryProvider = Provider<ReviewsRepository>(
  (ref) => ApiReviewsRepository(ref.watch(apiProvider).getCustomerReviewsApi()),
);

final reviewPageProvider = FutureProvider.autoDispose.family<ReviewPageDto, String>(
  (ref, restaurantId) => ref.watch(reviewsRepositoryProvider).list(restaurantId),
);

final myReviewProvider = FutureProvider.autoDispose.family<ReviewDto?, String>(
  (ref, bookingId) => ref.watch(reviewsRepositoryProvider).mine(bookingId),
);

class Stars extends StatelessWidget {
  const Stars(this.value, {super.key, this.size = 16});
  final num value;
  final double size;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (var i = 1; i <= 5; i++)
        Icon(value >= i ? Icons.star : (value >= i - 0.5 ? Icons.star_half : Icons.star_border), size: size, color: Colors.amber),
    ],
  );
}

class ReviewTile extends StatelessWidget {
  const ReviewTile({super.key, required this.review});
  final ReviewDto review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = review;
    final visited = toVietnamTime(DateTime.parse(r.visitedAt));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(r.authorName, style: theme.textTheme.titleSmall, overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(width: 8),
              Stars(r.rating),
              const Spacer(),
              const Icon(Icons.verified, size: 14, color: ComiColors.available),
              const SizedBox(width: 2),
              Text(context.l10n.verifiedVisit, style: theme.textTheme.labelSmall?.copyWith(color: ComiColors.available)),
            ],
          ),
          Text('${visited.day}/${visited.month}/${visited.year} · ${r.partySize} người', style: theme.textTheme.bodySmall),
          if (r.text != null) Padding(padding: const EdgeInsets.only(top: 4), child: Text(r.text!)),
          if (r.reply != null)
            Container(
              margin: const EdgeInsets.only(top: 6),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(8)),
              child: Text('Quán trả lời: ${r.reply}', style: theme.textTheme.bodySmall),
            ),
        ],
      ),
    );
  }
}

/// Rating summary + newest reviews on the restaurant page.
class ReviewsSection extends ConsumerWidget {
  const ReviewsSection({super.key, required this.restaurantId});
  final String restaurantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final page = ref.watch(reviewPageProvider(restaurantId));
    return page.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (p) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.reviews, style: theme.textTheme.titleLarge),
          if (p.ratingCount == 0)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Chưa có đánh giá — chỉ khách đã đến quán mới đánh giá được.'),
            )
          else ...[
            Row(
              children: [
                Text(p.ratingAvg.toStringAsFixed(1).replaceAll('.', ','), style: theme.textTheme.displaySmall),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stars(p.ratingAvg, size: 18),
                      Text('${p.ratingCount} lượt · tất cả từ khách đã đến', style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
            for (final r in p.items.take(3)) ReviewTile(review: r),
            if (p.items.length > 3 || p.nextCursor != null)
              TextButton(
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => AllReviewsScreen(restaurantId: restaurantId))),
                child: Text('Xem tất cả ${p.ratingCount} đánh giá'),
              ),
          ],
        ],
      ),
    );
  }
}

class AllReviewsScreen extends ConsumerWidget {
  const AllReviewsScreen({super.key, required this.restaurantId});
  final String restaurantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(reviewPageProvider(restaurantId));
    return Scaffold(
      appBar: AppBar(title: const Text('Đánh giá')),
      body: page.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(ApiError.from(e).userMessage)),
        data: (p) => ListView(
          padding: const EdgeInsets.all(16),
          children: [for (final r in p.items) ReviewTile(review: r)],
        ),
      ),
    );
  }
}

/// "How was your meal?" — after the visit, within 14 days.
class WriteReviewScreen extends ConsumerStatefulWidget {
  const WriteReviewScreen({super.key, required this.bookingId, required this.restaurantName});
  final String bookingId;
  final String restaurantName;

  @override
  ConsumerState<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends ConsumerState<WriteReviewScreen> {
  var _rating = 0;
  int? _food;
  int? _service;
  final _text = TextEditingController();
  var _busy = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    setState(() => _busy = true);
    try {
      await ref
          .read(reviewsRepositoryProvider)
          .create(
            widget.bookingId,
            rating: _rating,
            food: _food,
            service: _service,
            text: _text.text.trim().isEmpty ? null : _text.text.trim(),
          );
      ref.invalidate(myReviewProvider(widget.bookingId));
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      final err = ApiError.from(e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(switch (err.code) {
              'REVIEW_NOT_ALLOWED' => err.details['reason'] == 'TOO_LATE' ? 'Đã quá 14 ngày để đánh giá' : 'Đánh giá sau bữa ăn nhé',
              'CONFLICT' => 'Bạn đã đánh giá lần này rồi',
              _ => err.userMessage,
            }),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _picker(String label, int? value, ValueChanged<int> onPick) => Row(
    children: [
      SizedBox(width: 90, child: Text(label)),
      for (var i = 1; i <= 5; i++)
        IconButton(
          tooltip: '$label $i sao',
          onPressed: () => onPick(i),
          icon: Icon((value ?? 0) >= i ? Icons.star : Icons.star_border, color: Colors.amber),
        ),
    ],
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Đánh giá ${widget.restaurantName}')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _picker('Tổng thể', _rating == 0 ? null : _rating, (v) => setState(() => _rating = v)),
        _picker('Món ăn', _food, (v) => setState(() => _food = v)),
        _picker('Phục vụ', _service, (v) => setState(() => _service = v)),
        const SizedBox(height: 8),
        TextField(
          controller: _text,
          maxLines: 4,
          maxLength: 2000,
          decoration: const InputDecoration(labelText: 'Chia sẻ thêm (không bắt buộc)', border: OutlineInputBorder()),
        ),
        Text('Tên hiển thị chỉ là tên gọi của bạn. Đánh giá được gắn nhãn "Đã đến quán".', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 12),
        FilledButton(onPressed: _rating == 0 || _busy ? null : _send, child: Text(_busy ? 'Đang gửi…' : 'Gửi đánh giá')),
      ],
    ),
  );
}
