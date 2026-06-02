@echo off
echo ============================================================
echo      Instagram Unfollower - Installation and Build Tool
echo ============================================================
echo.

:: Check if Node.js is installed
where node >nul 2>nul
if %errorlevel% neq 0 (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host '[ERROR] Node.js bulunamadi! Bu projeyi derlemek icin bilgisayarinizda Node.js kurulu olmalidir.' -ForegroundColor Red"
    echo.
    echo Node.js indirmek icin: https://nodejs.org/
    echo Lutfen Node.js kurup bu dosyayi tekrar calistirin.
    echo.
    pause
    exit /b 1
)

:: Check if npm is installed
where npm >nul 2>nul
if %errorlevel% neq 0 (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host '[ERROR] npm bulunamadi! Lutfen Node.js kurulumunuzu kontrol edin.' -ForegroundColor Red"
    echo.
    pause
    exit /b 1
)

echo [✓] Node.js ve npm dogrulandi.
echo.

echo [1/3] Installing dependencies (npm install)...
call npm install
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to install dependencies!
    pause
    exit /b %errorlevel%
)
echo.
echo [✓] Dependencies installed successfully.
echo.

echo [2/3] Cleaning old build files...
if exist dist (
    rmdir /s /q dist
    echo [✓] Old 'dist' folder deleted successfully.
) else (
    echo [-] No old build found to clean.
)
echo.

echo [3/3] Building the project (npm run build)...
call npm run build
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] An error occurred during build!
    pause
    exit /b %errorlevel%
)
echo.
echo [✓] Build completed successfully.
echo.

echo ============================================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host 'PROCESS COMPLETED!' -ForegroundColor Green"
echo.

set "outputFile="
for %%f in ("%~dp0dist\*") do set "outputFile=%%f"

if defined outputFile (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host 'Output file location: ' -NoNewline; Write-Host '%outputFile%' -ForegroundColor Red"
    echo ============================================================
    echo.
    echo Opening output folder in File Explorer...
    explorer.exe /select,"%outputFile%"
) else (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host '[ERROR] Output file not found in dist folder!' -ForegroundColor Red"
    echo ============================================================
)
pause
