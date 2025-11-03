# 🔧 Windsurf Fixes

> Fix Windsurf RTL + PowerShell issues with **ONE interactive command**!

[![GitHub](https://img.shields.io/badge/GitHub-amrpyt-blue?logo=github)](https://github.com/amrpyt/windsurf-fixes)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 🚀 One Command Installation

```powershell
irm https://raw.githubusercontent.com/amrpyt/windsurf-fixes/main/install.ps1 | iex
```

**That's it!** Just press ENTER through the interactive steps.

---

## 🎯 What It Fixes

### Problem 1: Arabic Text (RTL)
- **Before:** Arabic displays left-to-right ❌
- **After:** Arabic displays right-to-left correctly ✅

### Problem 2: PowerShell Commands
- **Before:** Commands fail with parameter errors ❌
- **After:** All commands work perfectly ✅

**Example of fixed commands:**
```powershell
Test-Path "$env:LOCALAPPDATA\Programs"              # ✅ Works
Get-ChildItem -Path "C:\Windows" -Filter "*.exe"    # ✅ Works
Copy-Item -Path "source" -Destination "dest"        # ✅ Works
```

---

## 📺 How It Works

The installer is **fully interactive**:

1. **Welcome Screen** - Shows what will be fixed
2. **Check Installation** - Verifies Windsurf is installed
3. **Close Windsurf** - Asks to close if running
4. **Apply RTL Fix** - Adds Arabic support
5. **Apply Command Fix** - Fixes PowerShell execution
6. **Complete** - Shows results and next steps

**Just press ENTER at each step!**

---

## 🎬 Example Session

```
============================================================
                  Windsurf Auto-Fixer                      
============================================================

This will fix:
  [1] Arabic text (RTL support)
  [2] PowerShell command execution

Press ENTER to continue or Ctrl+C to cancel...
█
```

*Press ENTER 4 times and you're done!*

---

## ✨ Features

- ✅ **Interactive** - Clear steps with colored output
- ✅ **Safe** - Creates automatic backups
- ✅ **Smart** - Detects if already patched
- ✅ **Clean** - No files left on your computer
- ✅ **Universal** - Works on any Windows machine
- ✅ **Simple** - One command, that's it!

---

## 🔄 When To Use

### After Every Windsurf Update
Windsurf updates reset the files. Just run the command again:

```powershell
irm https://raw.githubusercontent.com/amrpyt/windsurf-fixes/main/install.ps1 | iex
```

### On Any Computer
Works on:
- Your computer
- Friend's computer
- Work computer
- Any Windows machine with Windsurf

**No setup required!**

---

## 🛠️ What Gets Modified

The installer modifies two files in your Windsurf installation:

1. **`cascade-panel.html`** - Adds RTL (right-to-left) support for Arabic text
2. **`extension.js`** - Removes `Invoke-Expression` wrapper that causes command failures

**Automatic backups** are created with `.backup` extension.

---

## 🔍 Technical Details

### The Root Cause

Windsurf wraps PowerShell commands incorrectly:

```javascript
// Problematic code
return `Invoke-Expression ${JSON.stringify(command)}`
// This causes double escaping: \ → \\
```

### The Fix

We remove the wrapper:

```javascript
// Fixed code
return command  // Direct execution
```

Simple and effective! ✅

---

## 🐛 Troubleshooting

### "Cannot be loaded because running scripts is disabled"

Run this first:
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

Then run the installer again.

### "Windsurf not found"

Make sure Windsurf is installed at:
```
C:\Users\YOUR_USERNAME\AppData\Local\Programs\Windsurf
```

### Script doesn't work after update

Windsurf might have changed the code structure. Open an [issue](https://github.com/amrpyt/windsurf-fixes/issues) and we'll update the fix.

---

## 🤝 Contributing

Found a bug? Have a suggestion?

1. Open an [issue](https://github.com/amrpyt/windsurf-fixes/issues)
2. Submit a [pull request](https://github.com/amrpyt/windsurf-fixes/pulls)
3. Star the repo ⭐ if it helped you!

---

## 📜 License

MIT License - Feel free to use, modify, and share!

---

## 🌟 Show Your Support

If this helped you, please:
- ⭐ Star this repository
- 🐦 Share on Twitter
- 💬 Tell your friends

---

## 📞 Contact

- **GitHub:** [@amrpyt](https://github.com/amrpyt)
- **Website:** [amrai.rf.gd](https://amrai.rf.gd)
- **Twitter:** [@amrpyt](https://twitter.com/amrpyt)

---

## 🎯 Quick Links

- [One Command](#-one-command-installation)
- [What It Fixes](#-what-it-fixes)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)

---

**Made with ❤️ for the Windsurf community**

---

<div align="center">

### 🚀 Ready to fix your Windsurf?

```powershell
irm https://raw.githubusercontent.com/amrpyt/windsurf-fixes/main/install.ps1 | iex
```

**One command. Four ENTER presses. Done!** ✅

</div>
