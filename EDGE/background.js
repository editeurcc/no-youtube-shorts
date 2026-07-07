'use strict';

// Set default enabled state on first install
chrome.runtime.onInstalled.addListener(() => {
  chrome.storage.local.get(['enabled'], (result) => {
    if (result.enabled === undefined) {
      chrome.storage.local.set({ enabled: true });
    }
  });
});

// Sync the declarativeNetRequest ruleset when the enabled flag changes
chrome.storage.onChanged.addListener((changes, areaName) => {
  if (areaName !== 'local' || !('enabled' in changes)) return;

  const enabled = changes.enabled.newValue;
  chrome.declarativeNetRequest.updateEnabledRulesets({
    enableRulesetIds: enabled ? ['ruleset_shorts'] : [],
    disableRulesetIds: enabled ? [] : ['ruleset_shorts'],
  });
});
