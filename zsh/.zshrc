# ==========================================================
# Main Zsh Config
# ==========================================================

# Load base configuration
. "$HOME/.config/zsh/base.zsh"

# Load plugins
. "$HOME/.config/zsh/plugins.zsh"

# Load bun
. "$HOME/.config/zsh/bun.zsh"

# ---------- Language / Tooling ----------

# Rust
source "$HOME/.cargo/env"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# Pipx
export PATH="$PATH:$HOME/.local/bin"

# Dotfiles location
export DOTMAN_CONFIG_DIR="$HOME/.dotfiles"

# ---------- Functions / Completions ----------
fpath+=~/.zfunc

# ---------- Starship Prompt ----------
# Starship controls ALL visuals (only load once)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
