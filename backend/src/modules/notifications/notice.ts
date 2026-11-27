/** Booking events → notification-center entries (§16). Pure; texts in Vietnamese (⬜ translated with app strings). */
export type BookingEvent = { status?: string; payment?: string; refund?: string; invoice?: string; approved?: boolean; by?: string };
export type Notice = { type: string; title: string; body: string };

export function bookingNotice(e: BookingEvent, ctx: { code: string; restaurantName: string }): Notice | null {
  const { code, restaurantName: name } = ctx;
  if (e.refund === 'done') return { type: 'refund.done', title: 'Đã hoàn tiền', body: `${name} đã hoàn tiền cho mã ${code}.` };
  if (e.refund === 'pending') return { type: 'refund.pending', title: 'Đang hoàn tiền', body: `Mã ${code}: tiền sẽ về trong vài ngày làm việc.` };
  if (e.payment === 'failed') return { type: 'payment.failed', title: 'Thanh toán chưa thành công', body: `Mã ${code}: thử lại hoặc chọn trả tại quán.` };
  if (e.payment === 'paid') return { type: 'payment.paid', title: 'Đã thanh toán', body: `Đã nhận tiền cho mã ${code} tại ${name}.` };
  if (e.invoice === 'issued') return { type: 'invoice.issued', title: 'Đã có hoá đơn VAT', body: `Hoá đơn cho mã ${code} đã được gửi.` };
  if (e.invoice === 'rejected') return { type: 'invoice.rejected', title: 'Quán chưa xuất hoá đơn', body: `Mã ${code}: xem lý do trong đơn.` };
  if (e.approved) return { type: 'booking.approved', title: 'Quán đã duyệt', body: `${name} đã duyệt mã ${code}.` };
  switch (e.status) {
    case 'CONFIRMED':
      return { type: 'booking.confirmed', title: 'Đã xác nhận đặt bàn', body: `${name} đã xác nhận mã ${code}.` };
    case 'CANCELLED':
      return e.by === 'USER' ? null : { type: 'booking.cancelled', title: 'Đặt bàn bị huỷ', body: `${name} đã huỷ mã ${code}.` };
    case 'EXPIRED':
      return { type: 'booking.expired', title: 'Đặt bàn đã hết hạn', body: `Mã ${code} chưa được thanh toán kịp.` };
    case 'NO_SHOW':
      return { type: 'booking.no_show', title: 'Bạn chưa đến quán', body: `${name} đánh dấu vắng mặt cho mã ${code}.` };
    case 'COMPLETED':
      return { type: 'review.ask', title: 'Bữa ăn thế nào?', body: `Đánh giá ${name} để giúp người khác chọn quán.` };
    default:
      return null;
  }
}
