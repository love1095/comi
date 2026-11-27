import { dietaryTags } from './dietary';

describe('dietaryTags', () => {
  it('maps tourist filters to the tags restaurants use, ignores unknown', () => {
    expect(dietaryTags('vegetarian, halal,keto')).toEqual(['chay', 'halal']);
    expect(dietaryTags(undefined)).toEqual([]);
  });
});
