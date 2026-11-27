import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/api_error.dart';
import '../../data/session.dart';
import 'onboarding_repository.dart';

/// `10.7769, 106.7009` (copied from Google Maps) → (lat, lng) inside Vietnam's rough box.
(double, double)? parseLatLng(String raw) {
  final m = RegExp(r'^\s*(-?\d+(?:\.\d+)?)\s*[,;\s]\s*(-?\d+(?:\.\d+)?)\s*$').firstMatch(raw);
  if (m == null) return null;
  final lat = double.parse(m.group(1)!);
  final lng = double.parse(m.group(2)!);
  if (lat < 8 || lat > 24 || lng < 102 || lng > 110) return null;
  return (lat, lng);
}

/// Pin the restaurant on the map (§14 nearby search needs it).
/// Address search via Goong; pasting coordinates works when search is not configured.
class LocationScreen extends ConsumerStatefulWidget {
  const LocationScreen({super.key, required this.profile});
  final RestaurantProfileDto profile;

  @override
  ConsumerState<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends ConsumerState<LocationScreen> {
  late final _query = TextEditingController(text: widget.profile.address);
  late final _coords = TextEditingController(text: widget.profile.lat == null ? '' : '${widget.profile.lat}, ${widget.profile.lng}');
  List<GeocodeResultDto>? _results;
  String? _searchError;
  var _busy = false;

  @override
  void dispose() {
    _query.dispose();
    _coords.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    setState(() {
      _busy = true;
      _searchError = null;
    });
    try {
      final r = await ref.read(onboardingRepositoryProvider).geocode(_query.text.trim());
      setState(() => _results = r);
    } catch (e) {
      final err = ApiError.from(e);
      setState(
        () => _searchError = err.code == 'SERVICE_UNAVAILABLE'
            ? 'Chưa bật tìm địa chỉ — dán toạ độ từ Google Maps bên dưới'
            : err.userMessage,
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _save(double lat, double lng, {String? address}) async {
    setState(() => _busy = true);
    try {
      await ref
          .read(onboardingRepositoryProvider)
          .updateProfile(ref.read(restaurantIdProvider), UpdateProfileDto(lat: lat, lng: lng, address: address));
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ApiError.from(e).userMessage)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coords = parseLatLng(_coords.text);
    return Scaffold(
      appBar: AppBar(title: const Text('Vị trí quán')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Tìm theo địa chỉ', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              TextField(
                controller: _query,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _search(),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(tooltip: 'Tìm', onPressed: _busy ? null : _search, icon: const Icon(Icons.search)),
                ),
              ),
              if (_searchError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(_searchError!, style: TextStyle(color: theme.colorScheme.error)),
                ),
              if (_results != null && _results!.isEmpty)
                const Padding(padding: EdgeInsets.only(top: 8), child: Text('Không tìm thấy, thử ghi rõ hơn')),
              for (final r in _results ?? const <GeocodeResultDto>[])
                ListTile(
                  leading: const Icon(Icons.place_outlined),
                  title: Text(r.address),
                  subtitle: Text('${r.lat.toStringAsFixed(5)}, ${r.lng.toStringAsFixed(5)}'),
                  onTap: _busy ? null : () => _save(r.lat.toDouble(), r.lng.toDouble(), address: r.address),
                ),
              const Divider(height: 32),
              Text('Hoặc dán toạ độ', style: theme.textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(
                'Trên Google Maps: nhấn giữ vào quán → bấm vào dòng số (ví dụ 10.7769, 106.7009) để sao chép.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _coords,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: '10.7769, 106.7009',
                  errorText: _coords.text.isNotEmpty && coords == null ? 'Toạ độ chưa đúng (phải nằm ở Việt Nam)' : null,
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: coords == null || _busy ? null : () => _save(coords.$1, coords.$2),
                child: const Text('Dùng toạ độ này'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
