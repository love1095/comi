import { splitBill } from './split';

const guests = [
  { id: 'host', isHost: true },
  { id: 'an', isHost: false },
  { id: 'binh', isHost: false },
];

describe('splitBill (§8.5)', () => {
  it('EQUAL: same share for everyone, the odd đồng goes to the host', () => {
    expect(splitBill({ total: 100_000, guests, items: [], mode: 'EQUAL' })).toEqual({ host: 33_334, an: 33_333, binh: 33_333 });
  });

  it('BY_ITEMS: own dishes + equal share of untagged ones (and anything added off-app)', () => {
    const items = [
      { amount: 55_000, guestId: 'host' },
      { amount: 45_000, guestId: 'an' },
      { amount: 60_000, guestId: null }, // shared beer tower
    ];
    // total 190k: 30k extra added by staff outside the app, shared like the beer.
    expect(splitBill({ total: 190_000, guests, items, mode: 'BY_ITEMS' })).toEqual({ host: 85_000, an: 75_000, binh: 30_000 });
  });

  it('BY_ITEMS: dishes of someone who left the group count as shared', () => {
    const items = [{ amount: 30_000, guestId: 'ghost' }];
    expect(splitBill({ total: 30_000, guests, items, mode: 'BY_ITEMS' })).toEqual({ host: 10_000, an: 10_000, binh: 10_000 });
  });

  it('CUSTOM: amounts must cover every guest and add up to the total', () => {
    expect(splitBill({ total: 100_000, guests, items: [], mode: 'CUSTOM', custom: { host: 50_000, an: 30_000, binh: 20_000 } })).toEqual({
      host: 50_000,
      an: 30_000,
      binh: 20_000,
    });
    expect(() => splitBill({ total: 100_000, guests, items: [], mode: 'CUSTOM', custom: { host: 50_000, an: 30_000 } })).toThrow(
      expect.objectContaining({ code: 'SPLIT_MISMATCH' }),
    );
    expect(() => splitBill({ total: 100_000, guests, items: [], mode: 'CUSTOM', custom: { host: 90_000, an: 30_000, binh: -20_000 } })).toThrow(
      expect.objectContaining({ code: 'SPLIT_MISMATCH' }),
    );
  });

  it('refuses a total smaller than the dishes people ordered, and an empty group', () => {
    expect(() => splitBill({ total: 10_000, guests, items: [{ amount: 50_000, guestId: 'an' }], mode: 'BY_ITEMS' })).toThrow(
      expect.objectContaining({ code: 'SPLIT_MISMATCH' }),
    );
    expect(() => splitBill({ total: 10_000, guests: [], items: [], mode: 'EQUAL' })).toThrow(expect.objectContaining({ code: 'SPLIT_MISMATCH' }));
  });
});
