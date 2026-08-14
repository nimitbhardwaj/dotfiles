# ==========================================================
# Main Zsh Config
# ==========================================================

# Keep PATH/FPATH free of duplicates when shells are nested or re-sourced
typeset -U path fpath PATH FPATH

# ---------- Base ----------
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

# Load Secrets
[ -f "$HOME/.config/secrets.zsh" ] && source "$HOME/.config/secrets.zsh"


# ---------- Language / Tooling ----------

# Rust
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"


# Pipx
[[ -d "$HOME/.local/bin" ]] && export PATH="$PATH:$HOME/.local/bin"

# Node (via mise — replaces the old hardcoded node/25.2.1 path)
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# Dotfiles location
export DOTMAN_CONFIG_DIR="$HOME/.dotfiles"

# ---------- Starship Prompt ----------
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
