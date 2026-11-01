# ==========================================================
# Main Zsh Config
# ==========================================================

# Keep PATH/FPATH free of duplicates when shells are nested or re-sourced
typeset -U path fpath PATH FPATH

# ---------- Modules ----------
ZSH_CONFIG_DIR="$HOME/.config/zsh"

# Order matters: base.zsh runs compinit, which plugins.zsh (fzf-tab) needs.
# These load first, in this exact order; everything else follows alphabetically.
zsh_config_order=(base plugins)

if [[ -d "$ZSH_CONFIG_DIR" ]]; then
  for name in $zsh_config_order; do
    [[ -r "$ZSH_CONFIG_DIR/$name.zsh" ]] && source "$ZSH_CONFIG_DIR/$name.zsh"
  done

  for file in "$ZSH_CONFIG_DIR"/*.zsh(N); do
    (( ${zsh_config_order[(Ie)${${file:t}:r}]} )) && continue
    source "$file"
  done

  unset zsh_config_order name file
fi

# ---------- Secrets ----------
[[ -f "$HOME/.config/secrets.zsh" ]] && source "$HOME/.config/secrets.zsh"

# ---------- Environment ----------

# Dotfiles location
export DOTMAN_CONFIG_DIR="$HOME/.dotfiles"

# ---------- PATH ----------
# Rust: ~/.cargo/env is sourced from ~/.zshenv

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# Lacy Shell
export PATH="$HOME/.lacy/bin:$PATH"

# Pipx
[[ -d "$HOME/.local/bin" ]] && export PATH="$PATH:$HOME/.local/bin"

# ---------- Language / Tooling ----------

# Node (via mise)
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# ---------- Starship Prompt ----------
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# ---------- Lacy Shell Plugin ----------
# Keep last: sets up prompt and keybindings
# NO_COLOR is unexported so it only affects Lacy, not other tools
NO_COLOR=1
[[ -r "$HOME/.lacy/lacy.plugin.zsh" ]] && source "$HOME/.lacy/lacy.plugin.zsh"
