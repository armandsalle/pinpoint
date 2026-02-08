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

Build uses esbuild directly via `esbuild.js` (not a plugin/config file). Output goes to `dist/extension.js` as CommonJS. The `vscode` module is externalized.

## Publishing

See `PUBLISH.md` for marketplace publishing steps. Uses `vsce` (via `@vscode/vsce` devDep). Publisher ID is `armand`.
