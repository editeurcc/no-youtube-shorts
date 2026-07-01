#!/usr/bin/env bash
# generate-icons.sh – Convert icon.svg to PNG icons at required sizes.
#
# Requirements (one of):
#   - rsvg-convert  (librsvg2-bin on Debian/Ubuntu)
#   - convert       (ImageMagick)
#
# Usage:
#   ./scripts/generate-icons.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SVG_SOURCE="$ROOT_DIR/EDGE/icons/icon.svg"
SIZES=(16 48 128)

# Detect converter
if command -v rsvg-convert &> /dev/null; then
  CONVERTER="rsvg"
elif command -v convert &> /dev/null; then
  CONVERTER="imagemagick"
else
  echo "❌  Aucun convertisseur SVG trouvé."
  echo "    Installez rsvg-convert : sudo apt install librsvg2-bin"
  echo "    ou ImageMagick         : sudo apt install imagemagick"
  exit 1
fi

echo "🔧  Utilisation de : $CONVERTER"

for SIZE in "${SIZES[@]}"; do
  for BROWSER in EDGE FIREFOX; do
    DEST="$ROOT_DIR/$BROWSER/icons/icon${SIZE}.png"
    if [ "$CONVERTER" = "rsvg" ]; then
      rsvg-convert -w "$SIZE" -h "$SIZE" "$SVG_SOURCE" -o "$DEST"
    else
      convert -background none "$SVG_SOURCE" -resize "${SIZE}x${SIZE}" "$DEST"
    fi
  done
  echo "✅  ${SIZE}x${SIZE} générée (EDGE + FIREFOX)"
done

echo "🎉  Toutes les icônes ont été générées."
