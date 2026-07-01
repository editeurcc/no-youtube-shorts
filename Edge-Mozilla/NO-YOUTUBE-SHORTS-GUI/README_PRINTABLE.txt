NO-YOUTUBE-SHORTS-GUI — Guide imprimable (texte simple)

But
Cette extension vous permet, localement et à la demande, de masquer les contenus courts sur YouTube : Shorts, Stories et Reels.

Résumé rapide
- Trois options : Masquer les Shorts / Masquer les Stories / Masquer les Reels.
- Les vidéos normales (liens contenant "/watch") ne sont jamais masquées.
- Les préférences sont stockées localement par le navigateur.
- Usage personnel/familial uniquement.

Installation (Chromium : Edge / Chrome / Brave / Opera)
1) Décompressez l’archive si besoin (facultatif).
   - PowerShell (optionnel) :

   Expand-Archive -Path .\NO-YOUTUBE-SHORTS-GUI.zip -DestinationPath .\NO-YOUTUBE-SHORTS-GUI -Force

2) Ouvrez la page des extensions : chrome://extensions
3) Activez « Mode développeur » (en haut à droite).
4) Cliquez sur « Charger l’extension non empaquetée » / Load unpacked.
5) Sélectionnez le dossier : NO-YOUTUBE-SHORTS-GUI/EDGE
6) L’extension apparaît ; cliquez sur son icône pour ouvrir la popup.

Installation (Firefox — chargement temporaire)
1) Ouvrez : about:debugging#/runtime/this-firefox
2) Cliquez sur « Charger un module complémentaire temporaire ».
3) Choisissez : NO-YOUTUBE-SHORTS-GUI/FIREFOX/manifest.json
4) L’extension est active pour la session (sera retirée au redémarrage).

Utilisation
1) Ouvrez YouTube (site classique, pas YouTube TV).
2) Cliquez sur l’icône de l’extension (barre d’outils).
3) Cochez les cases souhaitées : Masquer les Shorts / Stories / Reels.
4) Cliquez sur « Appliquer » pour sauvegarder et appliquer immédiatement.
5) Pour revenir à la configuration initiale, cliquez sur « Réinitialiser ».
6) Si rien ne change, actualisez l’onglet YouTube.

Comportement technique (en bref)
- Le script parcourt les liens (`a[href]`) et masque les conteneurs des éléments dont les liens correspondent à :
  - Shorts : "/shorts/"
  - Stories : "/stories/"
  - Reels : "/reel/" ou "/reels/"
- Un observateur (`MutationObserver`) applique les règles aux nouveaux éléments dynamiques.
- Les vidéos normales (`/watch`) sont explicitement ignorées.

Désinstallation
- Supprimez l’extension depuis la page des extensions de votre navigateur.

Dépannage rapide
- Vérifiez que l’extension est activée et que vous êtes bien sur `youtube.com`.
- Vérifiez d’avoir chargé la version appropriée (EDGE pour Chromium, FIREFOX pour Firefox).
- Sur Firefox, le chargement via `about:debugging` est temporaire.

Confidentialité
- Aucune donnée n’est envoyée à l’extérieur. Seules vos préférences sont stockées localement.

Si vous voulez
- Que je fournisse ce même guide avec captures d’écran (PNG) intégrées.
- Que je prépare un fichier CRX (Chromium) ou XPI (Firefox) empaqueté — dites lequel.

Fichiers clés (dans le dossier)
- NO-YOUTUBE-SHORTS-GUI/EDGE/*  (manifest.json, content.js, popup.html, popup.js)
- NO-YOUTUBE-SHORTS-GUI/FIREFOX/* (manifest.json, content.js, popup.html, popup.js)
- NO-YOUTUBE-SHORTS-GUI/README_INSTALLATION.md
- NO-YOUTUBE-SHORTS-GUI/README_DESCRIPTION.md

Usage conseillé
- Pour vous et votre famille uniquement. Ne pas distribuer sans validation.

Fin du guide imprimable.
