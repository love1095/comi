import { bookingNotice } from './notice';

const ctx = { code: 'AB12CD', restaurantName: 'Quán Ốc' };

describe('bookingNotice', () => {
  it('turns booking events into short guest messages', () => {
    expect(bookingNotice({ status: 'CONFIRMED' }, ctx)).toEqual({ type: 'booking.confirmed', title: 'Đã xác nhận đặt bàn', body: 'Quán Ốc đã xác nhận mã AB12CD.' });
    expect(bookingNotice({ status: 'COMPLETED' }, ctx)?.type).toBe('review.ask');
    expect(bookingNotice({ refund: 'done' }, ctx)?.title).toBe('Đã hoàn tiền');
    expect(bookingNotice({ status: 'CANCELLED', by: 'STAFF' }, ctx)?.type).toBe('booking.cancelled');
  });

  it('stays quiet for the guest’s own actions and noise', () => {
    expect(bookingNotice({ status: 'CANCELLED', by: 'USER' }, ctx)).toBeNull();
    expect(bookingNotice({ status: 'CHECKED_IN' }, ctx)).toBeNull();
    expect(bookingNotice({ invoice: 'requested' }, ctx)).toBeNull();
  });
});
