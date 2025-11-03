# Windsurf Auto-Fixer - One Command Solution
# Usage: irm https://raw.githubusercontent.com/amrpyt/windsurf-fixes/main/install.ps1 | iex

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

Clear-Host
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "                  Windsurf Auto-Fixer                      " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "This will fix:" -ForegroundColor White
Write-Host "  [1] Arabic text (RTL support)" -ForegroundColor Yellow
Write-Host "  [2] PowerShell command execution" -ForegroundColor Yellow
Write-Host ""
Write-Host "Press ENTER to continue or Ctrl+C to cancel..." -ForegroundColor Gray
$null = Read-Host

Clear-Host
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Step 1/4: Checking Windsurf installation..." -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

$windsurfPath = "$env:LOCALAPPDATA\Programs\Windsurf\resources\app\extensions\windsurf"
$extensionFile = Join-Path $windsurfPath "dist\extension.js"
$cascadePanelFile = Join-Path $windsurfPath "cascade-panel.html"

$patchesApplied = 0
$errors = 0

# Check if Windsurf is installed
if (-not (Test-Path $windsurfPath)) {
    Write-Host "[X] Windsurf not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Expected location:" -ForegroundColor Yellow
    Write-Host "  $windsurfPath" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Please install Windsurf first." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Press ENTER to exit..." -ForegroundColor Gray
    $null = Read-Host
    exit 1
}

Write-Host "[OK] Windsurf found at:" -ForegroundColor Green
Write-Host "     $windsurfPath" -ForegroundColor Gray
Write-Host ""
Write-Host "Press ENTER to continue..." -ForegroundColor Gray
$null = Read-Host

Clear-Host
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Step 2/4: Checking if Windsurf is running..." -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Check if Windsurf is running
$windsurfProcesses = Get-Process -Name "Windsurf" -ErrorAction SilentlyContinue
if ($windsurfProcesses) {
    Write-Host "[!] Windsurf is currently running!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "The patches require Windsurf to be closed." -ForegroundColor White
    Write-Host ""
    Write-Host "Close Windsurf now? (Y/N): " -ForegroundColor Cyan -NoNewline
    $response = Read-Host
    
    if ($response -eq "Y" -or $response -eq "y") {
        Write-Host ""
        Write-Host "Closing Windsurf..." -ForegroundColor Yellow
        Stop-Process -Name "Windsurf" -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
        Write-Host "[OK] Windsurf closed successfully" -ForegroundColor Green
        Write-Host ""
        Write-Host "Press ENTER to continue..." -ForegroundColor Gray
        $null = Read-Host
    } else {
        Write-Host ""
        Write-Host "Please close Windsurf manually and run this script again." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Press ENTER to exit..." -ForegroundColor Gray
        $null = Read-Host
        exit 1
    }
} else {
    Write-Host "[OK] Windsurf is not running" -ForegroundColor Green
    Write-Host ""
    Write-Host "Press ENTER to continue..." -ForegroundColor Gray
    $null = Read-Host
}

Clear-Host
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Step 3/4: Applying RTL Fix (Arabic support)..." -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $cascadePanelFile)) {
    Write-Host "[X] File not found!" -ForegroundColor Red
    Write-Host "    $cascadePanelFile" -ForegroundColor Gray
    $errors++
} else {
    $currentContent = Get-Content $cascadePanelFile -Raw -Encoding UTF8
    
    if ($currentContent -match "RTL_REGEX") {
        Write-Host "[OK] RTL fix already applied - skipping" -ForegroundColor Green
    } else {
        Write-Host "[*] Creating backup..." -ForegroundColor Yellow
        Copy-Item $cascadePanelFile "$cascadePanelFile.backup" -Force
        Write-Host "[OK] Backup created" -ForegroundColor Green
        Write-Host ""
        Write-Host "[*] Applying RTL fix..." -ForegroundColor Yellow
        
        $rtlContent = @'
<!doctype html>
<html>
  <head>
    <style>
      /* Minimal, professional RTL: no global direction override */
      /* Keep code blocks always LTR */
      pre, code, pre code {
        unicode-bidi: bidi-override !important;
        direction: ltr !important;
        text-align: left !important;
      }

      /* Lists: let dir decide side; keep markers outside (default) */
      ul, ol { unicode-bidi: normal !important; }
      ul[dir="rtl"], ol[dir="rtl"] { direction: rtl; }
      ul[dir="ltr"], ol[dir="ltr"] { direction: ltr; }
      li { list-style-position: outside; }

      /* Text alignment should follow direction automatically */
      p, li, div, span, h1, h2, h3, h4, h5, h6, blockquote, td, th {
        text-align: start;
      }

      /* Inputs: allow natural typing direction */
      textarea, input { unicode-bidi: plaintext; }
    </style>
  </head>
  <body style="margin: 0">
    <div id="react-app" class="react-app-container"></div>
    <script>
      (function () {
        const RTL_REGEX = /[\u0590-\u05FF\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB1D-\uFDFF\uFE70-\uFEFC]/;
        const TEXT_SELECTORS = 'p, li, div, span, h1, h2, h3, h4, h5, h6, blockquote, td, th';

        const getText = (el) => (el && (el.innerText || el.textContent) || '').trim();
        const isRTL = (s) => RTL_REGEX.test(s);

        function setDirAuto(el) {
          if (el.closest && el.closest('pre, code')) return;
          if (el.tagName && el.tagName.toLowerCase() === 'li') {
            const t = getText(el);
            if (!t) return;
            el.setAttribute('dir', isRTL(t) ? 'rtl' : 'ltr');
            const list = el.parentElement;
            if (list && list.matches && list.matches('ul,ol')) {
              const first = Array.from(list.querySelectorAll(':scope > li')).find(li => getText(li));
              if (first) list.setAttribute('dir', first.getAttribute('dir') || (isRTL(getText(first)) ? 'rtl' : 'ltr'));
            }
          } else {
            el.setAttribute('dir', 'auto');
          }
        }

        function apply(root = document) {
          root.querySelectorAll(TEXT_SELECTORS).forEach(setDirAuto);
        }

        const observer = new MutationObserver((mutations) => {
          for (const m of mutations) {
            if (m.type === 'childList') {
              m.addedNodes.forEach((n) => { if (n.nodeType === 1) apply(n); });
            } else if (m.type === 'characterData') {
              const p = m.target && m.target.parentElement; if (p) setDirAuto(p);
            }
          }
        });

        apply();
        observer.observe(document.body, { childList: true, subtree: true, characterData: true });
      })();
    </script>
  </body>
</html>
'@
        
        Set-Content $cascadePanelFile -Value $rtlContent -Encoding UTF8 -Force
        Write-Host "[OK] RTL fix applied successfully!" -ForegroundColor Green
        $patchesApplied++
    }
}

