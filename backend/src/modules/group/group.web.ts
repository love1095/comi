import { Controller, Get, Param, Res } from '@nestjs/common';
import { ApiExcludeController } from '@nestjs/swagger';
import { randomBytes } from 'crypto';
import { Response } from 'express';
import { Public } from '../../common/auth/decorators';

/**
 * "Join the group order" web page (§8.4) for friends without the app: name → pick dishes →
 * send. Served at /g/{token} (outside /api/v1, see bootstrap). Plain JS against the public
 * group API. Every user-provided string goes in through textContent (no HTML injection).
 */
@ApiExcludeController()
@Public()
@Controller()
export class GroupWebController {
  @Get('g/:token')
  page(@Param('token') token: string, @Res() res: Response) {
    // Tokens are base64url; anything else never reaches the page (it is embedded in a script).
    if (!/^[A-Za-z0-9_-]{8,64}$/.test(token)) return res.status(404).type('text').send('Not found');
    const nonce = randomBytes(16).toString('base64');
    res
      .setHeader(
        'Content-Security-Policy',
        `default-src 'self'; script-src 'nonce-${nonce}'; style-src 'nonce-${nonce}'; img-src 'self' https: data:; connect-src 'self'; base-uri 'none'; frame-ancestors 'none'`,
      )
      .type('html')
      .send(groupPage(nonce, token));
  }
}

