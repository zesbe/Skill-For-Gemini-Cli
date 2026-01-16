#!/bin/bash
# 🎯 Gemini CLI + Superpowers + MCP Installer for Termux
# Usage: curl -fsSL https://raw.githubusercontent.com/zesbe/Skill-For-Gemini-Cli/main/install-termux.sh | bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  🎯 Gemini CLI + Superpowers + MCP Installer           ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  For Termux (Android)                                 ${CYAN}║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Detect platform
if [ -n "$TERMUX_VERSION" ]; then
    PLATFORM="termux"
    echo -e "${GREEN}✅ Detected: Termux/Android${NC}"
else
    PLATFORM="linux"
    echo -e "${YELLOW}⚠️  Not Termux, but continuing anyway...${NC}"
fi

# Configuration
REPO_URL="https://github.com/zesbe/Skill-For-Gemini-Cli.git"
INSTALL_DIR="$HOME/.gemini"
SUPERPOWERS_DIR="$INSTALL_DIR/superpowers"
SKILLS_DIR="$INSTALL_DIR/skills"
NPM_BIN="$HOME/.npm-global/bin"

echo ""
echo -e "${BLUE}📦 Installing...${NC}"

# Step 1: Clone or update repository
echo -e "${BLUE}📥 Cloning repository...${NC}"
if [ -d "$SUPERPOWERS_DIR" ]; then
    echo "   Updating existing installation..."
    cd "$SUPERPOWERS_DIR"
    git pull origin main 2>/dev/null || echo "   ⚠️  Could not update, using existing"
else
    git clone "$REPO_URL" "$SUPERPOWERS_DIR"
    echo "   ✅ Repository cloned"
fi

# Step 2: Create skills directory
echo -e "${BLUE}📁 Creating skills directory...${NC}"
mkdir -p "$SKILLS_DIR"

# Step 3: Copy MCP config
echo -e "${BLUE}🔌 Setting up MCP configuration...${NC}"
if [ -f "$SUPERPOWERS_DIR/mcp.json" ]; then
    cp "$SUPERPOWERS_DIR/mcp.json" "$INSTALL_DIR/mcp.json"
    echo "   ✅ MCP config installed"
else
    echo -e "   ${YELLOW}⚠️  MCP config not found in repo${NC}"
fi

# Step 4: Create launcher scripts
echo -e "${BLUE}🚀 Creating launcher scripts...${NC}"
mkdir -p "$NPM_BIN"

# Create gemini launcher
cat > "$NPM_BIN/gemini" << 'LAUNCHER'
#!/bin/bash
# 🎯 Gemini CLI Launcher with Superpowers + YOLO Mode

# Configuration
GEMINI_DIR="/data/data/com.termux/files/usr/lib/node_modules/@google/gemini-cli"
NODE_PATH="/data/data/com.termux/files/usr/lib/node_modules"
SUPERPOWERS_DIR="$HOME/.gemini/superpowers"
YOLO_MODE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --yolo) YOLO_MODE=true; shift ;;
        --no-superpowers) shift ;;
        *) shift ;;
    esac
done

# Set environment
export NODE_PATH="$NODE_PATH"
export TMPDIR="$HOME/.tmp/gemini-temp"
export TEMP="$HOME/.tmp/gemini-temp"
export TMP="$HOME/.tmp/gemini-temp"
mkdir -p "$TMPDIR" 2>/dev/null || true

# Show Superpowers info
if [ -d "$SUPERPOWERS_DIR" ]; then
    echo -e "${CYAN}🛡️  Superpowers available${NC}"
    echo -e "   Run: ${GREEN}node ~/.gemini/superpowers/gemini-cli.js bootstrap${NC}"
    echo ""
fi

# Launch Gemini
cd "$GEMINI_DIR"
exec node dist/index.js "$@"
LAUNCHER
chmod +x "$NPM_BIN/gemini"
echo "   ✅ gemini launcher created"

# Create quick YOLO launcher
cat > "$NPM_BIN/g" << 'YOLO'
#!/bin/bash
export PATH="/data/data/com.termux/files/home/.npm-global/bin:$PATH"
exec gemini --yolo "$@"
YOLO
chmod +x "$NPM_BIN/g"
echo "   ✅ g (YOLO) launcher created"

