# Skill Superpowers untuk Gemini CLI

Proyek ini menghadirkan kemampuan **Superpowers** (workflow pengembangan software tingkat lanjut) ke dalam lingkungan Gemini CLI. Ini kompatibel dengan **Android (Termux), macOS, Linux, dan Windows**.

## 🚀 Instalasi Otomatis (Auto-Detect)

Salin dan jalankan perintah berikut di terminal Anda. Script ini akan otomatis mendeteksi sistem operasi Anda dan melakukan instalasi.

### Android (Termux), macOS, & Linux

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zesbe/Skill-For-Gemini-Cli/main/install.sh)"
```

### Windows

1. Pastikan Anda telah menginstal **Git** dan **Node.js**.
2. Buka **PowerShell** sebagai Administrator.
3. Clone repository ini:
   ```powershell
   git clone https://github.com/zesbe/Skill-For-Gemini-Cli.git $HOME\.gemini\superpowers
   ```
4. Buat alias (opsional, tambahkan ke `$PROFILE`):
   ```powershell
   Set-Alias gemini-superpowers "$HOME\.gemini\superpowers\gemini-cli.js"
   ```

## 🛠️ Fitur & Penggunaan

Setelah terinstal, Anda dapat mengakses tool ini menggunakan perintah `gemini-superpowers`.

### 1. Menampilkan Semua Skill
Melihat daftar kemampuan yang tersedia untuk Gemini Anda.

```bash
gemini-superpowers find-skills
```

### 2. Menggunakan Skill Tertentu
Memuat instruksi skill tertentu agar Gemini dapat menggunakannya.

```bash
gemini-superpowers use-skill superpowers:brainstorming
```
Contoh skill populer:
- `superpowers:brainstorming` - Untuk merancang fitur sebelum coding.
- `superpowers:test-driven-development` - Workflow TDD (Red-Green-Refactor).
- `superpowers:systematic-debugging` - Panduan debugging sistematis.

### 3. Bootstrap (Inisialisasi)
Memuat semua konfigurasi awal.

```bash
gemini-superpowers bootstrap
```

## ⚡ Otomatisasi (Agar Gemini Pintar Sendiri)

Agar Anda tidak perlu mengetik perintah terus-menerus, mintalah Gemini untuk **mengingat** keberadaan tools ini.

Ketik perintah ini di chat Gemini Anda:

> "Harap ingat ini: Saya telah menginstal Superpowers di `~/.gemini/superpowers`. Setiap kali saya meminta tugas coding yang kompleks (seperti debugging, fitur baru, atau refactor), kamu WAJIB mengecek skill yang tersedia dengan menjalankan `~/.gemini/superpowers/gemini-cli.js find-skills` dan menggunakan skill yang relevan (seperti TDD atau Brainstorming) sebelum menulis kode."

Setelah Gemini menyimpan ingatan ini, ia akan otomatis "berpikir" menggunakan Superpowers setiap kali Anda memberinya tugas berat.

## 📱 Dukungan Platform

| Platform | Status | Catatan |
|----------|--------|---------|
| **Android** | ✅ Stabil | Gunakan Termux. Script install otomatis akan menginstal Node.js & Git. |
| **Linux** | ✅ Stabil | Diuji pada Ubuntu/Debian. Mendukung apt/yum. |
| **macOS** | ✅ Stabil | Membutuhkan Homebrew untuk instalasi dependencies otomatis. |
| **Windows** | ⚠️ Manual | Jalankan via PowerShell atau Git Bash. |

## 📂 Struktur Direktori

Tool ini akan diinstal ke folder:
`~/.gemini/superpowers`

## 🤝 Kontribusi

Silakan fork repository ini dan kirim Pull Request jika Anda ingin menambahkan skill baru atau memperbaiki bug.

---
**Credits:** Based on the original [Superpowers](https://github.com/obra/superpowers) by obra, adapted for Gemini CLI.