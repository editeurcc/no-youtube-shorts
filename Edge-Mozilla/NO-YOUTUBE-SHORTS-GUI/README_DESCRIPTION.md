README — Description (NO-YOUTUBE-SHORTS-GUI)

Objectif

- Permettre de masquer, localement et à la demande, les contenus courts sur YouTube : **Shorts**, **Stories** et **Reels**.

Comportement

- Trois options contrôlables par l’utilisateur :
  - `Masquer les Shorts` : cache les éléments dont le lien contient `/shorts/`.
  - `Masquer les Stories` : cache les éléments dont le lien contient `/stories/`.
  - `Masquer les Reels` : cache les éléments dont le lien contient `/reel/` ou `/reels/`.
- Les vidéos normales (liens contenant `/watch`) ne sont jamais masquées.
- Rien n’est masqué automatiquement : seules les cases cochées déclenchent le masquage.
- Pas de support YouTube TV et pas d’options avancées.

Fonctionnement technique (bref)

- L’extension injecte un `content.js` qui parcourt les liens (`a[href]`) et masque leurs conteneurs s’ils correspondent aux motifs ci‑dessus.
- Un `MutationObserver` surveille la page pour appliquer les règles aux nouveaux éléments dynamiques.
- Les préférences sont conservées via l’API `storage` du navigateur (`chrome.storage` pour Chromium, `browser.storage` pour Firefox).

Structure du projet

- `EDGE/` : version Manifest V3 (Chrome/Edge/Brave/Opera)
  - `manifest.json`, `content.js`, `popup.html`, `popup.js`
- `FIREFOX/` : version Manifest V2 (Firefox)
  - `manifest.json`, `content.js`, `popup.html`, `popup.js`

Respect de la vie privée

- Aucun envoi de données externes.
- Les préférences sont stockées localement par le navigateur.

Usage recommandé

- Usage familial et personnel uniquement.
- Simple à activer/désactiver via la popup.

Si vous voulez

- Un PDF imprimable du guide d’installation.
- Que j’ajoute des captures d’écran pour les étapes.
- Que je prépare une version empaquetée (CRX/XPI) prête à installer.
