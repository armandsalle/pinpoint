# Publier Pinpoint sur le VS Code Marketplace

## Prérequis

1. **Compte Azure DevOps** → https://dev.azure.com (connexion Microsoft)
2. **Personal Access Token (PAT)** :
   - User settings → Personal access tokens → New Token
   - Organization : **All accessible organizations**
   - Scopes : **Marketplace > Manage**
   - Copier le token immédiatement
3. **Publisher** → https://marketplace.visualstudio.com/manage
   - Publisher ID doit correspondre au champ `publisher` dans package.json (`"armand"`)

## Avant publication

Ajouter dans `package.json` :
- `repository` : `https://github.com/armandsalle/pinpoint`
- `keywords` : `["copy", "path", "line-number", "clipboard", "reference"]`

## Publication

```bash
npx vsce login armand
npx vsce publish --no-dependencies
```

## Vérification

Extension visible sur `https://marketplace.visualstudio.com/items?itemName=armand.pinpoint`
