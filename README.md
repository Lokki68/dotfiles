# dotfiles

> Configuration dotfiles synchronisée sur 3 postes via **GNU Stow**.
> Développeur web fullstack — Ruby on Rails, JS/TS, React, Next.js, Vue.js.

---

## 🖥️ Aperçu des postes

| Poste                    | OS         | Usage            |
| ------------------------ | ---------- | ---------------- |
| **ThinkBook**            | Arch Linux | Principal / pro  |
| **ThinkPad**             | Ohmarchy   | Personnel        |
| **MacBook Pro 13" 2019** | macOS      | Mobile / secours |

Chaque poste partage la même configuration via Git + Stow. Seuls les outils propres à chaque OS (paquets système, installeur CLI) diffèrent.

---

## 📁 Structure du dépôt

```
dotfiles/
├── install.sh                  # Script principal (détecte l'OS, installe tout)
├── scripts/
│   └── install-cli-tools.sh     # Installe les outils CLI selon l'OS
├── fish/.config/fish/           # Shell Fish + oh-my-posh + thème
├── nvim/.config/nvim/           # Neovim (Lua, lazy.nvim)
├── ghostty/.config/ghostty/     # Terminal Ghostty
├── tmux/.tmux.conf              # Tmux + tmux-navigator
└── README.md                    # Ce fichier
```

Chaque sous-dossier est un **package GNU Stow**. Le contenu est rangé comme il devrait apparaître dans `$HOME` après le stow :

```
fish/.config/fish/        →  ~/.config/fish/
nvim/.config/nvim/        →  ~/.config/nvim/
ghostty/.config/ghostty/  → ~/.config/ghostty/
tmux/.tmux.conf           →  ~/.tmux.conf
```

---

## ✅ Prérequis

| Outil  | Rôle                 | Arch                  | Ubuntu                  | macOS               |
| ------ | -------------------- | --------------------- | ----------------------- | ------------------- |
| `git`  | Versioning           | `sudo pacman -S git`  | `sudo apt install git`  | ✅ déjà là          |
| `stow` | Gestion des symlinks | `sudo pacman -S stow` | `sudo apt install stow` | `brew install stow` |
| `curl` | Téléchargements      | `sudo pacman -S curl` | `sudo apt install curl` | ✅ déjà là          |

---

## 🚀 Installation rapide

Sur un **nouveau poste**, en une commande :

```bash
git clone https://github.com/votreuser/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Le script `install.sh` détecte votre OS, installe les dépendances système, puis stow tous les packages.

> ⚠️ Le premier lancement de Fish peut afficher une erreur `oh-my-posh init` si le fichier de thème est absent. Voyez la section [Dépannage](#dépannage).

---

## 🔧 Installation manuelle détaillée

### 1. Cloner le dépôt

```bash
git clone https://github.com/votreuser/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Installer les dépendances système

**Arch Linux :**

```bash
sudo pacman -S git stow curl
```

**Ubuntu :**

```bash
sudo apt update
sudo apt install git stow curl
```

**macOS :**

```bash
brew install git stow
```

### 3. Installer les outils CLI modernes

```bash
./scripts/install-cli-tools.sh
```

