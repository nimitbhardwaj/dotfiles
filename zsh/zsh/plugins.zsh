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

# Autosuggestions (ghost text)
zinit light zsh-users/zsh-autosuggestions

# Fast syntax highlighting
zinit light zdharma-continuum/fast-syntax-highlighting

# Better bracket / quote handling
zinit light hlissner/zsh-autopair

# zsh-history-substring-search
zinit light zsh-users/zsh-history-substring-search

# vim mode in terminal
zinit light jeffreytse/zsh-vi-mode

# ==========================================================
# Plugin Configuration (BELONGS HERE)
# ==========================================================

# History substring search with arrow keys (Vi mode compatible)
bindkey -M viins '^[[A' history-substring-search-up
bindkey -M viins '^[[B' history-substring-search-down
bindkey -M viins '^[[C' autosuggest-accept


bindkey -M vicmd '^[[A' history-substring-search-up
bindkey -M vicmd '^[[B' history-substring-search-down


# Ghost text color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=black,bg=yellow,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=black,bg=red,bold'

