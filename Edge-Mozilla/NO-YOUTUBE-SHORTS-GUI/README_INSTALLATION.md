README — Installation (NO-YOUTUBE-SHORTS-GUI)

But

- Installer localement l’extension pour masquer Shorts/Stories/Reels sur YouTube.

Prérequis

- Navigateur : Edge, Chrome, Brave, Opera (Chromium) ou Firefox.
- Fichiers disponibles dans le dossier `NO-YOUTUBE-SHORTS-GUI` (EDGE/ et FIREFOX/).

Décompresser l’archive (optionnel)

- Avec l’explorateur Windows : clic droit → "Extraire tout..." → choisir un dossier.
- En PowerShell :

```powershell
Expand-Archive -Path .\NO-YOUTUBE-SHORTS-GUI.zip -DestinationPath .\NO-YOUTUBE-SHORTS-GUI -Force
```

Installation — Edge / Chrome / Brave / Opera (chargement local)

1. Ouvrez la page des extensions : `chrome://extensions` (ou Menu → Extensions).
2. Activez **Mode développeur** (coin supérieur droit).
3. Cliquez sur **Charger l’extension non empaquetée** / **Load unpacked**.
4. Sélectionnez le dossier `NO-YOUTUBE-SHORTS-GUI/EDGE` et validez.
5. L’extension apparaît dans la barre d’outils ; cliquez sur l’icône pour ouvrir la popup.

Installation — Firefox (chargement temporaire)

1. Ouvrez : `about:debugging#/runtime/this-firefox`.
2. Cliquez sur **Charger un module complémentaire temporaire**.
3. Choisissez `NO-YOUTUBE-SHORTS-GUI/FIREFOX/manifest.json`.
4. L’extension est chargée pour la session courante (sera retirée au redémarrage).

Remarques

- Firefox : pour une installation permanente, il faut empaqueter/signature via AMO (Mozilla) ou charger via un profil d’extension.
- Aucune donnée n’est envoyée à l’extérieur : les préférences sont stockées localement via l’API `storage`.

Utilisation après installation

1. Ouvrez YouTube.
2. Cliquez sur l’icône de l’extension (en haut à droite).
3. Cochez `Masquer les Shorts`, `Masquer les Stories` et/ou `Masquer les Reels` selon vos besoins.
4. Cliquez sur `Appliquer` pour enregistrer et appliquer immédiatement.
5. Pour remettre tout à zéro, cliquez `Réinitialiser`.
6. Si l’effet n’apparaît pas immédiatement, actualisez l’onglet YouTube.

Désinstallation

- Supprimez l’extension depuis la page des extensions du navigateur (menu contextuel → Supprimer/Retirer).

Dépannage rapide

- L’extension doit être activée et autorisée sur `youtube.com`.
- Si rien ne change, vérifiez que vous êtes sur un domaine `youtube.com` (pas YouTube TV).
- En cas d’erreur, recharger l’onglet YouTube ou redémarrer le navigateur.

Contact

- Usage personnel/familial uniquement — pas de distribution publique prévue.
