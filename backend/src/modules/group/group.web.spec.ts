import { GroupWebController, groupPage } from './group.web';

describe('group join page', () => {
  it('embeds the token as a JS string and uses the nonce for script and style', () => {
    const html = groupPage('N0NCE', 'abcDEF_12-xyz');
    expect(html).toContain('var token = "abcDEF_12-xyz";');
    expect(html).toContain('<script nonce="N0NCE">');
    expect(html).toContain('<style nonce="N0NCE">');
    expect(html).not.toContain('innerHTML');
  });

  it('refuses tokens that are not base64url', () => {
    const res = { status: jest.fn().mockReturnThis(), type: jest.fn().mockReturnThis(), send: jest.fn().mockReturnThis(), setHeader: jest.fn().mockReturnThis() };
    new GroupWebController().page('</script><script>alert(1)</script>', res as never);
    expect(res.status).toHaveBeenCalledWith(404);
    new GroupWebController().page('abcDEF_12-xyz', res as never);
    expect(res.setHeader).toHaveBeenCalledWith('Content-Security-Policy', expect.stringContaining("script-src 'nonce-"));
  });
});
