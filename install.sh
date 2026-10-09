#!/usr/bin/env bash
set -e

echo "Installation des dotfiles..."

# Vérifier stow
command -v stow >/dev/null 2>&1 || {
  echo "Stow n'est pas installé"
  exit 1
}

cd "$(dirname "$0")"

for pkg in nvim tmux fish ghostty mise; do
  echo "→ Stow $pkg"
  stow -v "$pkg"
done

echo "Terminé. Pensez à définir fish comme shell par défaut :"
echo "  chsh -s \$(which fish)"
