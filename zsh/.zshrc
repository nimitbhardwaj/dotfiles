# ==========================================================
# Main Zsh Config
# ==========================================================

# ---------- Base ----------
ZSH_CONFIG_DIR="$HOME/.config/zsh"

if [[ -d "$ZSH_CONFIG_DIR" ]]; then
  for file in "$ZSH_CONFIG_DIR"/*.zsh(.N); do
    # Skip this main file if it's inside the same directory
    [[ "$file" == "$ZSH_CONFIG_DIR/main.zsh" ]] && continue
    source "$file"
  done
fi


# Load Secrets
[ -f "$HOME/.config/secrets.zsh" ] && source "$HOME/.config/secrets.zsh"


# ---------- Language / Tooling ----------

# Rust
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# opencode
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"

# Pipx
[[ -d "$HOME/.local/bin" ]] && export PATH="$PATH:$HOME/.local/bin"

# Dotfiles location
export DOTMAN_CONFIG_DIR="$HOME/.dotfiles"

# ---------- Functions / Completions ----------
fpath+=~/.zfunc

# ---------- Starship Prompt ----------
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi


# opencode
export PATH=$HOME/.opencode/bin:$PATH