# Create standalone launcher script
cat > "$HOME/launch-gemini.sh" << 'SCRIPT'
#!/bin/bash
# 🚀 Quick Gemini CLI Launcher
# Usage: ./launch-gemini.sh [--yolo]

if [ "$1" = "--yolo" ] || [ "$1" = "-y" ]; then
    export PATH="/data/data/com.termux/files/home/.npm-global/bin:$PATH"
    exec gemini --yolo
else
    export PATH="/data/data/com.termux/files/home/.npm-global/bin:$PATH"
    exec gemini
fi
SCRIPT
chmod +x "$HOME/launch-gemini.sh"
echo "   ✅ launch-gemini.sh created"

# Step 5: Create shell aliases
echo -e "${BLUE}📝 Creating shell aliases...${NC}"
cat > "$INSTALL_DIR/shell-aliases.sh" << 'ALIASES'
# 🚀 Quick aliases untuk Gemini CLI
# Tambahkan ke ~/.bashrc: source ~/.gemini/shell-aliases.sh

alias g='gemini --yolo --no-superpowers'
alias gs='gemini --yolo'
alias sp-bootstrap='node ~/.gemini/superpowers/gemini-cli.js bootstrap'
alias sp-list='node ~/.gemini/superpowers/gemini-cli.js find-skills'
ALIASES
echo "   ✅ shell-aliases.sh created"

# Step 6: Create README
echo -e "${BLUE}📚 Creating documentation...${NC}"
cat > "$INSTALL_DIR/README.md" << 'README'
# Gemini CLI + Superpowers + MCP

## Quick Start

```bash
# YOLO Mode (Recommended)
g "Your prompt here"

# Normal Mode
gemini

# With Superpowers
gs
```

## Superpowers

Run inside Gemini:
```bash
node ~/.gemini/superpowers/gemini-cli.js bootstrap
node ~/.gemini/superpowers/gemini-cli.js find-skills
```

## Available Skills

- brainstorming, writing-plans, executing-plans
- test-driven-development, subagent-driven-development
- systematic-debugging, root-cause-tracing
- code-review, security-review, ui-ux-review
- deployment, using-git-worktrees

## Notes

- MCP servers configured in ~/.gemini/mcp.json (for Claude Code)
- API keys stored in ~/.glm_api_key
- Run `source ~/.gemini/shell-aliases.sh` to add aliases
README

echo "   ✅ README.md created"

# Step 7: Add to PATH
echo -e "${BLUE}🔧 Updating PATH...${NC}"
PATH_EXPORT="export PATH=\"$NPM_BIN:\$PATH\""
BASHRC="$HOME/.bashrc"

if [ -f "$BASHRC" ]; then
    if ! grep -q "$NPM_BIN" "$BASHRC" 2>/dev/null; then
        echo "" >> "$BASHRC"
        echo "# Gemini CLI + Superpowers" >> "$BASHRC"
        echo "$PATH_EXPORT" >> "$BASHRC"
        echo "   ✅ PATH updated in .bashrc"
    else
        echo "   ⚠️  PATH already in .bashrc"
    fi
fi

# Completion
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${NC}  ✅ Installation Complete!                              ${GREEN}║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}📋 What's Installed:${NC}"
echo "   ✅ Superpowers (30+ skills)"
echo "   ✅ MCP configuration"
echo "   ✅ Gemini CLI launcher"
echo "   ✅ Quick launcher (g command)"
echo ""
echo -e "${GREEN}🚀 Quick Start:${NC}"
echo "   g                    # YOLO mode"
echo "   gemini               # Normal mode"
echo "   gs                   # With Superpowers"
echo ""
echo -e "${GREEN}🛡️  Superpowers Commands:${NC}"
echo "   node ~/.gemini/superpowers/gemini-cli.js bootstrap"
echo "   node ~/.gemini/superpowers/gemini-cli.js find-skills"
echo ""
echo -e "${GREEN}💡 Tips:${NC}"
echo "   1. Restart terminal or: source ~/.bashrc"
echo "   2. Run: g --help"
echo "   3. Check: ~/.gemini/README.md"
echo ""
echo -e "${YELLOW}⚠️  Important:${NC}"
echo "   MCP servers work with Claude Code, not Gemini CLI directly"
echo ""
