#!/bin/bash
# 🎯 Complete Installer: Gemini CLI + Superpowers + MCP
# For Termux, Linux, macOS
# Usage: curl -fsSL https://raw.githubusercontent.com/zesbe/Skill-For-Gemini-Cli/main/install.sh | bash

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
echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Configuration
REPO_URL="https://github.com/zesbe/Skill-For-Gemini-Cli.git"
SUPERPOWERS_DIR="$HOME/.gemini/superpowers"
INSTALL_DIR="$HOME/.gemini"
NPM_BIN="$HOME/.npm-global/bin"

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)
        if [ -d "/data/data/com.termux" ]; then
            MACHINE="Termux (Android)"
        else
            MACHINE="Linux"
        fi
        ;;
    Darwin*)    MACHINE="macOS";;
    CYGWIN*|MINGW*)    MACHINE="Windows";;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo -e "${GREEN}Platform: $MACHINE${NC}"

# Check dependencies
echo -e "${BLUE}📦 Checking dependencies...${NC}"

if ! command -v git > /dev/null 2>&1; then
    echo -e "${YELLOW}Git not found. Please install git first.${NC}"
    exit 1
fi

if ! command -v node > /dev/null 2>&1; then
    echo -e "${YELLOW}Node.js not found. Please install Node.js first.${NC}"
    exit 1
fi

echo "   ✅ Git and Node.js found"

# Clone or update repository
echo -e "${BLUE}📥 Setting up Superpowers...${NC}"
if [ -d "$SUPERPOWERS_DIR" ]; then
    echo "   Updating existing installation..."
    cd "$SUPERPOWERS_DIR"
    git pull origin main 2>/dev/null || echo "   ⚠️  Could not update, using existing"
else
    git clone "$REPO_URL" "$SUPERPOWERS_DIR"
    echo "   ✅ Repository cloned"
fi

# Setup MCP config
echo -e "${BLUE}🔌 Setting up MCP configuration...${NC}"
mkdir -p "$INSTALL_DIR"
if [ -f "$SUPERPOWERS_DIR/mcp.json" ]; then
    cp "$SUPERPOWERS_DIR/mcp.json" "$INSTALL_DIR/mcp.json"
    echo "   ✅ MCP config installed"
else
    echo "   ⚠️  MCP config not found in repo"
fi

# Create launcher scripts
echo -e "${BLUE}🚀 Creating launcher scripts...${NC}"
mkdir -p "$NPM_BIN"

# Gemini launcher
cat > "$NPM_BIN/gemini" << 'LAUNCHER'
#!/bin/bash
# 🎯 Gemini CLI Launcher with Superpowers + YOLO Mode

export NODE_PATH="/data/data/com.termux/files/usr/lib/node_modules"
export TMPDIR="$HOME/.tmp/gemini-temp"
mkdir -p "$TMPDIR" 2>/dev/null || true

cd /data/data/com.termux/files/usr/lib/node_modules/@google/gemini-cli
exec node dist/index.js "$@"
LAUNCHER
chmod +x "$NPM_BIN/gemini"
echo "   ✅ gemini launcher created"

# Quick YOLO launcher
cat > "$NPM_BIN/g" << 'YOLO'
#!/bin/bash
export PATH="/data/data/com.termux/files/home/.npm-global/bin:$PATH"
exec gemini --yolo "$@"
YOLO
chmod +x "$NPM_BIN/g"
echo "   ✅ g (YOLO) launcher created"

# Standalone launcher
cat > "$HOME/launch-gemini.sh" << 'SCRIPT'
#!/bin/bash
# 🚀 Quick Gemini CLI Launcher
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

# Create shell aliases
cat > "$INSTALL_DIR/shell-aliases.sh" << 'ALIASES'
# 🚀 Quick aliases untuk Gemini CLI
alias g='gemini --yolo --no-superpowers'
alias gs='gemini --yolo'
alias sp-bootstrap='node ~/.gemini/superpowers/gemini-cli.js bootstrap'
alias sp-list='node ~/.gemini/superpowers/gemini-cli.js find-skills'
ALIASES
echo "   ✅ shell-aliases.sh created"

# Add to PATH
echo -e "${BLUE}🔧 Updating PATH...${NC}"
if ! grep -q "$NPM_BIN" "$HOME/.bashrc" 2>/dev/null; then
    echo "" >> "$HOME/.bashrc"
    echo "# Gemini CLI + Superpowers" >> "$HOME/.bashrc"
    echo "export PATH=\"$NPM_BIN:\$PATH\"" >> "$HOME/.bashrc"
    echo "   ✅ PATH updated in .bashrc"
fi

# Setup Gemini memory
echo -e "${BLUE}🧠 Setting up Gemini memory...${NC}"
GEMINI_MEMORY="$HOME/.gemini/GEMINI.md"
mkdir -p "$HOME/.gemini"

if [ ! -f "$GEMINI_MEMORY" ]; then
    echo "## Gemini Added Memories" > "$GEMINI_MEMORY"
fi

if ! grep -q "Superpowers" "$GEMINI_MEMORY" 2>/dev/null; then
    echo "" >> "$GEMINI_MEMORY"
    echo "- I have 'Superpowers' installed at $SUPERPOWERS_DIR. Before starting complex software engineering tasks, I must run \`$SUPERPOWERS_DIR/gemini-cli.js bootstrap\` or \`find-skills\` to check for relevant workflows." >> "$GEMINI_MEMORY"
    echo "   ✅ Memory injected"
else
    echo "   ⚠️  Memory already exists"
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
echo "   ✅ Gemini CLI launcher (gemini)"
echo "   ✅ Quick launcher (g)"
echo ""
echo -e "${GREEN}🚀 Quick Commands:${NC}"
echo "   g                    # YOLO mode (fast)"
echo "   gemini               # Normal mode"
echo "   bash ~/launch-gemini.sh --yolo  # Quick script"
echo ""
echo -e "${GREEN}🛡️  Superpowers Commands:${NC}"
echo "   node ~/.gemini/superpowers/gemini-cli.js bootstrap"
echo "   node ~/.gemini/superpowers/gemini-cli.js find-skills"
echo ""
echo -e "${GREEN}💡 Next Steps:${NC}"
echo "   1. Restart terminal or: source ~/.bashrc"
echo "   2. Run: g 'Your prompt here'"
echo "   3. Check: ~/.gemini/README.md"
echo ""
echo -e "${YELLOW}⚠️  Note: MCP servers work with Claude Code, not Gemini CLI${NC}"