export function groupPage(nonce: string, token: string): string {
  return `<!doctype html>
<html lang="vi">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex">
<title>Đặt món cùng nhóm · comi</title>
<style nonce="${nonce}">
  :root { --brand: #E4572E; --bg: #fff; --fg: #1f1f1f; --muted: #6b6b6b; --line: #e6e6e6; --card: #faf7f5; }
  @media (prefers-color-scheme: dark) { :root { --bg: #151515; --fg: #f2f2f2; --muted: #a0a0a0; --line: #2c2c2c; --card: #1e1e1e; } }
  * { box-sizing: border-box; }
  body { margin: 0; font: 16px/1.45 system-ui, -apple-system, "Segoe UI", Roboto, sans-serif; background: var(--bg); color: var(--fg); }
  main { max-width: 560px; margin: 0 auto; padding: 16px 16px 96px; }
  h1 { font-size: 22px; margin: 4px 0; } h2 { font-size: 17px; margin: 24px 0 8px; }
  .brand { color: var(--brand); font-weight: 900; font-size: 26px; }
  .muted { color: var(--muted); font-size: 14px; }
  .card { background: var(--card); border-radius: 12px; padding: 12px; margin: 8px 0; }
  .row { display: flex; align-items: center; gap: 8px; padding: 8px 0; border-bottom: 1px solid var(--line); }
  .row .grow { flex: 1; min-width: 0; }
  button { font: inherit; border: 0; border-radius: 10px; padding: 10px 14px; cursor: pointer; }
  .primary { background: var(--brand); color: #fff; font-weight: 600; }
  .ghost { background: transparent; color: var(--brand); border: 1px solid var(--brand); }
  .qty { width: 36px; height: 36px; padding: 0; border-radius: 50%; background: var(--card); color: var(--fg); border: 1px solid var(--line); }
  input { font: inherit; width: 100%; padding: 12px; border-radius: 10px; border: 1px solid var(--line); background: var(--bg); color: var(--fg); }
  .bar { position: fixed; left: 0; right: 0; bottom: 0; padding: 12px 16px; background: var(--bg); border-top: 1px solid var(--line); }
  .bar button { width: 100%; max-width: 528px; display: block; margin: 0 auto; }
  .error { color: #c62828; } .hidden { display: none; }
</style>
</head>
<body>
<main>
  <div class="brand">comi</div>
  <div id="app" class="muted">Đang tải…</div>
</main>
<div class="bar hidden" id="bar"><button class="primary" id="send"></button></div>
<script nonce="${nonce}">
(function () {
  var token = ${JSON.stringify(token)};
  var api = '/api/v1';
  var keyName = 'comi.group.' + token;
  var me = null; try { me = JSON.parse(localStorage.getItem(keyName) || 'null'); } catch (e) {}
  var group = null, menu = null, cart = {}, error = '';
  var app = document.getElementById('app'), bar = document.getElementById('bar'), sendBtn = document.getElementById('send');

  function vnd(n) { return Math.round(n).toLocaleString('vi-VN') + ' ₫'; }
  function hm(iso) { var d = new Date(iso); return d.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit', timeZone: 'Asia/Ho_Chi_Minh' }); }
  function el(tag, attrs, kids) {
    var e = document.createElement(tag);
    Object.keys(attrs || {}).forEach(function (k) { if (k === 'text') e.textContent = attrs[k]; else if (k === 'on') e.addEventListener('click', attrs[k]); else e.setAttribute(k, attrs[k]); });
    (kids || []).forEach(function (c) { if (c) e.appendChild(c); });
    return e;
  }
  function call(method, path, body) {
    return fetch(api + path, { method: method, headers: { 'Content-Type': 'application/json' }, body: body ? JSON.stringify(body) : undefined })
      .then(function (r) { return r.json().then(function (j) { if (!r.ok) throw (j.error || { message: 'Lỗi' }); return j; }); });
  }
  function message(err) {
    var map = { GROUP_LOCKED: 'Nhóm đã chốt đơn.', GROUP_FULL: 'Nhóm đã đủ người.', GUEST_KEY_INVALID: 'Vui lòng tham gia lại.', ITEM_UNAVAILABLE: 'Có món vừa hết.', KITCHEN_FULL: 'Bếp đã kín giờ này.', AGE_CONFIRMATION_REQUIRED: 'Đồ uống có cồn: cần xác nhận đủ 18 tuổi.' };
    return map[err.code] || err.message || 'Có lỗi xảy ra';
  }
  function load() {
    return call('GET', '/groups/' + encodeURIComponent(token)).then(function (g) {
      group = g;
      if (!menu) return call('GET', '/restaurants/' + g.restaurant.id + '/menu').then(function (m) { menu = m; });
    }).then(render, function (e) { app.textContent = message(e); });
  }
  function count() { return Object.keys(cart).reduce(function (s, k) { return s + cart[k].qty; }, 0); }
  function cartTotal() { return Object.keys(cart).reduce(function (s, k) { return s + cart[k].qty * cart[k].price; }, 0); }

  function render() {
    var g = group; app.textContent = ''; app.className = '';
    app.appendChild(el('h1', { text: g.restaurant.name }));
    app.appendChild(el('div', { class: 'muted', text: g.restaurant.address }));
    app.appendChild(el('div', { class: 'card', text: 'Đến lúc ' + hm(g.arrivalAt) + ' · ' + g.partySize + ' người · ' + (g.locked ? 'đã chốt đơn' : 'chốt món lúc ' + hm(g.cutoffAt)) }));
    if (error) app.appendChild(el('div', { class: 'error', text: error }));

    app.appendChild(el('h2', { text: 'Cả nhóm (' + g.guests.length + ')' }));
    g.guests.forEach(function (guest) {
      var mine = me && guest.id === me.guestId;
      app.appendChild(el('div', { class: 'row' }, [el('div', { class: 'grow', text: guest.displayName + (guest.isHost ? ' (chủ bàn)' : '') + (mine ? ' · bạn' : '') }), el('div', { text: vnd(guest.subtotal) })]));
      g.items.filter(function (i) { return i.guestId === guest.id; }).forEach(function (i) {
        var kids = [el('div', { class: 'grow muted', text: i.quantity + '× ' + i.nameSnapshot })];
        if (mine && !g.locked) kids.push(el('button', { class: 'ghost', text: 'Bỏ', on: function () { remove(i.id); } }));
        app.appendChild(el('div', { class: 'row' }, kids));
      });
    });
    app.appendChild(el('div', { class: 'row' }, [el('strong', { class: 'grow', text: 'Tổng (trả tại quán)' }), el('strong', { text: vnd(g.total) })]));

    if (g.locked) { bar.classList.add('hidden'); return; }
    if (!me) {
      var name = el('input', { placeholder: 'Tên của bạn', maxlength: '40' });
      app.appendChild(el('h2', { text: 'Tham gia đặt món' }));
      app.appendChild(name);
      app.appendChild(el('p', {}, [el('button', { class: 'primary', text: 'Tham gia', on: function () { join(name.value); } })]));
      bar.classList.add('hidden');
      return;
    }
    app.appendChild(el('h2', { text: 'Chọn món của bạn' }));
    (menu || []).forEach(function (c) {
      var dishes = c.items.filter(function (i) { return i.isAvailable && i.isPreorderable; });
      if (!dishes.length) return;
      app.appendChild(el('div', { class: 'muted', text: c.name }));
      dishes.forEach(function (d) {
        var q = cart[d.id] ? cart[d.id].qty : 0;
        app.appendChild(el('div', { class: 'row' }, [
          el('div', { class: 'grow' }, [el('div', { text: d.name }), el('div', { class: 'muted', text: vnd(d.price) + (d.isAlcohol ? ' · 18+' : '') })]),
          q ? el('button', { class: 'qty', text: '−', on: function () { change(d, -1); } }) : null,
          q ? el('span', { text: String(q) }) : null,
          el('button', { class: 'qty', text: '+', on: function () { change(d, 1); } }),
        ]));
      });
    });
    var n = count();
    bar.classList.toggle('hidden', n === 0);
    sendBtn.textContent = 'Gửi ' + n + ' món · ' + vnd(cartTotal());
  }
  function change(d, delta) {
    var line = cart[d.id] || { qty: 0, price: d.price, alcohol: d.isAlcohol, optionIds: d.optionGroups.filter(function (g) { return g.minSelect > 0 && g.options.length; }).map(function (g) { return g.options[0].id; }) };
    line.qty = Math.max(0, line.qty + delta);
    if (line.qty) cart[d.id] = line; else delete cart[d.id];
    render();
  }
  function join(name) {
    if (!name.trim()) return;
    call('POST', '/groups/' + encodeURIComponent(token) + '/join', { displayName: name.trim() }).then(function (r) {
      me = { guestId: r.guestId, guestKey: r.guestKey }; try { localStorage.setItem(keyName, JSON.stringify(me)); } catch (e) {}
      group = r; error = ''; render();
    }, function (e) { error = message(e); render(); });
  }
  function send() {
    var items = Object.keys(cart).map(function (id) { return { menuItemId: id, quantity: cart[id].qty, optionIds: cart[id].optionIds }; });
    var alcohol = Object.keys(cart).some(function (id) { return cart[id].alcohol; });
    if (alcohol && !confirm('Đơn có đồ uống có cồn. Bạn đủ 18 tuổi?')) return;
    call('POST', '/groups/' + encodeURIComponent(token) + '/items', { guestKey: me.guestKey, items: items, ageConfirmed: alcohol || undefined }).then(function (g) {
      cart = {}; group = g; error = ''; render();
    }, function (e) { if (e.code === 'GUEST_KEY_INVALID') { me = null; try { localStorage.removeItem(keyName); } catch (x) {} } error = message(e); render(); });
  }
  function remove(itemId) {
    call('POST', '/groups/' + encodeURIComponent(token) + '/items/' + itemId + '/remove', { guestKey: me.guestKey }).then(function (g) { group = g; render(); }, function (e) { error = message(e); render(); });
  }
  sendBtn.addEventListener('click', send);
  load();
  setInterval(function () { if (!count()) load(); }, 10000);
})();
</script>
</body>
</html>`;
}