Write-Host ""
Write-Host "Press ENTER to continue..." -ForegroundColor Gray
$null = Read-Host

Clear-Host
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Step 4/4: Applying Command Execution Fix..." -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $extensionFile)) {
    Write-Host "[X] File not found!" -ForegroundColor Red
    Write-Host "    $extensionFile" -ForegroundColor Gray
    $errors++
} else {
    $content = Get-Content $extensionFile -Raw -Encoding UTF8
    
    if ($content -notmatch "Invoke-Expression") {
        Write-Host "[OK] Command fix already applied - skipping" -ForegroundColor Green
    } else {
        Write-Host "[*] Creating backup..." -ForegroundColor Yellow
        Copy-Item $extensionFile "$extensionFile.backup" -Force
        Write-Host "[OK] Backup created" -ForegroundColor Green
        Write-Host ""
        Write-Host "[*] Applying command execution fix..." -ForegroundColor Yellow
        
        $oldCode = 'prepareCommandForExecution(e,t){const n=(0,y.getShellNameFromShellPath)(a.env.shell);return"powershell"===n||"pwsh"===n?`Invoke-Expression ${JSON.stringify(e)}`:"bash"===n||"zsh"===n?`eval ${t}`:e}'
        $newCode = 'prepareCommandForExecution(e,t){const n=(0,y.getShellNameFromShellPath)(a.env.shell);return e}'
        
        if ($content -match [regex]::Escape($oldCode)) {
            $content = $content -replace [regex]::Escape($oldCode), $newCode
            Set-Content $extensionFile -Value $content -Encoding UTF8 -Force -NoNewline
            Write-Host "[OK] Command execution fix applied successfully!" -ForegroundColor Green
            $patchesApplied++
        } else {
            Write-Host "[!] Warning: Could not find exact code pattern" -ForegroundColor Yellow
            Write-Host "    The file structure might have changed" -ForegroundColor Gray
        }
    }
}

Write-Host ""
Write-Host "Press ENTER to see results..." -ForegroundColor Gray
$null = Read-Host

Clear-Host
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "                      COMPLETE!                             " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

if ($errors -eq 0 -and $patchesApplied -gt 0) {
    Write-Host "[SUCCESS] All patches applied successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "What was fixed:" -ForegroundColor White
    Write-Host "  [OK] Arabic text (RTL support)" -ForegroundColor Green
    Write-Host "  [OK] PowerShell command execution" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next step:" -ForegroundColor Cyan
    Write-Host "  Restart Windsurf to apply changes" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Backups created at:" -ForegroundColor White
    Write-Host "  $windsurfPath" -ForegroundColor Gray
} elseif ($patchesApplied -eq 0 -and $errors -eq 0) {
    Write-Host "[OK] All patches were already applied!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your Windsurf is already fixed." -ForegroundColor White
    Write-Host "No action needed." -ForegroundColor White
} else {
    Write-Host "[WARNING] Some patches failed!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Patches applied: $patchesApplied" -ForegroundColor White
    Write-Host "Errors: $errors" -ForegroundColor Red
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press ENTER to exit..." -ForegroundColor Gray
$null = Read-Host
