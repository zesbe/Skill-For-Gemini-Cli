# 🎯 Gemini CLI + Superpowers + MCP

Proyek ini menghadirkan **Superpowers** (30+ workflow skills) + **MCP servers configuration** ke Gemini CLI untuk pengembangan software tingkat lanjut.

## 🚀 Instalasi Cepat (Termux & Linux)

```bash
# One-line installer
curl -fsSL https://raw.githubusercontent.com/zesbe/Skill-For-Gemini-Cli/main/install.sh | bash
```

## 📦 Yang Included

| Fitur | Status | Deskripsi |
|-------|--------|-----------|
| **Superpowers** | ✅ | 30+ development workflow skills |
| **MCP Config** | ✅ | 6 MCP servers (Context7, Exa, Memory, etc.) |
| **YOLO Mode** | ✅ | Skip semua konfirmasi - cepat! |
| **Quick Launcher** | ✅ | Command `g` untuk akses cepat |

## 🚀 Quick Start

```bash
# YOLO Mode (RECOMMENDED - tanpa konfirmasi)
g "Buatin API endpoint untuk user CRUD"

# Normal Mode
gemini

# Dengan Superpowers
gs

# Superpowers bootstrap
node ~/.gemini/gemini-cli.js bootstrap
node ~/.gemini/gemini-cli.js find-skills
```

## 🎯 Available Commands

| Command | Description |
|---------|-------------|
| `g` | Quick YOLO launch |
| `gemini` | Normal launcher |
| `gs` | Gemini + Superpowers |
| `launch-gemini.sh --yolo` | Standalone script |

## 🛡️ Available Skills (30+)

### Planning & Design
- `superpowers:brainstorming` - Design refinement
- `superpowers:writing-plans` - Create implementation plans
- `superpowers:executing-plans` - Execute plans in batches

### Development
- `superpowers:test-driven-development` - TDD workflow
- `superpowers:subagent-driven-development` - Agent-based dev
- `superpowers:refactoring` - Code refactoring
- `superpowers:api-development` - API development
- `superpowers:database-development` - Database design

### Code Quality
- `superpowers:requesting-code-review` - Code review
- `superpowers:security-review` - Security audit
- `superpowers:ui-ux-review` - UI/UX evaluation

### Debugging
- `superpowers:systematic-debugging` - Systematic debugging
- `superpowers:root-cause-tracing` - Root cause analysis
- `superpowers:integration-testing` - Integration tests

### Deployment
- `superpowers:deployment` - Deployment workflow
- `superpowers:using-git-worktrees` - Git worktrees
- `superpowers:finishing-a-development-branch` - Branch completion

## 🔌 MCP Servers (for Claude Code)

MCP configuration included in `~/.gemini/mcp.json`:

- **context7** - Documentation lookup
- **exa** - Web search
- **memory** - Persistent memory
- **sequential-thinking** - Complex reasoning
- **filesystem** - File operations
- **fetch** - HTTP requests

> ⚠️ **Note:** MCP servers work with Claude Code, not Gemini CLI directly.

## 📱 Dukungan Platform

| Platform | Status |
|----------|--------|
| **Termux (Android)** | ✅ Stabil |
| **Linux** | ✅ Stabil |
| **macOS** | ✅ Stabil |
| **Windows** | ⚠️ Manual setup |

## 📁 Lokasi Instalasi

Installs directly to `~/.gemini/`:

```
~/.gemini/
├── skills/          # 30+ skills
├── mcp.json         # MCP configuration
├── gemini-cli.js    # CLI tool
├── agents/          # 14 agents
├── hooks/           # Hooks
└── shell-aliases.sh # Aliases
```

## 🔧 Manual Installation

```bash
# Clone repository directly to ~/.gemini/
git clone https://github.com/zesbe/Skill-For-Gemini-Cli.git ~/.gemini

# Create launcher
cat > ~/.npm-global/bin/gemini << 'EOF'
#!/bin/bash
export NODE_PATH="/data/data/com.termux/files/usr/lib/node_modules"
cd /data/data/com.termux/files/usr/lib/node_modules/@google/gemini-cli
exec node dist/index.js "$@"
EOF
chmod +x ~/.npm-global/bin/gemini

# Add to PATH
export PATH="$HOME/.npm-global/bin:$PATH"
```

## 📚 Dokumentasi

- [Superpowers Original](https://github.com/obra/superpowers)
- [Claude Code](https://claude.com/cli)
- [Gemini CLI](https://github.com/google-gemini/gemini-cli)

## 🤝 Kontribusi

Fork dan PR untuk menambahkan skill baru atau improve installer.

---

**Credits:** Based on [Superpowers](https://github.com/obra/superpowers) by obra
