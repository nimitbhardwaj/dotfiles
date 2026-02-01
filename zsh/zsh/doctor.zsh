# ==========================================================
# Zsh Doctor - Environment Health Check
# Organized by: Foundation → Package Managers → Runtimes → Tools → Infrastructure
# ==========================================================

zsh_doctor() {
  local errors=0
  local warnings=0

  print ""
  print "🩺 Zsh Doctor — checking your shell environment..."
  print "==============================================="

  # =========================================================
  # SECTION 1: SYSTEM FOUNDATION
  # =========================================================
  print ""
  print "📦 SYSTEM FOUNDATION"
  print "───────────────────────────────────────────────"

  print "• OS: $OSTYPE"
  if [[ "$OSTYPE" == darwin* ]]; then
    print "  ✓ Detected macOS"
  elif [[ "$OSTYPE" == linux* ]]; then
    print "  ✓ Detected Linux"
  else
    print "  ⚠ Unknown OS type"
    ((warnings++))
  fi

  # =========================================================
  # SECTION 2: PACKAGE MANAGERS
  # =========================================================
  print ""
  print "📦 PACKAGE MANAGERS"
  print "───────────────────────────────────────────────"

  if [[ "$OSTYPE" == darwin* ]]; then
    if [[ -x /opt/homebrew/bin/brew ]]; then
      print "✓ Homebrew"
    else
      print "✗ Homebrew not found at /opt/homebrew/bin/brew"
      print "  → Install from: https://brew.sh"
      ((errors++))
    fi
  fi

  # =========================================================
  # SECTION 3: SHELL FRAMEWORK
  # =========================================================
  print ""
  print "🐚 SHELL FRAMEWORK"
  print "───────────────────────────────────────────────"

  if command -v zinit >/dev/null 2>&1; then
    print "✓ Zinit installed"
  else
    print "✗ Zinit not found"
    print "  → Auto-installed on next shell start"
    ((warnings++))
  fi

  # =========================================================
  # SECTION 4: PROGRAMMING LANGUAGES & RUNTIMES
  # =========================================================
  print ""
  print "💻 LANGUAGES & RUNTIMES"
  print "───────────────────────────────────────────────"

  if command -v rustc >/dev/null 2>&1; then
    print "✓ Rust"
  else
    print "⚠ Rust not found"
    ((warnings++))
  fi

  if command -v bun >/dev/null 2>&1; then
    print "✓ Bun"
  else
    print "✗ Bun not found"
    print "  → Install from: https://bun.sh"
    ((errors++))
  fi

  # =========================================================
  # SECTION 5: CLI UTILITIES & TOOLS
  # =========================================================
  print ""
  print "🛠 CLI UTILITIES"
  print "───────────────────────────────────────────────"

  if command -v starship >/dev/null 2>&1; then
    print "✓ Starship (prompt)"
  else
    print "⚠ Starship not installed"
    print "  → Prompt will fall back to default"
    ((warnings++))
  fi

  if command -v eza >/dev/null 2>&1; then
    print "✓ Eza (ls replacement)"
  else
    print "⚠ Eza not installed (ls aliases inactive)"
    print "  → Install: brew install eza  OR  sudo apt install eza"
    ((warnings++))
  fi

  if command -v bd >/dev/null 2>&1; then
    print "✓ bd (Beads task tracker)"
  else
    print "⚠ bd not found (Beads task tracker for LLMs)"
    print "  → Beads helps AI agents track tasks, issues, and context"
    print "  → Install: curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash"
    ((warnings++))
  fi

  if command -v lazysql >/dev/null 2>&1; then
    print "✓ lazysql (SQL client)"
  else
    print "⚠ lazysql not found (TUI SQL client)"
    print "  → Install: brew install lazysql"
    ((warnings++))
  fi

  # =========================================================
  # SECTION 6: DEVELOPMENT TOOLS
  # =========================================================
  print ""
  print "🔧 DEVELOPMENT TOOLS"
  print "───────────────────────────────────────────────"

  if command -v opencode >/dev/null 2>&1; then
    print "✓ Opencode"
  else
    print "⚠ Opencode not found"
    ((warnings++))
  fi

  if command -v ralph-tui >/dev/null 2>&1; then
    print "✓ Ralph TUI"
  else
    print "⚠ Ralph TUI not found"
    print "  → Install with: bun install -g ralph-tui"
    ((warnings++))
  fi

  # =========================================================
  # SECTION 7: ZSH INFRASTRUCTURE
  # =========================================================
  print ""
  print "🏗 ZSH INFRASTRUCTURE"
  print "───────────────────────────────────────────────"

  if [[ -d ~/.zfunc ]]; then
    print "✓ ~/.zfunc directory"
  else
    print "⚠ ~/.zfunc directory missing"
    print "  → Completions may not load"
    ((warnings++))
  fi

  if [[ -d "$HOME/.local/bin" ]]; then
    print "✓ ~/.local/bin (pipx)"
  else
    print "⚠ ~/.local/bin missing (pipx tools may not be in PATH)"
    ((warnings++))
  fi

  if [[ -f ~/.cache/zcompdump ]]; then
    print "✓ Completion cache (zcompdump)"
  else
    print "⚠ No ~/.cache/zcompdump (will be created by compinit)"
    ((warnings++))
  fi

  # =========================================================
  # SECTION 8: PLUGINS
  # =========================================================
  print ""
  print "🔌 PLUGINS (Zinit)"
  print "───────────────────────────────────────────────"

  local plugins=(
    "zsh-users/zsh-autosuggestions"
    "zdharma-continuum/fast-syntax-highlighting"
    "hlissner/zsh-autopair"
    "zsh-users/zsh-history-substring-search"
    "jeffreytse/zsh-vi-mode"
  )

  for p in "${plugins[@]}"; do
    local name="${p##*/}"
    local matches=(~/.zinit/plugins/*${name}*)
    if (( ${#matches[@]} )); then
      print "✓ $name"
    else
      print "⚠ $name not found (will be installed by zinit)"
      ((warnings++))
    fi
  done

  # =========================================================
  # SECTION 9: TERMINAL & FONTS
  # =========================================================
  print ""
  print "🎨 TERMINAL & FONTS"
  print "───────────────────────────────────────────────"

  if [[ -n "$TERM_PROGRAM" ]]; then
    print "Terminal: $TERM_PROGRAM"
  fi
  print "→ If icons look broken, install a Nerd Font"

  # =========================================================
  # SECTION 10: SUMMARY
  # =========================================================
  print ""
  print "==============================================="
  if (( errors == 0 && warnings == 0 )); then
    print "✅ All checks passed. Your Zsh setup looks healthy."
  else
    print "🧾 SUMMARY"
    print "───────────────────────────────────────────────"
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
