// No YouTube Shorts - EDGE content script (Manifest V3)
// Reads options from chrome.storage and hides elements matching patterns.

const DEFAULTS = { hideShorts: false, hideStories: false, hideReels: false };
let options = { ...DEFAULTS };

function isWatchUrl(href) {
  return href && href.includes('/watch');
}

function matchesShorts(href) {
  return href && /\/shorts\//.test(href);
}
function matchesStories(href) {
  return href && /\/stories\//.test(href);
}
function matchesReels(href) {
  return href && /\/reel(s)?\//.test(href);
}

function hideElement(el) {
  if (!el) return;
  if (el.style && el.dataset && el.dataset.noshortsHidden) return;
  const prev = el.style.display;
  el.dataset.noshortsPrevDisplay = prev === undefined ? '' : prev;
  el.style.display = 'none';
  el.dataset.noshortsHidden = '1';
}

function restoreElement(el) {
  if (!el || !el.dataset || !el.dataset.noshortsHidden) return;
  el.style.display = el.dataset.noshortsPrevDisplay || '';
  delete el.dataset.noshortsHidden;
  delete el.dataset.noshortsPrevDisplay;
}

function findClosestContainer(a) {
  if (!a) return null;
  const selectors = [
    'ytd-rich-item-renderer',
    'ytd-rich-grid-media',
    'ytd-grid-video-renderer',
    'ytd-video-renderer',
    'ytd-compact-video-renderer',
    'div#thumbnail' // fallback
  ];
  for (const s of selectors) {
    const c = a.closest(s);
    if (c) return c;
  }
  return a.closest('div');
}

function applyHiding() {
  // First, restore everything then re-hide according to options
  document.querySelectorAll('[data-noshorts-hidden]').forEach(el => restoreElement(el));

  // Find anchors on the page and hide their containers when matching patterns
  const anchors = Array.from(document.querySelectorAll('a[href]'));
  for (const a of anchors) {
    const href = a.getAttribute('href');
    if (!href) continue;
    // ignore watch links (normal videos)
    if (isWatchUrl(href)) continue;
    const container = findClosestContainer(a);
    if (!container) continue;
    if (options.hideShorts && matchesShorts(href)) {
      hideElement(container);
      continue;
    }
    if (options.hideStories && matchesStories(href)) {
      hideElement(container);
      continue;
    }
    if (options.hideReels && matchesReels(href)) {
      hideElement(container);
      continue;
    }
  }
}

// Observe mutations to hide newly inserted items
const observer = new MutationObserver((mutations) => {
  // small debounce
  applyHiding();
});

function startObserving() {
  observer.observe(document.documentElement || document.body, { childList: true, subtree: true });
}

function stopObserving() {
  try { observer.disconnect(); } catch (e) {}
}

// Load options from storage and apply
function loadOptionsAndApply() {
  chrome.storage.sync.get(DEFAULTS, (items) => {
    options = {
      hideShorts: !!items.hideShorts,
      hideStories: !!items.hideStories,
      hideReels: !!items.hideReels
    };
    applyHiding();
    startObserving();
  });
}

// respond to storage changes
chrome.storage.onChanged.addListener((changes, area) => {
  if (area !== 'sync') return;
  let changed = false;
  for (const k of Object.keys(changes)) {
    if (['hideShorts','hideStories','hideReels'].includes(k)) changed = true;
  }
  if (changed) loadOptionsAndApply();
});

// Also allow messages to trigger immediate apply (from popup)
chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
  if (msg && msg.action === 'apply') {
    loadOptionsAndApply();
  }
});

// init
loadOptionsAndApply();
