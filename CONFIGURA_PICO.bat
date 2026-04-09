@echo off
cd /d "%~dp0"
echo ============================================
echo  CONFIGURA CASCHETTO PICO - LabEconomia
echo ============================================
echo.
echo  Collega il PICO via USB e assicurati che
echo  ADB sia installato e nel PATH.
echo.
echo  Seleziona il numero del caschetto:
echo    1 = student001
echo    2 = student002
echo    3 = student003
echo    4 = student004
echo    5 = student005
echo.
set /p SCELTA="Numero caschetto (1-5): "

if "%SCELTA%"=="1" set STUDENT_ID=student001
if "%SCELTA%"=="2" set STUDENT_ID=student002
if "%SCELTA%"=="3" set STUDENT_ID=student003
if "%SCELTA%"=="4" set STUDENT_ID=student004
if "%SCELTA%"=="5" set STUDENT_ID=student005

if not defined STUDENT_ID (
    echo [ERRORE] Scelta non valida. Inserisci un numero da 1 a 5.
    pause
    exit /b 1
)

echo.
echo  Configuro il caschetto come: %STUDENT_ID%
echo.

:: Crea il file student_config.json temporaneo
echo { "studentId": "%STUDENT_ID%" } > _temp_config.json

:: Verifica che ADB veda il dispositivo
adb devices | findstr /r /c:"device$" >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERRORE] Nessun dispositivo PICO trovato.
    echo   - Collega il PICO via USB
    echo   - Abilita Debug USB nelle impostazioni sviluppatore
    echo   - Accetta il popup di autorizzazione sul PICO
    del _temp_config.json >nul 2>&1
    pause
    exit /b 1
)

:: Pusha il config sul PICO
set PICO_PATH=/sdcard/Android/data/com.unity.vrtemplate/files/
echo  Push su %PICO_PATH%...

:: Crea la cartella se non esiste
adb shell mkdir -p %PICO_PATH% >nul 2>&1

:: Pusha il file
adb push _temp_config.json %PICO_PATH%student_config.json

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ============================================
    echo  OK! Caschetto configurato come %STUDENT_ID%
    echo  Al prossimo avvio dell'app scarichera' le
    echo  slide dalla cartella %STUDENT_ID% su GitHub.
    echo ============================================
) else (
    echo.
    echo [ERRORE] Push fallito. Verifica la connessione USB.
)

:: Cleanup
del _temp_config.json >nul 2>&1
echo.
pause

