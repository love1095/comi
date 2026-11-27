import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class LatLngPoint {
  const LatLngPoint(this.lat, this.lng, {this.approximate = false});
  final double lat;
  final double lng;

  /// True when we fell back to the city centre (no permission / no GPS).
  final bool approximate;
}

/// District 1, Ho Chi Minh City — used until the launch district is decided (§27).
const fallbackLocation = LatLngPoint(10.7769, 106.7009, approximate: true);

abstract class LocationService {
  Future<LatLngPoint> current();
}

class GpsLocationService implements LocationService {
  @override
  Future<LatLngPoint> current() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return fallbackLocation;
      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.denied || perm == LocationPermission.deniedForever) return fallbackLocation;
      final p = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium, timeLimit: Duration(seconds: 8)),
      );
      return LatLngPoint(p.latitude, p.longitude);
    } catch (_) {
      return fallbackLocation;
    }
  }
}

final locationServiceProvider = Provider<LocationService>((ref) => GpsLocationService());

/// Where to search around. Refresh with `ref.invalidate(locationProvider)`.
final locationProvider = FutureProvider<LatLngPoint>((ref) => ref.watch(locationServiceProvider).current());
