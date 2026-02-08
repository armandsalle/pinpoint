# Pinpoint

Copy file path + line number references to your clipboard from VS Code.

## Output format

- Cursor on line 5: `src/index.ts#L5`
- Selection from line 5 to 12: `src/index.ts#L5-L12`

## Usage

1. Place your cursor on a line (or select a range)
2. Trigger via:
   - **Keybinding**: `Cmd+Alt+L` (macOS) / `Ctrl+Alt+L` (Windows/Linux)
   - **Context menu**: right-click in editor
   - **Command palette**: `Pinpoint: Copy File Reference`

The reference is copied to your clipboard and confirmed in the status bar.

## Install

### From GitHub Releases

Download the `.vsix` from the [latest release](https://github.com/armandsalle/pinpoint/releases/latest), then:

```bash
code --install-extension pinpoint-*.vsix
```

### From source

```bash
git clone https://github.com/armandsalle/pinpoint.git
cd pinpoint
pnpm install
pnpm run package
code --install-extension pinpoint-*.vsix
```

## Development

```bash
pnpm install
pnpm run watch
```

Press `F5` in VS Code to launch the Extension Development Host.

| Script | Description |
|---|---|
| `pnpm run compile` | Production build (minified, no sourcemaps) |
| `pnpm run watch` | Dev build with file watching and sourcemaps |
| `pnpm run package` | Create `.vsix` package |

### Project structure

```
src/extension.ts   # Single source file — registers the pinpoint.copy command
esbuild.js         # Build config (bundles to dist/extension.js as CJS)
scripts/release.sh # Automated release script
```

## Release

Releases are published as GitHub Releases with the `.vsix` attached.

```bash
# 1. Document changes in CHANGELOG.md under [Unreleased]
# 2. Run:
./scripts/release.sh patch   # or minor / major
```

See [CHANGELOG.md](CHANGELOG.md) for version history.

## License

MIT
