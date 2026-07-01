Checklist et étapes pour soumettre sur addons.mozilla.org (AMO)

1. Compte développeur

- Crée un compte sur https://addons.mozilla.org/ et connecte‑toi au Developer Hub.

2. Préparer l’archive

- L’`.xpi` doit contenir au minimum : `manifest.json`, scripts (`content.js`, `popup.js`), pages (`popup.html`) et icônes (16/32/48/128).
- Vérifie que `manifest.json` contient `name`, `version`, `description`, `manifest_version` et les permissions minimales.
- Vérifie qu’il n’y a pas de fichiers temporaires inutiles.

3. Checklist qualité

- Version semver correcte (`1.0.0` ou `1.0`).
- Description claire et courte.
- Icônes nettes (au moins `128x128` pour la fiche AMO).
- Screenshots (PNG) montrant le panneau/POPUP si pertinent.
- Politique de confidentialité si l’extension collecte des données utilisateur (même localStorage peut nécessiter note).
- Licence/URL de support (facultatif mais recommandé).

4. Téléversement

- Dans Developer Hub → Submit a new add‑on → téléverse ton `.xpi`.
- Choisis “unlisted” si tu veux un accès privé/rapide (toujours signé par Mozilla mais non listé publiquement).
- L’outil d’AMO affichera les erreurs ou avertissements (corrige si besoin).
- Une fois signé, télécharge la version signée et installe‑la sur d’autres machines.

5. Après signature

- Un XPI signé par AMO s’installe normalement sur Firefox Release et restera actif après redémarrage.
- Conserver la version signée pour distribution aux autres PC.

6. Conseils pratiques

- Si AMO renvoie un refus, lis le rapport et corrige les problèmes signalés (souvent permissions trop larges, contenu dangereux, ou fichiers manquants).
- Tu peux proposer l’extension en mode "unlisted" si tu veux la partager sans la publier publiquement.

Si tu veux, je peux préparer :

- un paquet ZIP prêt à téléverser (conserverai l'`.xpi` et les captures),
- et un court texte de description optimisé pour AMO que tu pourras copier/coller lors de la soumission.
  Dis si tu veux que je le fasse.
