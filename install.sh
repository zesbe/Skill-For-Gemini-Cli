#!/bin/bash
# 🎯 Simple & Direct Installer: Gemini CLI + Superpowers + MCP
# Installs directly to ~/.gemini/ (no subfolders!)
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

# Clone or update repository directly to ~/.gemini/
echo -e "${BLUE}📥 Cloning repository to ~/.gemini/...${NC}"
if [ -d "$INSTALL_DIR" ]; then
    echo "   Updating existing installation..."
    cd "$INSTALL_DIR"
    git pull origin main 2>/dev/null || echo "   ⚠️  Could not update, using existing"
else
    git clone "$REPO_URL" "$INSTALL_DIR"
    echo "   ✅ Repository cloned"
fi

# Create launcher scripts
echo -e "${BLUE}🚀 Creating launcher scripts...${NC}"
mkdir -p "$NPM_BIN"

# Gemini launcher
cat > "$NPM_BIN/gemini" << 'LAUNCHER'
#!/bin/bash
# 🎯 Gemini CLI Launcher

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
alias sp-bootstrap='node ~/.gemini/gemini-cli.js bootstrap'
alias sp-list='node ~/.gemini/gemini-cli.js find-skills'
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
GEMINI_MEMORY="$INSTALL_DIR/GEMINI.md"
mkdir -p "$INSTALL_DIR"

if [ ! -f "$GEMINI_MEMORY" ]; then
    echo "## Gemini Added Memories" > "$GEMINI_MEMORY"
fi

if ! grep -q "Superpowers" "$GEMINI_MEMORY" 2>/dev/null; then
    echo "" >> "$GEMINI_MEMORY"
    echo "- I have 'Superpowers' installed at $INSTALL_DIR. Before starting complex software engineering tasks, I must run \`$INSTALL_DIR/gemini-cli.js bootstrap\` or \`find-skills\` to check for relevant workflows." >> "$GEMINI_MEMORY"
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
echo -e "${GREEN}📋 Structure:${NC}"
echo "   ~/.gemini/"
echo "   ├── skills/          # 30+ skills"
echo "   ├── mcp.json         # MCP config"
echo "   ├── gemini-cli.js    # CLI tool"
echo "   ├── agents/          # 14 agents"
echo "   ├── hooks/           # Hooks"
echo "   └── shell-aliases.sh # Aliases"
echo ""
echo -e "${GREEN}🚀 Quick Commands:${NC}"
echo "   g                    # YOLO mode (fast)"
echo "   gemini               # Normal mode"
echo ""
echo -e "${GREEN}🛡️  Superpowers Commands:${NC}"
echo "   node ~/.gemini/gemini-cli.js bootstrap"
echo "   node ~/.gemini/gemini-cli.js find-skills"
echo ""
echo -e "${GREEN}💡 Next Steps:${NC}"
echo "   1. Restart terminal: source ~/.bashrc"
echo "   2. Run: g 'Your prompt here'"
echo ""
echo -e "${YELLOW}⚠️  Note: MCP servers work with Claude Code${NC}"
