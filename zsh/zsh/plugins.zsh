# ==========================================================
# Plugin Manager: zinit (No Oh My Zsh)
# ==========================================================
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
  echo "Installing zinit..."
  mkdir -p ~/.zinit
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

# ==========================================================
# Plugins
# ==========================================================
# Load order matters:
#   zsh-vi-mode -> fzf-tab -> widget-wrapping plugins -> syntax highlighting

# vim mode in terminal
# "sourcing" init mode makes zvm set up its keymaps immediately instead of at
# the first prompt, so anything bound after this line survives.
ZVM_INIT_MODE=sourcing
zinit light jeffreytse/zsh-vi-mode

# zvm resets the keymaps on init, so re-apply fzf's ^R / ^T / M-c bindings
command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)

# fzf on the Tab key (needs compinit, done in base.zsh).
# Must load *after* fzf's own completion, which otherwise grabs ^I.
zinit light Aloxaf/fzf-tab

# Autosuggestions (ghost text)
zinit light zsh-users/zsh-autosuggestions

# Better bracket / quote handling
zinit light hlissner/zsh-autopair

# zsh-history-substring-search
zinit light zsh-users/zsh-history-substring-search

# Fast syntax highlighting (keep last)
zinit light zdharma-continuum/fast-syntax-highlighting

# ==========================================================
# Plugin Configuration (BELONGS HERE)
# ==========================================================

# Accept autosuggestion if present, otherwise move cursor right
bindkey -M viins '^[[C' forward-char


bindkey -M vicmd '^[[A' history-substring-search-up
bindkey -M vicmd '^[[B' history-substring-search-down

bindkey -M viins '^[[A' history-substring-search-up
bindkey -M viins '^[[B' history-substring-search-down

# Ghost text color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=black,bg=yellow,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=black,bg=red,bold'

# ---------- fzf-tab ----------

# Completion groups need descriptions for fzf-tab to show/switch them
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Keep git refs / branches in their natural order
zstyle ':completion:*:git-checkout:*' sort false

# Window / behaviour.
# No --height here on purpose: fzf-tab sizes the popup to the number of matches
# (capped at 2/3 of the screen), so short lists get a short window.
# --layout=reverse and --cycle are already fzf-tab defaults.
zstyle ':fzf-tab:*' fzf-flags --border --info=inline
zstyle ':fzf-tab:*' fzf-min-height 15
zstyle ':fzf-tab:*' switch-group '[' ']'   # move between completion groups
zstyle ':fzf-tab:*' continuous-trigger '/' # keep descending into directories
zstyle ':fzf-tab:*' prefix ''              # no leading dot marker

# Generic preview: directories listed, files dumped
_fzf_tab_preview() {
  local target=$realpath
  if [[ -d $target ]]; then
    eza -1 --icons --color=always --group-directories-first -- "$target" 2>/dev/null | head -n 200
  elif [[ -f $target ]]; then
    if command -v bat >/dev/null 2>&1; then
      bat --style=numbers --color=always --line-range=:200 -- "$target" 2>/dev/null
    else
      head -n 200 -- "$target" 2>/dev/null
    fi
  else
    print -r -- "$word"
  fi
}
zstyle ':fzf-tab:complete:*:*' fzf-preview '_fzf_tab_preview'

# Value of the variable being completed
zstyle ':fzf-tab:complete:(export|unset|printenv|echo):*' fzf-preview 'print -r -- ${(P)word}'

# Process info for kill
zstyle ':fzf-tab:complete:(kill|pkill):argument-rest' fzf-preview \
  'ps -p $word -o pid,%cpu,%mem,tty,command 2>/dev/null'
zstyle ':fzf-tab:complete:(kill|pkill):argument-rest' fzf-flags --preview-window=down:4:wrap

# Git
zstyle ':fzf-tab:complete:git-(add|diff|restore|checkout|stash):*' fzf-preview \
  'git diff --color=always -- $word 2>/dev/null | head -n 200'
zstyle ':fzf-tab:complete:git-(log|show|revert|rebase|cherry-pick):*' fzf-preview \
  'git log --color=always --oneline --graph -20 $word 2>/dev/null'

# Man pages
zstyle ':fzf-tab:complete:(man|-command-):*' fzf-preview \
  'man $word 2>/dev/null | col -bx | head -n 200'

