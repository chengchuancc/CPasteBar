# CPasteBar

CPasteBar is a small native macOS menu bar clipboard history app inspired by Maccy.

## Features

- Watches the system clipboard every half second.
- Stores the latest 50 text snippets.
- Shows history from a menu bar icon.
- Opens a Win+V-style paste picker near the mouse with a configurable global shortcut.
- Supports copy, paste, and delete actions for each history item.
- Provides a Preferences window for language, shortcut, history capacity, and auto-paste behavior.
- Supports English, Simplified Chinese, German, Japanese, and French, with a System language option.
- Selecting a history item writes it back to the clipboard and sends `Command-V` to the previously active app.
- Persists history in `~/Library/Application Support/CPasteBar/history.json`.
- Includes a clear-history action.

## Build

```bash
./scripts/build_app.sh
```

The app bundle is written to `outputs/CPasteBar.app`.

## Package DMG

```bash
./scripts/package_dmg.sh
```

The DMG is written to `outputs/CPasteBar.dmg`.

## Run

```bash
open outputs/CPasteBar.app
```

For automatic pasting, macOS must grant Accessibility permission to CPasteBar. Open the menu bar icon and choose `Enable Auto Paste Permission...`, then enable CPasteBar in System Settings. Without this permission, selecting an item still copies it back to the clipboard, but macOS blocks the simulated paste shortcut.

## 中文说明

CPasteBar 是一个原生 macOS 菜单栏剪贴板历史工具。

- 自动记录最近复制的文字。
- 点击菜单栏图标查看历史。
- 每条历史右侧可以复制、粘贴或删除。
- 默认用 `Command-Shift-V` 在鼠标附近打开粘贴框。
- 在 `设置...` 中可以切换语言、快捷键、历史容量和自动粘贴行为。
- 如果开启自动粘贴，需要在系统设置中给 CPasteBar 授予“辅助功能”权限。

## License

MIT License. Copyright © 2026 chengchuan.
