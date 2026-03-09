@echo off
cd /d "%~dp0"
echo ============================================
echo  AGGIORNA MANIFEST E PUSHA SU GITHUB
echo ============================================
echo.

REM Genera automaticamente tutti i manifest dalla cartella docs/
echo [1/3] Genero manifest...
python genera_manifest.py
if errorlevel 1 (
    echo [ERRORE] Python non trovato o errore nello script.
    echo Assicurati che Python sia installato e nel PATH.
    pause
    exit /b 1
)

echo.
echo [2/3] Git add + commit...
git add -A
git status --short
git commit -m "Auto-update manifests"

echo.
echo [3/3] Push su GitHub...
git push origin main

echo.
echo ============================================
echo  FATTO! Le slide sono online su GitHub Pages
echo  (attendere 1-2 minuti per la propagazione)
echo ============================================
pause

