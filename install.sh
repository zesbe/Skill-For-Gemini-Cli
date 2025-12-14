#!/bin/bash

set -e

REPO_URL="https://github.com/zesbe/Skill-For-Gemini-Cli.git"
INSTALL_DIR="$HOME/.gemini/superpowers"
BIN_NAME="gemini-superpowers"

# Warna untuk output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Installer Skill Superpowers untuk Gemini CLI ===${NC}"

# 1. Deteksi OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     
        if [ -d "/data/data/com.termux" ]; then
            MACHINE="Android (Termux)"
        else
            MACHINE="Linux"
        fi
        ;;
    Darwin*)    MACHINE="Mac";;
    CYGWIN*)    MACHINE="Cygwin";;
    MINGW*)     MACHINE="MinGw";;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo -e "${GREEN}Sistem Terdeteksi: $MACHINE${NC}"

# 2. Cek Dependencies (Git & Node.js)
echo -e "${BLUE}Memeriksa dependencies...${NC}"

install_deps() {
    if [ "$MACHINE" = "Android (Termux)" ]; then
        pkg update -y && pkg install git nodejs -y
    elif [ "$MACHINE" = "Linux" ]; then
        if command -v apt-get > /dev/null 2>&1; then
            sudo apt-get update && sudo apt-get install -y git nodejs
        elif command -v yum > /dev/null 2>&1; then
            sudo yum install -y git nodejs
        fi
    elif [ "$MACHINE" = "Mac" ]; then
        if ! command -v brew > /dev/null 2>&1; then
             echo "Homebrew tidak ditemukan. Silakan install git dan nodejs secara manual."
        else
             brew install git node
        fi
    fi
}

if ! command -v git > /dev/null 2>&1; then
    echo "Git tidak ditemukan. Mencoba menginstall..."
    install_deps
fi

if ! command -v node > /dev/null 2>&1; then
    echo "Node.js tidak ditemukan. Mencoba menginstall..."
    install_deps
fi

# 3. Clone / Update Repository
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${BLUE}Direktori sudah ada, melakukan update...${NC}"
    cd "$INSTALL_DIR"
    git pull
else
    echo -e "${BLUE}Cloning repository ke $INSTALL_DIR...${NC}"
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# 4. Setup Permissions
echo -e "${BLUE}Mengatur permissions...${NC}"
chmod +x "$INSTALL_DIR/gemini-cli.js"

# 5. Setup Alias
echo -e "${BLUE}Mengonfigurasi alias...${NC}"
SHELL_CONFIG=""
if [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

if [ -n "$SHELL_CONFIG" ]; then
    if ! grep -q "gemini-superpowers" "$SHELL_CONFIG"; then
        echo "" >> "$SHELL_CONFIG"
        echo "# Gemini Superpowers Alias" >> "$SHELL_CONFIG"
        echo "alias $BIN_NAME='$INSTALL_DIR/gemini-cli.js'" >> "$SHELL_CONFIG"
        echo -e "${GREEN}Alias '$BIN_NAME' ditambahkan ke $SHELL_CONFIG${NC}"
    else
        echo "Alias sudah ada di $SHELL_CONFIG"
    fi
else
    echo -e "${RED}Tidak dapat menemukan file konfigurasi shell (.bashrc/.zshrc).${NC}"
    echo "Silakan tambahkan manual: alias $BIN_NAME='$INSTALL_DIR/gemini-cli.js'"
fi

# 6. Setup Memory (Otomatisasi)
echo -e "${BLUE}Menyuntikkan Memori Gemini...${NC}"
GEMINI_MEMORY_FILE="$HOME/.gemini/GEMINI.md"
MEMORY_TEXT="- I have 'Superpowers' installed at $INSTALL_DIR. Before starting complex software engineering tasks (designing, refactoring, debugging), I must run \`$INSTALL_DIR/gemini-cli.js bootstrap\` or \`find-skills\` to check for relevant workflows like brainstorming, TDD, or systematic debugging, and use them if applicable."

# Pastikan direktori .gemini ada
mkdir -p "$HOME/.gemini"

if [ ! -f "$GEMINI_MEMORY_FILE" ]; then
    echo "## Gemini Added Memories" > "$GEMINI_MEMORY_FILE"
fi

if ! grep -q "Superpowers" "$GEMINI_MEMORY_FILE"; then
    echo "$MEMORY_TEXT" >> "$GEMINI_MEMORY_FILE"
    echo -e "${GREEN}Memori otomatis berhasil ditambahkan!${NC}"
else
    echo "Memori sudah ada."
fi

echo -e "${GREEN}=== Instalasi Selesai! ===${NC}"
echo "Silakan restart terminal Anda atau jalankan: source $SHELL_CONFIG"
echo "Ketik '$BIN_NAME find-skills' untuk memulai."
echo "Gemini sekarang sudah otomatis mengetahui keberadaan skill ini."
