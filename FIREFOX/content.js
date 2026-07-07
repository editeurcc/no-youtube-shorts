'use strict';

/* global chrome */
const api = typeof browser !== 'undefined' ? browser : chrome;

// ---------------------------------------------------------------------------
// Redirect Shorts URLs to regular video watch pages
// (fallback for pages already loaded / SPA navigation)
// ---------------------------------------------------------------------------
function redirectShorts() {
  const path = window.location.pathname;
  if (!path.startsWith('/shorts/')) return;

  const videoId = path.replace('/shorts/', '').split('/')[0];
  const params = new URLSearchParams(window.location.search);
  const t = params.get('t');
  let url = `https://www.youtube.com/watch?v=${videoId}`;
  if (t) url += `&t=${encodeURIComponent(t)}`;
  window.location.replace(url);
}

// ---------------------------------------------------------------------------
// CSS injection – hide all Shorts-related UI elements
// ---------------------------------------------------------------------------
const STYLE_ID = 'no-youtube-shorts-style';

function injectCSS() {
  if (document.getElementById(STYLE_ID)) return;
  const style = document.createElement('style');
  style.id = STYLE_ID;
  style.textContent = `
    ytd-rich-shelf-renderer[is-shorts],
    ytd-reel-shelf-renderer,
    ytd-guide-entry-renderer:has(a[title="Shorts"]),
    ytd-mini-guide-entry-renderer:has(a[title="Shorts"]),
    a[href="/shorts"],
    yt-chip-cloud-chip-renderer:has(yt-formatted-string[title="Shorts"]) {
      display: none !important;
    }
  `;
  (document.head || document.documentElement).appendChild(style);
}

function removeCSS() {
  const style = document.getElementById(STYLE_ID);
  if (style) style.remove();
}

// ---------------------------------------------------------------------------
// DOM observer – clean up dynamically injected Shorts shelves
// ---------------------------------------------------------------------------
let observer = null;

function removeShortsShelves() {
  const selectors = [
    'ytd-rich-shelf-renderer[is-shorts]',
    'ytd-reel-shelf-renderer',
  ].join(', ');
  document.querySelectorAll(selectors).forEach((el) => el.remove());
}

function startObserver() {
  if (observer) return;
  observer = new MutationObserver(removeShortsShelves);
  observer.observe(document.documentElement, { childList: true, subtree: true });
}

function stopObserver() {
  if (observer) {
    observer.disconnect();
    observer = null;
  }
}

// ---------------------------------------------------------------------------
// Lifecycle
// ---------------------------------------------------------------------------
function enable() {
  redirectShorts();
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
      injectCSS();
      removeShortsShelves();
      startObserver();
    });
  } else {
    injectCSS();
    removeShortsShelves();
    startObserver();
  }
}

function disable() {
  stopObserver();
  removeCSS();
}

// Read current enabled state and initialise accordingly
api.storage.local.get(['enabled'], (result) => {
  if (result.enabled !== false) {
    enable();
  }
});

// React to popup toggle without reloading the page
api.storage.onChanged.addListener((changes) => {
  if (!('enabled' in changes)) return;
  if (changes.enabled.newValue) {
    enable();
  } else {
    disable();
  }
});
