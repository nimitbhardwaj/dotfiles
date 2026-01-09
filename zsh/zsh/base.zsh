# ==========================================================
# Zsh Base Configuration (Starship + eza)
# ==========================================================

# ---------- Zsh Options ----------
setopt autocd
setopt interactivecomments
setopt magicequalsubst
setopt nonomatch
setopt notify
setopt numericglobsort
setopt promptsubst

WORDCHARS=${WORDCHARS//\/}
PROMPT_EOL_MARK=""

# ---------- Key Bindings (Core Zsh Only) ----------
bindkey -e
bindkey ' ' magic-space
bindkey '^U' backward-kill-line
bindkey '^[[3;5~' kill-word
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[Z' undo

# ---------- Completion ----------
autoload -Uz compinit
compinit -d ~/.cache/zcompdump

zstyle ':completion:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ---------- History ----------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000

setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
# setopt share_history

alias history="history 0"

# ---------- eza (ls replacement) ----------
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -l --icons --group-directories-first'
  alias la='eza -la --icons --group-directories-first'
  alias l='eza -CF --icons --group-directories-first'

  alias lt='eza --tree --icons'
  alias lg='eza --git --icons'
  alias lS='eza --sort=size --icons'
  alias lM='eza --sort=modified --icons'
fi

# ---------- General Aliases ----------
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# -------auto-description
fpath+=~/.zfunc; autoload -Uz compinit; compinit

