Installation locale (test rapide

1. Tester sans signature (installation temporaire)

- Ouvre Firefox.
- Va sur la page `about:debugging#/runtime/this-firefox`.
- Clique sur “Load Temporary Add-on” (Charger un module complémentaire temporaire).
- Sélectionne `manifest.json` dans `NO-YOUTUBE-SHORTS-GUI/FIREFOX/`.
- L’extension est active pour la session en cours (disparaîtra au redémarrage).

2. Installer par glisser‑déposer (méthode utilisateur)

- Ouvre une page web dans Firefox (par ex. google.com).
- Glisse-dépose `NO-YOUTUBE-SHORTS-GUI-FIREFOX.xpi` sur la page.
- Confirme l’installation dans la boîte de dialogue.
- Remarque : sur Firefox Release, si l’`.xpi` n’est pas signé, Firefox peut afficher un message d’erreur ou désactiver l’extension au redémarrage.

3. Installation persistante (requiert droits Administrateur)

- Méthode pour un poste local : placer l’`.xpi` et `policies.json` dans `%ProgramFiles%\Mozilla Firefox\distribution\`.
- Exemple PowerShell à lancer en Administrateur :

```powershell
cd 'C:\Users\wios\Desktop\Projets.2026\Edge-Mozilla'
.\install_firefox_policies.ps1
```

- Redémarre Firefox.

4. Autres options

- Utiliser Firefox Developer Edition ou Nightly : accepte plus facilement des XPI non signés de façon persistante.
- Pour déploiement en entreprise, on peut pousser `policies.json` via GPO ou outils d’imagerie.

Si tu veux, je peux te guider en direct pendant que tu fais le glisser‑dépose ou l’exécution du script en admin.
