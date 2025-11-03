# 🔧 Windsurf Fixes

> Fix Windsurf RTL + PowerShell issues with **ONE interactive command**!

[![GitHub](https://img.shields.io/badge/GitHub-amrpyt-blue?logo=github)](https://github.com/amrpyt/windsurf-fixes)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Version](https://img.shields.io/badge/Windsurf-v1.12.21-orange)](https://github.com/amrpyt/windsurf-fixes)

## 🚀 One Command Installation

```powershell
irm https://raw.githubusercontent.com/amrpyt/windsurf-fixes/main/install.ps1 | iex
```

**That's it!** Just press ENTER through the interactive steps.

---

## ⚠️ Important Version Notice

**This fix is tested and confirmed working on:**
- **Windsurf v1.12.21** (October 2025 build)

**For the Command Execution fix specifically:**
- If you're using a **newer version** of Windsurf, the command fix might not work
- This could mean Windsurf **already fixed the issue** in newer versions! 🎉
- Or the code structure changed and needs updating

**The RTL fix works on all versions.**

If the command fix doesn't apply, please:
1. Test if PowerShell commands work correctly
2. If they work, great! Windsurf fixed it
3. If they don't work, [open an issue](https://github.com/amrpyt/windsurf-fixes/issues)

---

## 🎯 What It Fixes

### Problem 1: Arabic Text (RTL) ✅ All Versions
- **Before:** Arabic displays left-to-right ❌
- **After:** Arabic displays right-to-left correctly ✅

### Problem 2: PowerShell Commands ⚠️ v1.12.21 Only
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

1. **Welcome Screen** - Shows what will be fixed + version info
2. **Check Installation** - Verifies Windsurf is installed
3. **Close Windsurf** - Asks to close if running
4. **Apply RTL Fix** - Adds Arabic support (all versions)
5. **Apply Command Fix** - Fixes PowerShell execution (v1.12.21)
6. **Complete** - Shows results and next steps

**Just press ENTER at each step!**

---

## 🎬 Example Session

```
============================================================
                  Windsurf Auto-Fixer                      
                     v1.12.21                              
============================================================

This will fix:
  [1] Arabic text (RTL support)
  [2] PowerShell command execution (v1.12.21)

NOTE: Command fix is tested on Windsurf v1.12.21
      Newer versions might already have this fixed.

Press ENTER to continue or Ctrl+C to cancel...
█
```

*Press ENTER 4 times and you're done!*

---

## ✨ Features

- ✅ **Interactive** - Clear steps with colored output
- ✅ **Safe** - Creates automatic backups
- ✅ **Smart** - Detects if already patched
- ✅ **Version-Aware** - Warns about version compatibility
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

**Note:** If you update to a version newer than v1.12.21:
- The RTL fix will still work ✅
- The command fix might not apply (Windsurf may have fixed it) ⚠️
- Check if commands work - if yes, you're good!

### On Any Computer
Works on:
- Your computer
- Friend's computer
- Work computer
- Any Windows machine with Windsurf v1.12.21

**No setup required!**

---

## 🛠️ What Gets Modified

The installer modifies two files in your Windsurf installation:

1. **`cascade-panel.html`** - Adds RTL (right-to-left) support for Arabic text
   - ✅ Works on all Windsurf versions

2. **`extension.js`** - Removes `Invoke-Expression` wrapper that causes command failures
   - ⚠️ Tested on v1.12.21 only
   - May not work on newer versions (they might have fixed it!)

**Automatic backups** are created with `.backup` extension.

---

## 🔍 Technical Details

### The Root Cause (v1.12.21)

Windsurf v1.12.21 wraps PowerShell commands incorrectly:

```javascript
// Problematic code in v1.12.21
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

**Note:** Newer Windsurf versions might use a different approach or have this fixed already.

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

### "Could not find exact code pattern"

This message appears when the command fix can't find the problematic code. This could mean:

1. ✅ **Good news!** Windsurf already fixed this issue in your version
2. ⚠️ You're using a different version (not v1.12.21)
3. ⚠️ The code structure changed

**What to do:**
1. Test if PowerShell commands work correctly
2. If they work → Great! No action needed
3. If they don't work → [Open an issue](https://github.com/amrpyt/windsurf-fixes/issues) with your Windsurf version

### How to check your Windsurf version

```powershell
(Get-ItemProperty "C:\Users\$env:USERNAME\AppData\Local\Programs\Windsurf\Windsurf.exe").VersionInfo.FileVersion
```

---

## 📋 Version Compatibility

| Windsurf Version | RTL Fix | Command Fix | Status |
|------------------|---------|-------------|--------|
| v1.12.21 | ✅ Works | ✅ Works | Tested |
| Newer versions | ✅ Works | ⚠️ Unknown | May be fixed by Windsurf |
| Older versions | ✅ Works | ❓ Untested | Unknown |

---

## 🤝 Contributing

Found a bug? Have a suggestion? Using a different version?

1. Open an [issue](https://github.com/amrpyt/windsurf-fixes/issues)
2. Include your Windsurf version
3. Submit a [pull request](https://github.com/amrpyt/windsurf-fixes/pulls)
4. Star the repo ⭐ if it helped you!

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
- [Version Notice](#️-important-version-notice)
- [What It Fixes](#-what-it-fixes)
- [Troubleshooting](#-troubleshooting)
- [Version Compatibility](#-version-compatibility)

---

**Made with ❤️ for the Windsurf community**

---

<div align="center">

### 🚀 Ready to fix your Windsurf?

```powershell
irm https://raw.githubusercontent.com/amrpyt/windsurf-fixes/main/install.ps1 | iex
```

**One command. Four ENTER presses. Done!** ✅

**Tested on Windsurf v1.12.21**

</div>
