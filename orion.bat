@echo off
title Orion Tools - Roblox Utilities
color 0a
mode con: cols=80 lines=25

:: Check for admin rights
NET SESSION >nul 2>&1
if %errorLevel% == 0 (
    set admin=ADMIN
) else (
    set admin=
)

:menu
cls
echo.
echo  -------------------------------------------------------
echo                      ORION TOOLS %admin%                      
echo  -------------------------------------------------------
echo.
echo   1. Force Live Channel + Latest Version
echo   2. Auto Downgrade Roblox
echo   3. Download Bloxstrap / Fishstrap
echo   4. Find Executor Discords (Krnl, Synapse, Fluxus, etc.)
echo   5. Kill Roblox Processes
echo   6. Check Roblox Version
echo   7. Exit
echo.
set /p choice=Choose an option (1-7): 

if "%choice%"=="1" goto force_live
if "%choice%"=="2" goto downgrade
if "%choice%"=="3" goto download_mods
if "%choice%"=="4" goto exec_discords
if "%choice%"=="5" goto kill_roblox
if "%choice%"=="6" goto check_version
if "%choice%"=="7" exit

echo Invalid choice! Please try again.
pause
goto menu

:force_live
cls
echo Forcing Roblox to latest version...
echo (This may require admin rights)
timeout /t 2 >nul
start "" "https://www.roblox.com/download"
echo Done! Roblox should now update.
pause
goto menu

:downgrade
cls
echo Auto Downgrade Roblox (for exploit compatibility)
echo.
echo WARNING: This may break Roblox. Use at your own risk!
echo.
echo 1. Downgrade to last working version
echo 2. Restore to latest version
echo 3. Back to menu
set /p downgrade_choice=Choose (1-3): 

if "%downgrade_choice%"=="1" (
    echo Downgrading Roblox...
    taskkill /f /im RobloxPlayerBeta.exe >nul 2>&1
    timeout /t 1 >nul
    echo Downloading older version...
    powershell -command "Invoke-WebRequest -Uri 'https://setup.rbxcdn.com/version-abc123-RobloxPlayer.exe' -OutFile 'RobloxPlayer.exe'"
    echo Installing...
    start /wait RobloxPlayer.exe
    echo Roblox downgraded!
    del RobloxPlayer.exe
    pause
    goto menu
)
if "%downgrade_choice%"=="2" (
    echo Restoring Roblox to latest version...
    start "" "https://www.roblox.com/download"
    echo Roblox restored!
    pause
    goto menu
)
if "%downgrade_choice%"=="3" goto menu

echo Invalid choice!
pause
goto downgrade

:download_mods
cls
echo Download Roblox Mods:
echo.
echo 1. Bloxstrap (Custom Roblox Launcher)
echo 2. Fishstrap (Alternative Mod)
echo 3. Back to menu
set /p mod_choice=Choose (1-3): 

if "%mod_choice%"=="1" (
    echo Downloading Bloxstrap...
    start "" "https://github.com/bloxstraplabs/bloxstrap/releases/latest"
    echo Check your browser for download.
    pause
    goto menu
)
if "%mod_choice%"=="2" (
    echo Downloading Fishstrap...
    start "" "https://github.com/fishstrap/fishstrap/releases"
    echo Check your browser for download.
    pause
    goto menu
)
if "%mod_choice%"=="3" goto menu

echo Invalid choice!
pause
goto download_mods

:exec_discords
cls
echo Find Executor Discords:
echo.
echo 1. Krnl
echo 2. Synapse X
echo 3. Fluxus
echo 4. JJSploit
echo 5. More Tools...
echo 6. Back to menu
set /p exec_choice=Choose (1-6): 

if "%exec_choice%"=="1" (
    echo Krnl Discord: https://discord.gg/krnl
    start "" "https://discord.gg/krnl"
    pause
    goto exec_discords
)
if "%exec_choice%"=="2" (
    echo Synapse X Discord: https://discord.gg/synapsex
    start "" "https://discord.gg/synapsex"
    pause
    goto exec_discords
)
if "%exec_choice%"=="3" (
    echo Fluxus Discord: https://discord.gg/fluxusteam
    start "" "https://discord.gg/fluxusteam"
    pause
    goto exec_discords
)
if "%exec_choice%"=="4" (
    echo JJSploit Discord: https://discord.gg/wearedevs
    start "" "https://discord.gg/wearedevs"
    pause
    goto exec_discords
)
if "%exec_choice%"=="5" (
    echo Other Tools:
    echo - Oxygen U: https://discord.gg/oxygenu
    echo - Comet: https://discord.gg/comet
    pause
    goto exec_discords
)
if "%exec_choice%"=="6" goto menu

echo Invalid choice!
pause
goto exec_discords

:kill_roblox
cls
echo Killing all Roblox processes...
taskkill /f /im RobloxPlayerBeta.exe >nul 2>&1
taskkill /f /im RobloxPlayerInstaller.exe >nul 2>&1
echo Done! All Roblox processes terminated.
pause
goto menu

:check_version
cls
echo Checking Roblox version...
for /f "tokens=2 delims==" %%A in ('wmic datafile where "name='C:\\Program Files (x86)\\Roblox\\Versions\\RobloxPlayerBeta.exe'" get version /value') do set "roblox_version=%%A"
if defined roblox_version (
    echo Current Roblox Version: %roblox_version%
) else (
    echo Roblox not found or not installed!
)
pause
goto menu
