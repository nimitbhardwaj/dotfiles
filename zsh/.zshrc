# ==========================================================
# Main Zsh Config
# ==========================================================

# ---------- Base ----------
. "$HOME/.config/zsh/base.zsh"
. "$HOME/.config/zsh/plugins.zsh"
. "$HOME/.config/zsh/doctor.zsh"

# Load bun
. "$HOME/.config/zsh/bun.zsh"

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
