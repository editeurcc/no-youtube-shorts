'use strict';

// Set default enabled state on first install
browser.runtime.onInstalled.addListener(() => {
  browser.storage.local.get(['enabled']).then((result) => {
    if (result.enabled === undefined) {
      browser.storage.local.set({ enabled: true });
    }
  });
});

// Redirect /shorts/* → /watch?v= at the network level (before the page loads)
browser.webNavigation.onBeforeNavigate.addListener(
  async (details) => {
    // Only act when the extension is enabled
    const result = await browser.storage.local.get(['enabled']);
    if (result.enabled === false) return;

    const url = new URL(details.url);
    if (!url.pathname.startsWith('/shorts/')) return;

    const videoId = url.pathname.replace('/shorts/', '').split('/')[0];
    const t = url.searchParams.get('t');
    let redirectUrl = `https://www.youtube.com/watch?v=${videoId}`;
    if (t) redirectUrl += `&t=${encodeURIComponent(t)}`;

    browser.tabs.update(details.tabId, { url: redirectUrl });
  },
  {
    url: [
      { hostSuffix: 'youtube.com', pathPrefix: '/shorts/' },
    ],
  }
);
