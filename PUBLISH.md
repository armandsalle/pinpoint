# Publishing to VS Code Marketplace

For the release workflow (GitHub Releases + `.vsix` downloads), see `CLAUDE.md` > Release procedure.

## Marketplace publishing (when ready)

### Prerequisites

1. **Azure DevOps account** — https://dev.azure.com
2. **Personal Access Token (PAT)**: User settings > Personal access tokens > New Token
   - Organization: **All accessible organizations**
   - Scopes: **Marketplace > Manage**
3. **Publisher** registered at https://marketplace.visualstudio.com/manage (ID: `armand`)

### Publish

```bash
npx vsce login armand
npx vsce publish --no-dependencies
```

### Verify

Extension visible at `https://marketplace.visualstudio.com/items?itemName=armand.pinpoint`
