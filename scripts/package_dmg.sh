#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
APP_NAME="CPasteBar"
OUTPUTS="$ROOT/outputs"
APP="$OUTPUTS/$APP_NAME.app"
DMG_ROOT="$ROOT/work/dmg-root"
DMG="$OUTPUTS/$APP_NAME.dmg"

"$ROOT/scripts/build_app.sh"

rm -rf "$DMG_ROOT"
mkdir -p "$DMG_ROOT"
cp -R "$APP" "$DMG_ROOT/$APP_NAME.app"
ln -s /Applications "$DMG_ROOT/Applications"

rm -f "$DMG"
hdiutil create \
  -volname "$APP_NAME" \
  -srcfolder "$DMG_ROOT" \
  -ov \
  -format UDZO \
  "$DMG"

echo "$DMG"
