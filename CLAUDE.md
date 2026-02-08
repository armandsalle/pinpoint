# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Pinpoint is a VS Code extension that copies file path + line number references to clipboard (e.g. `src/index.ts#L5` or `src/index.ts#L5-L12`).

## Commands

- `pnpm run compile` — production build (esbuild, minified, no sourcemaps)
- `pnpm run watch` — dev build with watch mode (sourcemaps enabled)
- `pnpm run package` — create `.vsix` package for local install / publishing

No test runner is configured.

## Architecture

Single-file extension: `src/extension.ts` is the only source file. It registers one command (`pinpoint.copy`) that reads the active editor's selection and copies a GitHub-style file reference to the clipboard.

Build uses esbuild directly via `esbuild.js` (not a plugin/config file). Output goes to `dist/extension.js` as CommonJS, targeting Node 16. The `vscode` module is externalized.

### Key files

| File | Role |
|---|---|
| `src/extension.ts` | Extension entry point — `activate()` / `deactivate()` |
| `esbuild.js` | Build script (compile + watch modes) |
| `package.json` | Extension manifest (commands, keybindings, menus) |
| `scripts/release.sh` | Automated release script |
| `.github/workflows/release.yml` | CI: build + GitHub Release on tag push |

## Release procedure

Releases are automated via `scripts/release.sh` and GitHub Actions.

### Automated release (recommended)

```bash
# 1. Add changes under [Unreleased] in CHANGELOG.md
# 2. Run the release script
./scripts/release.sh patch   # or minor / major
```

The script will:
1. Verify clean working tree on `main`
2. Check that `[Unreleased]` in CHANGELOG.md has content
3. Bump version in `package.json`
4. Update CHANGELOG.md (move `[Unreleased]` content to new version heading)
5. Commit, tag, and push

GitHub Actions (`.github/workflows/release.yml`) then builds the `.vsix` and creates a GitHub Release with the changelog as body.

### Manual release

1. Update CHANGELOG.md — rename `[Unreleased]` to `[x.y.z] - YYYY-MM-DD`, add new empty `[Unreleased]`
2. Bump `version` in `package.json`
3. `git commit -am "release: vX.Y.Z"`
4. `pnpm run release` (tags and pushes)

### Conventions

- **Commits**: `feat:`, `fix:`, `chore:`, `release: vX.Y.Z`
- **Changelog**: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format — sections: Added, Changed, Fixed, Removed
- **Tags**: `vX.Y.Z` (semver with `v` prefix)
- **Changelog entries** go under `[Unreleased]` during development, then get moved to a versioned heading at release time

## Publishing (VS Code Marketplace)

Not yet published. See `PUBLISH.md` for marketplace instructions when ready.
