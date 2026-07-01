// Popup logic for Firefox (browser.*)
const hideShortsEl = document.getElementById('hideShorts');
const hideStoriesEl = document.getElementById('hideStories');
const hideReelsEl = document.getElementById('hideReels');
const applyBtn = document.getElementById('apply');
const resetBtn = document.getElementById('reset');

const DEFAULTS = { hideShorts: false, hideStories: false, hideReels: false };

function load() {
  browser.storage.local.get(DEFAULTS).then(items => {
    hideShortsEl.checked = !!items.hideShorts;
    hideStoriesEl.checked = !!items.hideStories;
    hideReelsEl.checked = !!items.hideReels;
  }).catch(()=>{});
}

function saveAndApply() {
  const data = {
    hideShorts: !!hideShortsEl.checked,
    hideStories: !!hideStoriesEl.checked,
    hideReels: !!hideReelsEl.checked
  };
  browser.storage.local.set(data).then(() => {
    browser.tabs.query({ active: true, currentWindow: true }).then((tabs) => {
      if (tabs && tabs[0]) browser.tabs.sendMessage(tabs[0].id, { action: 'apply' });
      window.close();
    });
  }).catch(()=>{});
}

function resetAll() {
  browser.storage.local.set(DEFAULTS).then(() => {
    hideShortsEl.checked = DEFAULTS.hideShorts;
    hideStoriesEl.checked = DEFAULTS.hideStories;
    hideReelsEl.checked = DEFAULTS.hideReels;
    browser.tabs.query({ active: true, currentWindow: true }).then((tabs) => {
      if (tabs && tabs[0]) browser.tabs.sendMessage(tabs[0].id, { action: 'apply' });
      window.close();
    });
  }).catch(()=>{});
}

applyBtn.addEventListener('click', saveAndApply);
resetBtn.addEventListener('click', resetAll);

load();
