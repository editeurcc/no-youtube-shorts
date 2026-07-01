Paquet final et portabilité

Fichiers créés dans le projet :

- `NO-YOUTUBE-SHORTS-GUI-FIREFOX.xpi` (XPI non signé généré)
- `NO-YOUTUBE-SHORTS-GUI-ICON.zip` (archive EDGE + FIREFOX)
- `install_firefox_policies.ps1` (script pour installation persistante, à exécuter en Admin)
- `policies.json` (exemple pour installation locale)

Portabilité vers un autre PC

- Si l’`.xpi` est signé via AMO : copie l’`.xpi` signé sur l’autre PC et installe par glisser‑dépose → fonctionnera et restera active après redémarrage.
- Si l’`.xpi` n’est pas signé : sur Firefox Release elle peut être bloquée ou désactivée au redémarrage ; sur d’autres PC tu peux :
  - utiliser Firefox Developer/Nightly (permet installations non signées persistantes),
  - installer temporairement via `about:debugging` (ne persiste pas),
  - ou utiliser la méthode `policies.json` (requiert droits admin sur la machine cible).

Je peux maintenant :

- Générer automatiquement les captures d’écran (1280x720) du popup si tu veux que je les produise à partir du `popup.html` (nécessite un navigateur headless).
- Préparer le texte de description pour AMO et les champs (short/long description, catégories, tags).
- Lancer la procédure pour regrouper tout dans un ZIP prêt à téléverser.

Dis exactement ce que tu veux que je prépare ensuite.
