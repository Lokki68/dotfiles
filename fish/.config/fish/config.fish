# ─────────────────────────────────────────
# Oh-My-Posh
# ─────────────────────────────────────────

if status is-interactive
    if type -q oh-my-posh
        if test -f ~/.config/fish/themes/iterm2.omp.json
            oh-my-posh init fish --config ~/.config/fish/themes/iterm2.omp.json | source
        end
    end
end

# ─────────────────────────────────────────
# Path
# ─────────────────────────────────────────

fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin

# Pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path $PNPM_HOME

# Android
if test -d $HOME/Android/Sdk
    set -gx ANDROID_HOME $HOME/Android/Sdk
    fish_add_path $ANDROID_HOME/emulator
    fish_add_path $ANDROID_HOME/platform-tools
end

# ─────────────────────────────────────────
# Variable d'environnement
# ─────────────────────────────────────────
set -gx EDITOR nvim
set -gx RUBY_BUILD_ROOT "$HOME/.ruby-build"

# ─────────────────────────────────────────
# ASDF
# ─────────────────────────────────────────
if test -f $HOME/.asdf/asdf.fish
    source $HOME/.asdf/asdf.fish
else if test -f /opt/asdf-vm/asdf.fish
    source /opt/asdf-vm/asdf.fish
end

# ─────────────────────────────────────────
# Historique
# ─────────────────────────────────────────
set -g fish_history_size 5000

# ─────────────────────────────────────────
# Keybindings
# ─────────────────────────────────────────
if status is-interactive
    bind \cp history-search-backward
    bind \cn history-search-forward
end

# ─────────────────────────────────────────
# FZF
# ─────────────────────────────────────────
if type -q fzf
    fzf --fish | source
end

# ─────────────────────────────────────────
# Zoxide
# ─────────────────────────────────────────
if type -q zoxide
    zoxide init fish | source
end

# ─────────────────────────────────────────
# Hook chpwd equivalent → ls après cd
# ─────────────────────────────────────────
function __auto_ls --on-variable PWD
    if status is-interactive && type -q eza
        eza --icons=always
    end
end
