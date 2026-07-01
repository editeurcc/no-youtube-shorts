// Popup logic for Edge (chrome.*)
const hideShortsEl = document.getElementById('hideShorts');
const hideStoriesEl = document.getElementById('hideStories');
const hideReelsEl = document.getElementById('hideReels');
const applyBtn = document.getElementById('apply');
const resetBtn = document.getElementById('reset');

const DEFAULTS = { hideShorts: false, hideStories: false, hideReels: false };

function load() {
  chrome.storage.sync.get(DEFAULTS, (items) => {
    hideShortsEl.checked = !!items.hideShorts;
    hideStoriesEl.checked = !!items.hideStories;
    hideReelsEl.checked = !!items.hideReels;
  });
}

function saveAndApply() {
  const data = {
    hideShorts: !!hideShortsEl.checked,
    hideStories: !!hideStoriesEl.checked,
    hideReels: !!hideReelsEl.checked
  };
  chrome.storage.sync.set(data, () => {
    // notify current tab to reapply immediately
    chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
      if (tabs && tabs[0]) chrome.tabs.sendMessage(tabs[0].id, { action: 'apply' });
    });
    window.close();
  });
}

function resetAll() {
  chrome.storage.sync.set(DEFAULTS, () => {
    hideShortsEl.checked = DEFAULTS.hideShorts;
    hideStoriesEl.checked = DEFAULTS.hideStories;
    hideReelsEl.checked = DEFAULTS.hideReels;
    chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
      if (tabs && tabs[0]) chrome.tabs.sendMessage(tabs[0].id, { action: 'apply' });
    });
    window.close();
  });
}

applyBtn.addEventListener('click', saveAndApply);
resetBtn.addEventListener('click', resetAll);

load();
