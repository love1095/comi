// Socket.IO connections held open (Engine.IO v4 over WebSocket). 2 000 clients for 5 minutes.
import ws from 'k6/ws';
import { check } from 'k6';

const URL = `${__ENV.BASE.replace(/^http/, 'ws')}/socket.io/?EIO=4&transport=websocket`;

export const options = {
  stages: [
    { duration: '2m', target: 2000 },
    { duration: '5m', target: 2000 },
    { duration: '1m', target: 0 },
  ],
  thresholds: { ws_connecting: ['p(95)<1000'], checks: ['rate>0.99'] },
};

export default function () {
  const res = ws.connect(URL, {}, (socket) => {
    socket.on('message', (m) => {
      if (m.startsWith('0')) socket.send('40/customer,'); // join the public namespace
      if (m === '2') socket.send('3'); // ping → pong keeps the connection alive
    });
    socket.setTimeout(() => socket.close(), 60_000);
  });
  check(res, { 'upgraded to websocket': (r) => r && r.status === 101 });
}
