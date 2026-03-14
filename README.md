# resizeImg

Utilitaire macOS pour redimensionner et convertir des images en WebP par lot, via des dialogues Finder natifs.

## À propos

`resizeImg` permet de sélectionner une ou plusieurs images depuis le Finder, de choisir une largeur cible et un mode de compression (lossless ou lossy à 75%), puis exporte le tout en `.webp` dans un dossier `resize-output/` situé à côté des fichiers source.

## Prérequis

- macOS
- [Homebrew](https://brew.sh)
- Le paquet `webp` (fournit `cwebp` et `dwebp`) :

```bash
brew install webp
```

## Installation

Cloner le dépôt :

```bash
git clone https://github.com/TON_USER/resizeImg.git
```

Copier le script dans un répertoire du `PATH` :

```bash
mkdir -p ~/.local/bin
cp resizeImg/resizeImg.sh ~/.local/bin/resizeImg
chmod +x ~/.local/bin/resizeImg
```

Si `~/.local/bin` n'est pas dans le `PATH`, l'ajouter :

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Utilisation

```bash
resizeImg
```

1. Un dialogue Finder s'ouvre pour sélectionner une ou plusieurs images
2. Saisir la largeur cible en pixels
3. Choisir le mode de compression : **Lossless** ou **Lossy (75%)**
4. Les fichiers `.webp` sont générés dans un dossier `resize-output/` à côté des originaux

Le dossier de sortie s'ouvre automatiquement dans le Finder une fois le traitement terminé.

## Formats supportés

| Direction | Formats |
|-----------|---------|
| Entrée | Tout format reconnu par macOS (PNG, JPEG, TIFF, HEIC, WebP…) |
| Sortie | WebP |

## Licence

Ce projet est distribué sous une licence personnalisée **No Derivatives**. L'utilisation du logiciel tel quel est libre, mais toute modification et redistribution de versions modifiées sont interdites. Voir [LICENSE](LICENSE) pour les détails.
