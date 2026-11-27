/**
 * Demo data for local dev: `npm run db:seed` (runs after `prisma migrate reset` too).
 *   admin@comi.vn  / comi12345   platform admin
 *   owner@comi.vn  / comi12345   OWNER of both demo restaurants
 *   bep@comi.vn    / comi12345   KITCHEN at Cơm Tấm Văn Phòng
 * Customer login in dev: POST /auth/customer/exchange { "idToken": "dev:demo-user:+84901234567" }
 */
import { Course, ItemKind, PrismaClient, StaffRole } from '@prisma/client';
import * as argon2 from 'argon2';
import { randomBytes } from 'crypto';

const prisma = new PrismaClient();
const secret = () => randomBytes(24).toString('base64url');

async function staff(email: string, name: string, isAdmin = false) {
  return prisma.staffUser.upsert({
    where: { email },
    update: {},
    create: { email, name, isAdmin, passwordHash: await argon2.hash('comi12345') },
  });
}

interface DemoRestaurant {
  slug: string;
  name: string;
  address: string;
  lat: number;
  lng: number;
  priceLevel: number;
  cuisineTags: string[];
  servesLunch: boolean;
  servesNhau: boolean;
  hours: [number, number][]; // [open, close] minutes, every day
  menu: { category: string; items: { name: string; price: number; course: Course; kind?: ItemKind; prep?: number; alcohol?: boolean; tags?: string[] }[] }[];
  tables: { code: string; seats: [number, number]; x: number; y: number; w?: number; h?: number; shape?: 'RECT' | 'ROUND' | 'BOOTH'; features?: string[] }[];
}

const restaurants: DemoRestaurant[] = [
  {
    slug: 'com-tam-van-phong',
    name: 'Cơm Tấm Văn Phòng',
    address: '12 Nguyễn Thị Minh Khai, Phường Bến Nghé, Quận 1, TP.HCM',
    lat: 10.7835,
    lng: 106.6992,
    priceLevel: 1,
    cuisineTags: ['com', 'vietnamese'],
    servesLunch: true,
    servesNhau: false,
    hours: [[600, 840], [1020, 1260]],
    menu: [
      {
        category: 'Cơm',
        items: [
          { name: 'Cơm tấm sườn bì chả', price: 55_000, course: 'MAIN', prep: 8 },
          { name: 'Cơm gà xối mỡ', price: 50_000, course: 'MAIN', prep: 10 },
          { name: 'Cơm chay thập cẩm', price: 45_000, course: 'MAIN', prep: 8, tags: ['vegetarian'] },
        ],
      },
      {
        category: 'Đồ uống',
        items: [
          { name: 'Trà đá', price: 5_000, course: 'DRINK', kind: 'DRINK', prep: 1 },
          { name: 'Nước sấu', price: 15_000, course: 'DRINK', kind: 'DRINK', prep: 2 },
        ],
      },
    ],
    tables: [
      { code: 'A1', seats: [1, 2], x: 1, y: 2 },
      { code: 'A2', seats: [1, 2], x: 4, y: 2 },
      { code: 'A3', seats: [2, 4], x: 7, y: 2, features: ['window'] },
      { code: 'B1', seats: [4, 6], x: 1, y: 6, w: 3, h: 2 },
      { code: 'B2', seats: [4, 6], x: 6, y: 6, w: 3, h: 2 },
    ],
  },
  {
    slug: 'quan-nhau-ba-con',
    name: 'Quán Nhậu Bà Con',
    address: '88 Lê Lai, Phường Bến Thành, Quận 1, TP.HCM',
    lat: 10.7699,
    lng: 106.6935,
    priceLevel: 2,
    cuisineTags: ['nhau', 'seafood', 'grill'],
    servesLunch: false,
    servesNhau: true,
    hours: [[960, 1440 + 60]], // 16:00 → 01:00
    menu: [
      {
        category: 'Mồi nhậu',
        items: [
          { name: 'Ốc hương rang muối', price: 120_000, course: 'STARTER', prep: 15 },
          { name: 'Gà nướng muối ớt', price: 180_000, course: 'MAIN', prep: 25, tags: ['spicy'] },
          { name: 'Lẩu thái hải sản', price: 290_000, course: 'MAIN', prep: 20, tags: ['spicy'] },
        ],
      },
      {
        category: 'Bia & nước',
        items: [
          { name: 'Bia Sài Gòn (thùng 24)', price: 360_000, course: 'DRINK', kind: 'DRINK', prep: 1, alcohol: true },
          { name: 'Bia Tiger', price: 22_000, course: 'DRINK', kind: 'DRINK', prep: 1, alcohol: true },
          { name: 'Đá viên (xô)', price: 10_000, course: 'DRINK', kind: 'DRINK', prep: 1 },
        ],
      },
    ],
    tables: [
      { code: 'T1', seats: [4, 6], x: 1, y: 1, w: 3, h: 2 },
      { code: 'T2', seats: [4, 6], x: 5, y: 1, w: 3, h: 2 },
      { code: 'T3', seats: [6, 10], x: 9, y: 1, w: 4, h: 2 },
      { code: 'T4', seats: [2, 4], x: 1, y: 5, shape: 'ROUND', features: ['outdoor'] },
      { code: 'VIP1', seats: [8, 16], x: 12, y: 6, w: 5, h: 3, features: ['private'] },
    ],
  },
];

