# Changelog

All notable changes to Pinpoint will be documented in this file.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [0.1.1] - 2025-05-01

### Changed
- Updated keybinding for file path copying
- Added `@vscode/vsce` as dev dependency
- Added `pnpm-lock.yaml` to `.vscodeignore`

## [0.1.0] - 2025-05-01

### Added
- Initial release
- Copy file path with line number to clipboard (`src/index.ts#L5`)
- Copy file path with line range for selections (`src/index.ts#L5-L12`)
- Keyboard shortcut: `Cmd+Alt+L` (macOS) / `Ctrl+Alt+L` (Windows/Linux)
- Editor context menu integration
