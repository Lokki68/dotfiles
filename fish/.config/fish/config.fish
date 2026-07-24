# ─────────────────────────────────────────
# Oh-My-Posh
# ─────────────────────────────────────────

if status is-interactive
  oh-my-posh init fish -c ~/.cache/oh-my-posh/themes/iterm2.omp.json | source
end

# ─────────────────────────────────────────
# Path
# ─────────────────────────────────────────

fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin
fish_add_path /opt/rubymine/bin

# Pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path $PNPM_HOME

# Android
set -gx ANDROID_HOME $HOME/Android/Sdk
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools

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
else
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
    if status is-interactive
        eza --icons=always
    end
end


# pnpm
set -gx PNPM_HOME "/home/libertb/.local/share/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