async function main() {
  await staff('admin@comi.vn', 'comi Admin', true);
  const owner = await staff('owner@comi.vn', 'Chủ quán Demo');
  const cook = await staff('bep@comi.vn', 'Bếp Demo');

  for (const d of restaurants) {
    const existing = await prisma.restaurant.findUnique({ where: { slug: d.slug } });
    if (existing) {
      console.log(`skip ${d.slug} (exists)`);
      continue;
    }
    const r = await prisma.restaurant.create({
      data: {
        slug: d.slug,
        name: d.name,
        phone: '0901234567',
        address: d.address,
        provinceCode: '79',
        priceLevel: d.priceLevel,
        cuisineTags: d.cuisineTags,
        servesLunch: d.servesLunch,
        servesNhau: d.servesNhau,
        diningMinutes: d.servesLunch ? 45 : 120,
        allowTableChoice: d.servesNhau,
        status: 'ACTIVE',
        approvedAt: new Date(),
        members: {
          create: [
            { staffId: owner.id, role: StaffRole.OWNER },
            ...(d.servesLunch ? [{ staffId: cook.id, role: StaffRole.KITCHEN }] : []),
          ],
        },
        openingHours: {
          create: [0, 1, 2, 3, 4, 5, 6].flatMap((weekday) =>
            d.hours.map(([openMinute, closeMinute]) => ({ weekday, openMinute, closeMinute, lastOrderMinute: closeMinute - 30 })),
          ),
        },
      },
    });
    await prisma.$executeRaw`
      UPDATE "Restaurant" SET location = ST_SetSRID(ST_MakePoint(${d.lng}, ${d.lat}), 4326)::geography WHERE id = ${r.id}`;

    const area = await prisma.tableArea.create({ data: { restaurantId: r.id, name: 'Tầng trệt', gridCols: 20, gridRows: 12 } });
    await prisma.mapElement.createMany({
      data: [
        { areaId: area.id, type: 'ENTRANCE', label: 'Cửa', x: 18, y: 10, width: 2, height: 2 },
        { areaId: area.id, type: 'WINDOW', x: 0, y: 0, width: 20, height: 1 },
        { areaId: area.id, type: 'KITCHEN', label: 'Bếp', x: 16, y: 0, width: 4, height: 3 },
      ],
    });
    for (const t of d.tables) {
      await prisma.table.create({
        data: {
          restaurantId: r.id,
          areaId: area.id,
          code: t.code,
          minSeats: t.seats[0],
          maxSeats: t.seats[1],
          posX: t.x,
          posY: t.y,
          width: t.w ?? 2,
          height: t.h ?? 2,
          shape: t.shape ?? 'RECT',
          features: t.features ?? [],
          qrSecret: secret(),
        },
      });
    }

    for (const [ci, c] of d.menu.entries()) {
      const cat = await prisma.menuCategory.create({ data: { restaurantId: r.id, name: c.category, sortOrder: ci } });
      for (const [ii, it] of c.items.entries()) {
        await prisma.menuItem.create({
          data: {
            restaurantId: r.id,
            categoryId: cat.id,
            name: it.name,
            price: it.price,
            course: it.course,
            kind: it.kind ?? 'DISH',
            prepMinutes: it.prep ?? 15,
            isAlcohol: it.alcohol ?? false,
            tags: it.tags ?? [],
            sortOrder: ii,
          },
        });
      }
    }
    console.log(`seeded ${d.slug}`);
  }
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
