# No YouTube Shorts

Extension **WebExtension** pour **Microsoft Edge** et **Mozilla Firefox** qui bloque l'interface « Shorts » de YouTube et restaure l'affichage classique des vidéos.

[![Licence MIT](https://img.shields.io/badge/licence-MIT-red.svg)](LICENSE)

---

## Fonctionnalités

- 🚫 Redirige les URL `/shorts/*` vers les vidéos classiques `/watch?v=`
- 🧹 Masque les sections « Shorts » sur la page d'accueil et dans les résultats de recherche
- 📌 Supprime l'entrée « Shorts » de la barre de navigation latérale
- 🔌 Activable / désactivable en un clic depuis l'icône de l'extension
- 🔒 Aucune donnée collectée — 100 % local

## Structure du projet

```
no-youtube-shorts/
├── EDGE/                    # Extension Microsoft Edge (Manifest V3)
│   ├── manifest.json
│   ├── rules.json           # Règles declarativeNetRequest
│   ├── background.js        # Service worker
│   ├── content.js           # Script de contenu
│   ├── icons/
│   │   ├── icon.svg         # Source (générer les PNG avec scripts/generate-icons.sh)
│   │   ├── icon16.png
│   │   ├── icon48.png
│   │   └── icon128.png
│   └── popup/
│       ├── popup.html
│       ├── popup.css
│       └── popup.js
├── FIREFOX/                 # Extension Mozilla Firefox (Manifest V2)
│   ├── manifest.json
│   ├── background.js        # Script de fond (webNavigation)
│   ├── content.js
│   ├── icons/
│   └── popup/
├── PWA/                     # Application web progressive complémentaire
│   ├── index.html
│   ├── manifest.json
│   ├── service-worker.js
│   ├── icon.svg
│   └── css/style.css
├── scripts/
│   ├── generate-icons.sh    # Génère les PNG à partir de icon.svg
│   ├── package-edge.sh      # Crée dist/no-youtube-shorts-edge.zip
│   └── package-firefox.sh   # Crée dist/no-youtube-shorts-firefox.zip
├── package.json
├── .gitignore
└── LICENSE
```

## Prérequis

- **Pour générer les icônes** : `rsvg-convert` (paquet `librsvg2-bin`) ou `convert` (ImageMagick)
- **Pour packager** : `zip`
- **Pour les scripts npm** : Node.js ≥ 16

## Génération des icônes PNG

Les icônes PNG (non versionnées) doivent être générées depuis le SVG source avant de pouvoir charger l'extension ou la packager :

```bash
./scripts/generate-icons.sh
# ou
npm run generate-icons
```

## Installation en mode développement

### Microsoft Edge

1. Ouvrez `edge://extensions/`
2. Activez le **Mode développeur** (coin supérieur droit)
3. Cliquez sur **Charger l'extension décompressée**
4. Sélectionnez le dossier `EDGE/`

### Mozilla Firefox

1. Ouvrez `about:debugging#/runtime/this-firefox`
2. Cliquez sur **Charger un module complémentaire temporaire…**
3. Sélectionnez le fichier `FIREFOX/manifest.json`

## Packaging

```bash
# Générer les icônes (une seule fois)
./scripts/generate-icons.sh

# Packager pour Edge → dist/no-youtube-shorts-edge.zip
./scripts/package-edge.sh

# Packager pour Firefox → dist/no-youtube-shorts-firefox.zip
./scripts/package-firefox.sh

# Les deux d'un coup (via npm)
npm run package:all
```

Le fichier Firefox `.zip` peut être renommé en `.xpi` pour soumission sur [addons.mozilla.org](https://addons.mozilla.org/).

## Compatibilité navigateurs

| Navigateur | Version minimale | Manifest | Méthode de redirection |
|---|---|---|---|
| Microsoft Edge | 88 | V3 | `declarativeNetRequest` |
| Mozilla Firefox | 58 | V2 | `webNavigation` + `tabs.update` |

## PWA

Le dossier `PWA/` contient une application web progressive complémentaire (page de présentation installable). Elle peut être hébergée sur n'importe quel serveur web statique (GitHub Pages, Netlify, etc.).

## Licence

[MIT](LICENSE) — © 2026 editeurcc
