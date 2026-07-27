#!/usr/bin/env bash
# ─────────────────────────────────────────
# install-cli-tools.sh
# Installation des outils CLI selon l'OS détecté
# Compatible : Arch Linux, Ubuntu/Debian, macOS
# ─────────────────────────────────────────

set -euo pipefail

# ─────────────────────────────────────────
# Couleurs pour les logs
# ─────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# ─────────────────────────────────────────
# Détection de l'OS
# ─────────────────────────────────────────
detect_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macos"
  elif [[ -f /etc/arch-release ]]; then
    echo "arch"
  elif [[ -f /etc/debian_version ]]; then
    echo "debian"
  else
    echo "unknown"
  fi
}

OS=$(detect_os)
log_info "OS détecté : $OS"

if [[ "$OS" == "unknown" ]]; then
  log_error "OS non supporté. Arrêt du script."
  exit 1
fi

# ─────────────────────────────────────────
# Installation selon l'OS
# ─────────────────────────────────────────

install_arch() {
  log_info "Mise à jour des paquets système..."
  sudo pacman -Syu --noconfirm

  log_info "Installation des paquets via pacman..."
  sudo pacman -S --needed --noconfirm \
    fish \
    git \
    neovim \
    tmux \
    stow \
    eza \
    bat \
    fd \
    fzf \
    zoxide \
    git-delta \
    lazygit \
    ripgrep \
    fastfetch \
    unzip \
    curl \
    wget

  # Oh-My-Posh (pas dans les repos officiels, via yay ou script)
  if ! command -v oh-my-posh >/dev/null 2>&1; then
    log_info "Installation de Oh-My-Posh..."
    if command -v yay >/dev/null 2>&1; then
      yay -S --noconfirm oh-my-posh-bin
    else
      curl -s https://ohmyposh.dev/install.sh | bash -s
    fi
  else
    log_info "Oh-My-Posh déjà installé"
  fi

  # Ghostty (AUR)
  if ! command -v ghostty >/dev/null 2>&1; then
    log_info "Installation de Ghostty..."
    if command -v yay >/dev/null 2>&1; then
      yay -S --noconfirm ghostty
    else
      log_warn "yay non trouvé, installez Ghostty manuellement : https://ghostty.org"
    fi
  else
    log_info "Ghostty déjà installé"
  fi
}

install_debian() {
  log_info "Mise à jour des paquets système..."
  sudo apt update && sudo apt upgrade -y

  log_info "Installation des paquets via apt..."
  sudo apt install -y \
    fish \
    git \
    neovim \
    tmux \
    stow \
    bat \
    fd-find \
    fzf \
    ripgrep \
    unzip \
    curl \
    wget \
    gpg

  # eza n'est pas toujours dans les repos Ubuntu par défaut
  if ! command -v eza >/dev/null 2>&1; then
    log_info "Installation de eza via le repo officiel..."
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc |
      sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" |
      sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
  else
    log_info "eza déjà installé"
  fi

  # zoxide (script officiel, pas toujours à jour dans apt)
  if ! command -v zoxide >/dev/null 2>&1; then
    log_info "Installation de zoxide..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
  else
    log_info "zoxide déjà installé"
  fi

  # git-delta (.deb direct, absent des repos Ubuntu LTS)
  if ! command -v delta >/dev/null 2>&1; then
    log_info "Installation de git-delta..."
    DELTA_VERSION="0.18.2"
    curl -Lo /tmp/delta.deb \
      "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb"
    sudo dpkg -i /tmp/delta.deb
    rm /tmp/delta.deb
  else
    log_info "git-delta déjà installé"
  fi

  # lazygit (absent des repos Ubuntu)
  if ! command -v lazygit >/dev/null 2>&1; then
    log_info "Installation de lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" |
      grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo /tmp/lazygit.tar.gz \
      "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
    sudo install /tmp/lazygit /usr/local/bin
    rm /tmp/lazygit /tmp/lazygit.tar.gz
  else
    log_info "lazygit déjà installé"
  fi

  # Oh-My-Posh
  if ! command -v oh-my-posh >/dev/null 2>&1; then
    log_info "Installation de Oh-My-Posh..."
    curl -s https://ohmyposh.dev/install.sh | bash -s
  else
    log_info "Oh-My-Posh déjà installé"
  fi

  # fastfetch (pas toujours dans les repos Ubuntu LTS)
  if ! command -v fastfetch >/dev/null 2>&1; then
    log_info "Installation de fastfetch..."
    sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch 2>/dev/null || true
    sudo apt update
    sudo apt install -y fastfetch
  else
    log_info "fastfetch déjà installé"
  fi

  log_warn "Ghostty : pas de .deb officiel pour Ubuntu, compilez depuis les sources si besoin (https://ghostty.org/docs/install/build)"
}

install_macos() {
  if ! command -v brew >/dev/null 2>&1; then
    log_info "Installation de Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    log_info "Homebrew déjà installé"
  fi

  log_info "Mise à jour de Homebrew..."
  brew update

  log_info "Installation des paquets via brew..."
  brew install \
    fish \
    git \
    neovim \
    tmux \
    stow \
    eza \
    bat \
    fd \
    fzf \
    zoxide \
    git-delta \
    lazygit \
    ripgrep \
    fastfetch \
    oh-my-posh

  log_info "Installation de Ghostty..."
  if ! command -v ghostty >/dev/null 2>&1; then
    brew install --cask ghostty
  else
    log_info "Ghostty déjà installé"
  fi
}

# ─────────────────────────────────────────
# Exécution selon l'OS détecté
# ─────────────────────────────────────────
case "$OS" in
arch)
  install_arch
  ;;
debian)
  install_debian
  ;;
macos)
  install_macos
  ;;
esac

# ─────────────────────────────────────────
# Configuration du shell par défaut : fish
# ─────────────────────────────────────────
FISH_PATH=$(command -v fish)

if [[ "$SHELL" != "$FISH_PATH" ]]; then
  log_info "Configuration de fish comme shell par défaut..."
  if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi
  chsh -s "$FISH_PATH"
  log_warn "Redémarrez votre session pour que le changement de shell soit effectif"
else
  log_info "fish est déjà le shell par défaut"
fi

# ─────────────────────────────────────────
# Récapitulatif final
# ─────────────────────────────────────────
echo ""
log_info "─────────────────────────────────────────"
log_info "Installation terminée !"
log_info "─────────────────────────────────────────"
echo ""
log_info "Outils installés :"
for cmd in fish nvim tmux stow bat fd fzf zoxide delta lazygit rg fastfetch oh-my-posh; do
  if command -v "$cmd" >/dev/null 2>&1; then
    echo -e "  ${GREEN}✓${NC} $cmd"
  else
    echo -e "  ${RED}✗${NC} $cmd (non trouvé, vérifiez manuellement)"
  fi
done

# Cas particuliers Ubuntu (batcat/fdfind)
if [[ "$OS" == "debian" ]]; then
  echo ""
  log_warn "Sur Ubuntu, 'bat' et 'fd' sont installés sous les noms 'batcat' et 'fdfind'."
  log_warn "Les fonctions wrapper fish (bat.fish / fd.fish) gèrent déjà ce cas si vos dotfiles sont stow'd."
fi

echo ""
log_info "Prochaine étape : clonez/stow vos dotfiles"
echo "  git clone <votre-repo> ~/dotfiles"
echo "  cd ~/dotfiles"
echo "  stow fish nvim tmux ghostty"
echo ""
