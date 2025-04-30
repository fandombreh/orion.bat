@echo off
title Orion Tools - Roblox Utilities
color 0a
mode con: cols=80 lines=30

:: Admin check
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
echo   4. Find Executor Discords
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

echo Invalid choice! Press any key to retry.
pause >nul
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
echo 5. Swift
echo 6. Xeno
echo 7. Solara
echo 8. AWP
echo 9. More Tools...
echo 10. Back to menu
set /p exec_choice=Choose (1-10): 

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
    echo Swift: https://getswift.gg/
    start "" "https://getswift.gg/"
    pause
    goto exec_discords
)
if "%exec_choice%"=="6" (
    echo Xeno: https://www.xeno.now/
    start "" "https://www.xeno.now/"
    pause
    goto exec_discords
)
if "%exec_choice%"=="7" (
    echo Solara: https://getsolara.dev/
    start "" "https://getsolara.dev/"
    pause
    goto exec_discords
)
if "%exec_choice%"=="8" (
    echo AWP: https://discord.gg/awp
    start "" "https://discord.gg/awp"
    pause
    goto exec_discords
)
if "%exec_choice%"=="9" (
    echo Other Tools:
    echo - Oxygen U: https://discord.gg/oxygenu
    echo - Comet: https://discord.gg/comet
    pause
    goto exec_discords
)
if "%exec_choice%"=="10" goto menu

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
echo.

:: Check common install locations
set found=0
for %%D in (
    "%ProgramFiles(x86)%\Roblox\Versions\*"
    "%LOCALAPPDATA%\Roblox\Versions\*"
    "%ProgramW6432%\Roblox\Versions\*"
) do (
    if exist "%%D\RobloxPlayerBeta.exe" (
        for /f "tokens=2 delims==" %%V in ('wmic datafile where "name='%%D\RobloxPlayerBeta.exe'" get version /value 2^>nul') do (
            set "roblox_version=%%V"
            set found=1
            echo Installed Version: %%V (at %%D)
        )
    )
)

:: Check running processes
tasklist /FI "IMAGENAME eq RobloxPlayerBeta.exe" 2>nul | find /I "RobloxPlayerBeta.exe" >nul
if %errorlevel% == 0 (
    echo.
    echo Roblox is currently RUNNING
) else (
    echo.
    echo Roblox is NOT running
)

if %found% == 0 (
    echo.
    echo Could not find Roblox installation!
    echo Try running as Administrator if you have it installed.
)

pause
goto menu
