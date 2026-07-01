'use strict';

/* global chrome, browser */
const api = typeof browser !== 'undefined' ? browser : chrome;

const toggleBtn = document.getElementById('toggle-btn');
const statusDot = document.getElementById('status-dot');
const statusLabel = document.getElementById('status-label');

function renderState(enabled) {
  if (enabled) {
    statusDot.className = 'status-dot active';
    statusLabel.textContent = 'Actif';
    toggleBtn.textContent = 'Désactiver';
    toggleBtn.className = 'btn';
  } else {
    statusDot.className = 'status-dot';
    statusLabel.textContent = 'Inactif';
    toggleBtn.textContent = 'Activer';
    toggleBtn.className = 'btn enable';
  }
}

// Load saved state (default: enabled)
api.storage.local.get(['enabled'], (result) => {
  renderState(result.enabled !== false);
});

// Toggle on click
toggleBtn.addEventListener('click', () => {
  api.storage.local.get(['enabled'], (result) => {
    const newState = result.enabled === false; // flip
    api.storage.local.set({ enabled: newState }, () => {
      renderState(newState);
    });
  });
});