Ce script installe automatiquement (selon l'OS) :

- `eza` — remplacement moderne de `ls`
- `bat` — remplacement moderne de `cat`
- `fd` — remplacement moderne de `find`
- `ripgrep` / `rg` — recherche ultra-rapide
- `fzf` — fuzzy finder interactif
- `zoxide` — `cd` intelligent
- `git-delta` — diff avec syntax highlighting
- `lazygit` — UI Git en terminal
- `gh` — CLI GitHub
- `jq` — manipule JSON
- `htop` / `ncdu` — monitoring disque/CPU
- `oh-my-posh` — prompt主题
- `ghostty` — terminal

### 4. Stow tous les packages d'un coup

```bash
./install.sh
```

Ou package par package :

```bash
stow fish
stow nvim
stow ghostty
stow tmux
```

---

## 📦 Ajouter un nouveau package aux dotfiles

### Méthode avec GNU Stow

```
1.  Créer la structure de dossier :
    mkdir -p ~/dotfiles/monoutils/.config/monoutils

2.  Y placer le contenu tel qu'il doit apparaître dans $HOME :
    cp ~/.config/monoutils/config ~/dotfiles/monoutils/.config/monoutils/config

3.  Retirer (ou renommer) l'original :
    mv ~/.config/monoutils ~/.config/monoutils.bak

4.  Stow le package :
    cd ~/dotfiles
    stow monoutils

5.  Vérifier :
    ls -la ~/.config/monoutils
    # Doit être un lien symbolique → dotfiles/monoutils/.config/monoutils/
```

### Cas d'un fichier unique à la racine de $HOME

```
Ex: ~/.tmux.conf

Structure : tmux/.tmux.conf
Stow :     cd ~/dotfiles && stow tmux
Résultat : ~/.tmux.conf → dotfiles/tmux/.tmux.conf
```

---

## 🔄 Mettre à jour les dotfiles sur un autre poste

```bash
cd ~/dotfiles
git pull
./scripts/install-cli-tools.sh
stow -R fish nvim ghostty tmux
```

`stow -R` unstow puis restow tous les packages listés. Cela met à jour les symlinks après un `git pull`.

---

## 🗑️ Désinstaller un package

```bash
cd ~/dotfiles
stow -D fish        # retire le symlink ~/.config/fish
```

Le contenu original (s'il a été sauvegardé) est retrouvé automatiquement par le shell.

---

## 🛠️ Détail des outils inclus

| Outil                     | Rôle                                                         | Remplace               |
| ------------------------- | ------------------------------------------------------------ | ---------------------- |
| **Fish**                  | Shell interactif avec auto-complétion avancée                | bash, zsh              |
| **oh-my-posh**            | Prompt thèmeé avec icônes et infos git                       | prompt Fish par défaut |
| **Neovim + lazy.nvim**    | Éditeur modal Lua avec plugins (diffview, dadbod, navigator) | VS Code, Sublime       |
| **Ghostty**               | Terminal rapide, native UI, theme Catppuccin-mocha           | iTerm2, Terminator     |
| **Tmux + tmux-navigator** | Multiplexeur + navigation pane vim/tmux                      | onglets du terminal    |
| **eza**                   | Listing avec icônes, couleurs, git status                    | `ls`                   |
| **bat**                   | Affichage de fichier avec syntax highlighting                | `cat`                  |
| **fd**                    | Recherche de fichiers rapide et coloré                       | `find`                 |
| **ripgrep / rg**          | Recherche dans le contenu (regex, glob,ignore)               | `grep`                 |
| **fzf**                   | Fuzzy finder interactif (completion Fish)                    | búsqueda manuelle      |
| **zoxide**                | `cd` intelligent qui apprend vos habitudes                   | `cd`                   |
| **git-delta**             | Diff avec coloration syntaxique et side-by-side              | `git diff`             |
| **lazygit**               | TUI Git pour gestion visuelle des commits/branches           | ligne de commande git  |
| **gh**                    | CLI GitHub (PR, issues, releases)                            | interface web GitHub   |
| **jq**                    | Requête et transformation JSON                               | grep + awk sur JSON    |
| **htop / ncdu**           | Monitoring CPU/mémoire et usage disque                       | `top`, `du`            |

---

## 🐛 Dépannage

### `oh-my-posh init fish` échoue — thème introuvable

**Symptôme :** `Error in init sourced file: theme not found at...`

**Cause :** Le fichier de thème (`iterm2.omp.json`) n'existe pas dans les dotfiles.

**Solution :**

```bash
# Vérifier que le thème existe dans les dotfiles
ls ~/dotfiles/fish/.config/fish/themes/

# Si absent, exporter le thème depuis oh-my-posh
oh-my-posh print config --error > ~/.cache/oh-my-posh/themes/iterm2.omp.json
# Puis le copier dans les dotfiles
mkdir -p ~/dotfiles/fish/.config/fish/themes/
cp ~/.cache/oh-my-posh/themes/iterm2.omp.json ~/dotfiles/fish/.config/fish/themes/
```

Le bloc `if type -q oh-my-posh` dans `config.fish` protège déjà contre l'absence du binaire. Si vous voulez aussi sécuriser l'absence du thème :

```fish
if type -q oh-my-posh
    if test -f ~/.config/fish/themes/iterm2.omp.json
        oh-my-posh init fish --config ~/.config/fish/themes/iterm2.omp.json | source
    end
end
```

---

### `eza` non installé — prompt cassé à chaque `cd`

**Symptôme :** Erreur à chaque changement de répertoire, prompt affiche une erreur.

**Cause :** `eza` est utilisé dans le hook `fish_prompt` (`__auto_ls`). Si `eza` est absent, la commande échoue.

**Solution :** Installer `eza`

```bash
# Arch
sudo pacman -S eza

# Ubuntu : depuis le dépôt GitHub ou via le script
curl -L https://github.com/eza-community/eza/releases/download/v0.20.18/eza_v0.20.18_amd-unknown-linux-gnu.tar.gz | tar xz
sudo mv eza /usr/local/bin/

# macOS
brew install eza
```

---

### `bat` et `fd` — noms différents sur Ubuntu

**Symptôme :** `alias cat='bat'` ne fonctionne pas, `fd` introuvable.

**Cause :** Sur Ubuntu, le paquet `bat` s'appelle `batcat` et `fd` s'appelle `fdfind`.

**Solution dans `~/.config/fish/config.fish` :**

```fish
# Ubuntu : alias vers les bons binaires
if type -q batcat
    abbr -a cat batcat
else if type -q bat
    abbr -a cat bat
end

if type -q fdfind
    abbr -a fd fdfind
else if type -q fd
    abbr -a fd fd
end
```

Ou utiliser le script `install-cli-tools.sh` qui gère déjà ces cas.

---

### Chemin `pnpm` en dur avec un username

**Symptôme :** Erreur `PNPM_HOME` introuvable après clone sur un autre poste.

**Cause :** La ligne `set -gx PNPM_HOME "$HOME/.local/share/pnpm"` dans `config.fish` est correcta. Vérifiez que `fish_add_path $PNPM_HOME` est bien après la définition de `PNPM_HOME`.

**Solution :**

```fish
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path $PNPM_HOME
```

---

### ASDF introuvable après clonage

**Symptôme :** `fish: source: no such file /home/libertb/.asdf/asdf.fish`

**Cause :** Le chemin ASDF varie selon l'installation (git clone vs gestionnaire de paquets) et le username.

**Solution :** Modifier `config.fish` pour chercher les deux chemins :

```fish
if test -f $HOME/.asdf/asdf.fish
    source $HOME/.asdf/asdf.fish
else if test -f /opt/asdf-vm/asdf.fish
    source /opt/asdf-vm/asdf.fish
else
    echo "ASDF non trouvé — ignorer ou installer"
end
```

---

### Stow dit `"ERROR: package 'fish' does not exist"`

**Cause :** Vous n'êtes pas dans le bon répertoire (pas `~/dotfiles`) ou le dossier `fish/` n'existe pas encore.

**Solution :**

```bash
cd ~/dotfiles
ls fish/
stow fish
```

---

## 🌐 Compatibilité multi-OS

| Étape      | Arch Linux             | Ubuntu                                     | macOS                     |
| ---------- | ---------------------- | ------------------------------------------ | ------------------------- |
| Git        | `pacman -S git`        | `apt install git`                          | déjà là                   |
| Stow       | `pacman -S stow`       | `apt install stow`                         | `brew install stow`       |
| Outils CLI | `pacman -S <paquet>`   | `apt install <paquet>` + alias             | `brew install <paquet>`   |
| eza        | `pacman -S eza`        | Dépôt GitHub ou `cargo install eza`        | `brew install eza`        |
| Ghostty    | `pacman -S ghostty`    | Téléchargement .deb ou build from source   | `brew install ghostty`    |
| Oh-my-posh | `pacman -S oh-my-posh` | `curl -s https://ohmyposh.tech/install.sh` | `brew install oh-my-posh` |

Le script `scripts/install-cli-tools.sh` détecte automatiquement l'OS et adapte les commandes.

---

## 📝 Licence

**MIT** — Libre d'utilisation, modification et distribution.

---

## 💡 Notes

- Le dépôt est personnel. Chaque poste a son propre `git remote` si besoin (par exemple, SSH key dédiée sur le ThinkBook).
- Pour un nouveau poste macOS, vérifier que **Xcode Command Line Tools** est installé : `xcode-select --install`.
- Penser à renommer les alias dans `config.fish` après chaque installation CLI pour refléter les binaires disponibles.
- Tester la config Fish après modification : `fish -C "source ~/.config/fish/config.fish; and echo OK"`
