/** Tourist dietary filters → menu item tags (Vietnamese tags restaurants already use). */
export const DIETARY_TAGS: Record<string, string> = { vegetarian: 'chay', halal: 'halal', no_pork: 'không heo', gluten_free: 'không gluten' };

export function dietaryTags(q?: string): string[] {
  return (q ?? '')
    .split(',')
    .map((s) => DIETARY_TAGS[s.trim()])
    .filter((t): t is string => !!t);
}
