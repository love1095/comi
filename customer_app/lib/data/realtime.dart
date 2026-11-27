import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'session.dart';

/// Server hint (§19.1): booking status, dish cooking/ready, staff answered a request. Reload over REST.
class RealtimeEvent {
  const RealtimeEvent(this.name, [this.data = const {}]);
  final String name;
  final Map<String, dynamic> data;

  static const reconnected = 'reconnected';

  /// Does this concern booking [id]?
  bool about(String id) => name == reconnected || data['bookingId'] == id;
}

abstract class RealtimeClient {
  Stream<RealtimeEvent> get events;
  void dispose();
}

class SocketRealtimeClient implements RealtimeClient {
  SocketRealtimeClient({required String baseUrl, required String token}) {
    _socket = io.io(
      '$baseUrl/customer',
      io.OptionBuilder().setTransports(['websocket']).setAuth({'token': token}).enableReconnection().enableForceNew().build(),
    );
    for (final e in const ['booking.status', 'order.item_status', 'service.updated']) {
      _socket.on(e, (data) => _controller.add(RealtimeEvent(e, data is Map ? data.cast<String, dynamic>() : const {})));
    }
    var once = false;
    _socket.onConnect((_) {
      if (once) _controller.add(const RealtimeEvent(RealtimeEvent.reconnected));
      once = true;
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

class NoRealtimeClient implements RealtimeClient {
  @override
  Stream<RealtimeEvent> get events => const Stream.empty();

  @override
  void dispose() {}
}

final realtimeClientProvider = Provider<RealtimeClient>((ref) {
  final token = ref.watch(sessionProvider.select((s) => s.value?.accessToken));
  if (token == null) return NoRealtimeClient();
  final c = SocketRealtimeClient(baseUrl: ref.watch(apiBaseUrlProvider), token: token);
  ref.onDispose(c.dispose);
  return c;
});

final realtimeEventsProvider = StreamProvider<RealtimeEvent>((ref) => ref.watch(realtimeClientProvider).events);
