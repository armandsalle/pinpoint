#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/release.sh <patch|minor|major>

BUMP_TYPE="${1:-}"

if [[ ! "$BUMP_TYPE" =~ ^(patch|minor|major)$ ]]; then
  echo "Usage: ./scripts/release.sh <patch|minor|major>"
  exit 1
fi

# Must be on main
BRANCH=$(git branch --show-current)
if [[ "$BRANCH" != "main" ]]; then
  echo "Error: must be on main branch (currently on '$BRANCH')"
  exit 1
fi

# Working tree must be clean
if [[ -n "$(git status --porcelain)" ]]; then
  echo "Error: working tree is not clean"
  git status --short
  exit 1
fi

# Verify changelog has unreleased content
UNRELEASED_CONTENT=$(awk '
  /^## \[Unreleased\]/ { found=1; next }
  /^## \[/ { if (found) exit }
  found && /\S/ { has_content=1 }
  END { print (has_content ? "yes" : "no") }
' CHANGELOG.md)

if [[ "$UNRELEASED_CONTENT" != "yes" ]]; then
  echo "Error: CHANGELOG.md [Unreleased] section is empty"
  exit 1
fi

# Bump version (updates package.json only, no git tag)
pnpm version "$BUMP_TYPE" --no-git-tag-version

VERSION=$(node -p "require('./package.json').version")
DATE=$(date +%Y-%m-%d)

echo "Releasing v$VERSION ($DATE)..."

# Update CHANGELOG.md: replace [Unreleased] heading, add new empty one
sed -i '' "s/^## \[Unreleased\]/## [Unreleased]\n\n## [$VERSION] - $DATE/" CHANGELOG.md

# Commit, tag, push
git add package.json CHANGELOG.md
git commit -m "release: v$VERSION"
git tag "v$VERSION"
git push origin main
git push origin "v$VERSION"

echo "Done! v$VERSION tagged and pushed. GitHub Actions will create the release."
