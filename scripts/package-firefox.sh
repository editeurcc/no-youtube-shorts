#!/usr/bin/env bash
# package-firefox.sh – Package the FIREFOX extension into a distributable ZIP.
#
# Output: dist/no-youtube-shorts-firefox.zip
#
# For submission to AMO (addons.mozilla.org) the .zip can be renamed to .xpi.
#
# Usage:
#   ./scripts/package-firefox.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
FIREFOX_DIR="$ROOT_DIR/FIREFOX"
DIST_DIR="$ROOT_DIR/dist"
OUTPUT="$DIST_DIR/no-youtube-shorts-firefox.zip"

# Ensure PNG icons exist
for SIZE in 16 48 128; do
  if [ ! -f "$FIREFOX_DIR/icons/icon${SIZE}.png" ]; then
    echo "⚠️   Icônes PNG manquantes. Exécutez d'abord : ./scripts/generate-icons.sh"
    exit 1
  fi
done

mkdir -p "$DIST_DIR"
rm -f "$OUTPUT"

cd "$FIREFOX_DIR"
zip -r "$OUTPUT" . \
  --exclude "*.DS_Store" \
  --exclude "__MACOSX/*" \
  --exclude "*.map"

echo "✅  Extension Firefox packagée : $OUTPUT"
