/**
 * Privacy policy and terms (vi + en). ⚠️ DRAFT written by the dev team — must be reviewed by a
 * Vietnamese lawyer before launch (Decree 13/2023/ND-CP on personal data, Law on E-commerce,
 * Decree 52/2013 + 85/2021). Bump TERMS_VERSION whenever the text changes: apps ask users again.
 */
export const TERMS_VERSION = '2026-12';

type Doc = { title: string; sections: [string, string][] };

export const LEGAL: Record<'privacy' | 'terms', Record<'vi' | 'en', Doc>> = {
  privacy: {
    vi: {
      title: 'Chính sách quyền riêng tư',
      sections: [
        [
          'Chúng tôi thu thập gì',
          'Số điện thoại hoặc email để đăng nhập; tên gọi bạn nhập; lịch sử đặt bàn, món đã gọi, đánh giá; thông tin xuất hoá đơn nếu bạn yêu cầu; vị trí gần đúng khi bạn cho phép, chỉ để tìm quán gần bạn (không lưu lịch sử vị trí).',
        ],
        [
          'Dùng để làm gì',
          'Đặt bàn và gọi món với quán; gửi thông báo về đơn của bạn; xuất hoá đơn; chống đặt bàn ảo (đếm số lần vắng mặt); cải thiện dịch vụ. Chỉ gửi khuyến mãi khi bạn đồng ý.',
        ],
        [
          'Chia sẻ với ai',
          'Quán bạn đặt nhận tên gọi, số điện thoại, số người, giờ đến và món đã gọi. Cổng thanh toán (PayOS) xử lý tiền trả trước. Chúng tôi không bán dữ liệu cá nhân.',
        ],
        [
          'Lưu ở đâu, bao lâu',
          'Máy chủ được mã hoá khi truyền. Dữ liệu đặt bàn và hoá đơn được giữ theo luật kế toán, nhưng được ẩn danh khi bạn xoá tài khoản.',
        ],
        [
          'Quyền của bạn',
          'Xem và tải dữ liệu, sửa thông tin, rút lại đồng ý nhận khuyến mãi, xoá tài khoản ngay trong ứng dụng (Tài khoản). Liên hệ: privacy@comi.vn.',
        ],
      ],
    },
    en: {
      title: 'Privacy policy',
      sections: [
        [
          'What we collect',
          'Phone number or email to sign in; the name you enter; bookings, ordered dishes and reviews; invoice details if you ask for a VAT invoice; approximate location when you allow it, only to find nearby restaurants (no location history is kept).',
        ],
        [
          'Why',
          'To book tables and pre-order with restaurants, notify you about your bookings, issue invoices, prevent fake bookings (we count no-shows) and improve the service. Marketing only with your consent.',
        ],
        [
          'Who sees it',
          'The restaurant you book sees your name, phone, party size, arrival time and order. The payment gateway (PayOS) processes prepayments. We never sell personal data.',
        ],
        [
          'Where and how long',
          'Data is encrypted in transit. Booking and invoice records are kept as accounting law requires but are anonymised when you delete your account.',
        ],
        [
          'Your rights',
          'See and download your data, correct it, withdraw marketing consent, and delete your account in the app (Account). Contact: privacy@comi.vn.',
        ],
      ],
    },
  },
  terms: {
    vi: {
      title: 'Điều khoản sử dụng',
      sections: [
        ['Dịch vụ', 'comi giúp bạn đặt bàn và gọi món trước tại quán. Quán chịu trách nhiệm về món ăn, giá và phục vụ.'],
        ['Đặt bàn', 'Hãy đến đúng giờ hoặc huỷ trước. Vắng mặt nhiều lần sẽ phải trả trước cho các lần đặt sau.'],
        [
          'Thanh toán và hoàn tiền',
          'Trả tại quán hoặc trả trước qua PayOS. Tiền trả trước được hoàn khi quán huỷ, hoặc khi bạn huỷ trước giờ quán quy định.',
        ],
        [
          'Đánh giá',
          'Chỉ khách đã đến mới được đánh giá. Không đăng nội dung sai sự thật, xúc phạm hoặc quảng cáo; comi có thể ẩn nội dung vi phạm.',
        ],
        ['Đồ uống có cồn', 'Chỉ dành cho người từ 18 tuổi. Không lái xe sau khi uống rượu bia.'],
      ],
    },
    en: {
      title: 'Terms of use',
      sections: [
        ['Service', 'comi lets you book tables and pre-order at restaurants. Restaurants are responsible for food, prices and service.'],
        ['Bookings', 'Arrive on time or cancel in advance. Repeated no-shows mean future bookings must be prepaid.'],
        [
          'Payment and refunds',
          'Pay at the restaurant or prepay with PayOS. Prepayments are refunded when the restaurant cancels, or when you cancel before the restaurant cutoff.',
        ],
        ['Reviews', 'Only guests who visited can review. No false, abusive or promotional content; comi may hide reviews that break these rules.'],
        ['Alcohol', 'Only for people aged 18 and over. Never drink and drive.'],
      ],
    },
  },
};

const ESC: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' };
const esc = (s: string) => s.replace(/[&<>"]/g, (c) => ESC[c]);

export function legalHtml(doc: 'privacy' | 'terms', lang: 'vi' | 'en'): string {
  const d = LEGAL[doc][lang];
  const body = d.sections.map(([h, p]) => `<h2>${esc(h)}</h2><p>${esc(p)}</p>`).join('\n');
  return `<!doctype html><html lang="${lang}"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>${esc(d.title)} · comi</title>
<style>body{font:16px/1.6 system-ui,sans-serif;max-width:720px;margin:0 auto;padding:16px;color:#222}h1{font-size:24px}h2{font-size:18px;margin-top:24px}small{color:#777}</style>
</head><body><h1>${esc(d.title)}</h1><small>${lang === 'vi' ? 'Phiên bản' : 'Version'} ${TERMS_VERSION}</small>
${body}</body></html>`;
}
