import { validateOpeningHours } from './restaurants.service';
import { validateOptionGroups } from '../menu/menu.service';
import { checkPhotoRules } from '../media/media.service';

describe('opening hours validation', () => {
  it('accepts lunch + evening split and after-midnight close', () => {
    expect(() =>
      validateOpeningHours([
        { weekday: 1, openMinute: 600, closeMinute: 840 },
        { weekday: 1, openMinute: 1020, closeMinute: 1560, lastOrderMinute: 1500 }, // 17:00 → 02:00
      ]),
    ).not.toThrow();
  });

  it('rejects overlap on the same day', () => {
    expect(() =>
      validateOpeningHours([
        { weekday: 2, openMinute: 600, closeMinute: 900 },
        { weekday: 2, openMinute: 840, closeMinute: 1200 },
      ]),
    ).toThrow('Opening hours overlap');
  });

  it('rejects close before open and last order outside hours', () => {
    expect(() => validateOpeningHours([{ weekday: 0, openMinute: 600, closeMinute: 600 }])).toThrow();
    expect(() => validateOpeningHours([{ weekday: 0, openMinute: 600, closeMinute: 800, lastOrderMinute: 900 }])).toThrow();
  });
});

describe('option groups validation', () => {
  it('requires min ≤ max ≤ number of options', () => {
    expect(() => validateOptionGroups([{ name: 'Size', minSelect: 1, maxSelect: 1, options: [{ name: 'S' }, { name: 'L' }] }])).not.toThrow();
    expect(() => validateOptionGroups([{ name: 'Size', minSelect: 2, maxSelect: 1, options: [{ name: 'S' }, { name: 'L' }] }])).toThrow();
    expect(() => validateOptionGroups([{ name: 'Topping', maxSelect: 3, options: [{ name: 'Egg' }] }])).toThrow();
  });
});

describe('photo rules (§16.2)', () => {
  it('dish photos must be 4:3 and at least 1200×900', () => {
    expect(() => checkPhotoRules('menu_item', 1600, 1200)).not.toThrow();
    expect(() => checkPhotoRules('menu_item', 1000, 750)).toThrow('at least');
    expect(() => checkPhotoRules('menu_item', 1920, 1080)).toThrow('aspect ratio');
  });

  it('covers must be 16:9', () => {
    expect(() => checkPhotoRules('cover', 1920, 1080)).not.toThrow();
    expect(() => checkPhotoRules('cover', 1600, 1200)).toThrow();
  });
});
