import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'session.dart';

/// A "something changed" hint from the server (§19.1). Screens reload over REST — REST is the truth.
class RealtimeEvent {
  const RealtimeEvent(this.name, [this.data = const {}]);
  final String name;
  final Map<String, dynamic> data;

  /// Sent locally after a reconnect: reload everything that is on screen.
  static const reconnected = 'reconnected';

  bool get isBooking => name.startsWith('booking.') || name == 'order.round_added' || name == reconnected;
  bool get isKitchen => name.startsWith('kitchen.') || name == 'order.round_added' || name == reconnected;
  bool get isService => name.startsWith('service.') || name == reconnected;
}

const _events = [
  'booking.created',
  'booking.updated',
  'booking.checked_in',
  'booking.eta_updated',
  'kitchen.item_queued',
  'kitchen.item_updated',
  'order.round_added',
  'service.requested',
  'service.updated',
];

abstract class RealtimeClient {
  Stream<RealtimeEvent> get events;
  void dispose();
}

/// Staff socket: `/restaurant` namespace, joins the restaurant room (and the kitchen room on kitchen screens).
class SocketRealtimeClient implements RealtimeClient {
  SocketRealtimeClient({required String baseUrl, required String token, required String restaurantId}) {
    _socket = io.io(
      '$baseUrl/restaurant',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token, 'restaurantId': restaurantId, 'kitchen': true})
          .enableReconnection()
          .enableForceNew()
          .build(),
    );
    for (final e in _events) {
      _socket.on(e, (data) => _controller.add(RealtimeEvent(e, data is Map ? data.cast<String, dynamic>() : const {})));
    }
    var connectedOnce = false;
    _socket.onConnect((_) {
      if (connectedOnce) _controller.add(const RealtimeEvent(RealtimeEvent.reconnected));
      connectedOnce = true;
    });
  }

  late final io.Socket _socket;
  final _controller = StreamController<RealtimeEvent>.broadcast();

  @override
  Stream<RealtimeEvent> get events => _controller.stream;

  @override
  void dispose() {
    _socket.dispose();
    _controller.close();
  }
}

/// No socket (logged out, tests).
class NoRealtimeClient implements RealtimeClient {
  @override
  Stream<RealtimeEvent> get events => const Stream.empty();

  @override
  void dispose() {}
}

/// Reconnects when the access token or the restaurant changes.
final realtimeClientProvider = Provider<RealtimeClient>((ref) {
  final s = ref.watch(sessionProvider).value;
  if (s?.accessToken == null || s?.restaurantId == null) return NoRealtimeClient();
  final client = SocketRealtimeClient(baseUrl: ref.watch(apiBaseUrlProvider), token: s!.accessToken!, restaurantId: s.restaurantId!);
  ref.onDispose(client.dispose);
  return client;
});

final realtimeEventsProvider = StreamProvider<RealtimeEvent>((ref) => ref.watch(realtimeClientProvider).events);
