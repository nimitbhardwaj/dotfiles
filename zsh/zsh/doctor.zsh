# ==========================================================
# Zsh Doctor - Environment Health Check
# ==========================================================

zsh_doctor() {
  local errors=0
  local warnings=0

  print ""
  print "🩺 Zsh Doctor — checking your shell environment..."
  print "-----------------------------------------------"

  # ---------- OS ----------
  print "• OS: $OSTYPE"
  if [[ "$OSTYPE" == darwin* ]]; then
    print "  ✓ Detected macOS"
  elif [[ "$OSTYPE" == linux* ]]; then
    print "  ✓ Detected Linux"
  else
    print "  ⚠ Unknown OS type"
    ((warnings++))
  fi

  # ---------- Homebrew (macOS) ----------
  if [[ "$OSTYPE" == darwin* ]]; then
    if [[ -x /opt/homebrew/bin/brew ]]; then
      print "  ✓ Homebrew found"
    else
      print "  ✗ Homebrew not found at /opt/homebrew/bin/brew"
      print "    → Install from: https://brew.sh"
      ((errors++))
    fi
  fi

  # ---------- Zinit ----------
  if [[ -f ~/.zinit/bin/zinit.zsh ]]; then
    print "  ✓ zinit installed"
  else
    print "  ✗ zinit not found"
    print "    → It will be auto-installed on next shell start"
    ((warnings++))
  fi

  # ---------- Starship ----------
  if command -v starship >/dev/null 2>&1; then
    print "  ✓ starship installed"
  else
    print "  ⚠ starship not installed"
    print "    → Prompt will fall back to default"
    ((warnings++))
  fi

  # ---------- eza ----------
  if command -v eza >/dev/null 2>&1; then
    print "  ✓ eza installed"
  else
    print "  ⚠ eza not installed (ls aliases inactive)"
    print "    → Install: brew install eza  OR  sudo apt install eza"
    ((warnings++))
  fi

  # ---------- Rust ----------
  if [[ -f "$HOME/.cargo/env" ]]; then
    print "  ✓ Rust environment found"
  else
    print "  ⚠ Rust not configured (~/.cargo/env missing)"
    ((warnings++))
  fi

  # ---------- Pipx ----------
  if [[ -d "$HOME/.local/bin" ]]; then
    print "  ✓ pipx bin directory present"
  else
    print "  ⚠ ~/.local/bin missing (pipx tools may not be in PATH)"
    ((warnings++))
  fi

  # ---------- opencode ----------
  if [[ -d "$HOME/.opencode/bin" ]]; then
    print "  ✓ opencode found"
  else
    print "  ⚠ opencode not found"
    ((warnings++))
  fi

  # ---------- Completion ----------
  if [[ -d ~/.zfunc ]]; then
    print "  ✓ ~/.zfunc directory exists"
  else
    print "  ⚠ ~/.zfunc directory missing"
    print "    → Completions may not load"
    ((warnings++))
  fi

  # ---------- zcompdump ----------
  if [[ -f ~/.cache/zcompdump ]]; then
    print "  ✓ Completion cache found"
  else
    print "  ⚠ No ~/.cache/zcompdump (will be created by compinit)"
    ((warnings++))
  fi

  # ---------- Plugins ----------
  local plugins=(
    "zsh-users/zsh-autosuggestions"
    "zdharma-continuum/fast-syntax-highlighting"
    "hlissner/zsh-autopair"
    "zsh-users/zsh-history-substring-search"
    "jeffreytse/zsh-vi-mode"
  )

  print ""
  print "• Checking plugins:"
  for p in "${plugins[@]}"; do
    local name="${p##*/}"
    local matches=(~/.zinit/plugins/*${name}*)
    if (( ${#matches[@]} )); then
      print "  ✓ $name"
    else
      print "  ⚠ $name not found (will be installed by zinit)"
      ((warnings++))
    fi
  done

  # ---------- Fonts (Starship / icons) ----------
  print ""
  print "• Font / Icons:"
  if [[ -n "$TERM_PROGRAM" ]]; then
    print "  Terminal: $TERM_PROGRAM"
  fi
  print "  → If icons look broken, install a Nerd Font"

  # ---------- Summary ----------
  print ""
  print "-----------------------------------------------"
  if (( errors == 0 && warnings == 0 )); then
    print "✅ All checks passed. Your Zsh setup looks healthy."
  else
    print "🧾 Summary:"
    print "  Errors:   $errors"
    print "  Warnings: $warnings"
    print ""
    if (( errors > 0 )); then
      print "❌ Fix errors first. Zsh may not behave correctly."
    else
      print "⚠ Your setup works, but improvements are recommended."
    fi
  fi
  print ""
}

alias zsh-doctor='zsh_doctor'

