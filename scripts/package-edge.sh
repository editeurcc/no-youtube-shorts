#!/usr/bin/env bash
# package-edge.sh – Package the EDGE extension into a distributable ZIP.
#
# Output: dist/no-youtube-shorts-edge.zip
#
# Usage:
#   ./scripts/package-edge.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
EDGE_DIR="$ROOT_DIR/EDGE"
DIST_DIR="$ROOT_DIR/dist"
OUTPUT="$DIST_DIR/no-youtube-shorts-edge.zip"

# Ensure PNG icons exist
for SIZE in 16 48 128; do
  if [ ! -f "$EDGE_DIR/icons/icon${SIZE}.png" ]; then
    echo "⚠️   Icônes PNG manquantes. Exécutez d'abord : ./scripts/generate-icons.sh"
    exit 1
  fi
done

mkdir -p "$DIST_DIR"
rm -f "$OUTPUT"

cd "$EDGE_DIR"
zip -r "$OUTPUT" . \
  --exclude "*.DS_Store" \
  --exclude "__MACOSX/*" \
  --exclude "*.map"

echo "✅  Extension Edge packagée : $OUTPUT"
