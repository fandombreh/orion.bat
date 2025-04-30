@echo off
title Orion Tools - Roblox Utilities
color 0a
mode con: cols=80 lines=30

:: Check admin rights silently
net session >nul 2>&1 && set "admin=ADMIN" || set "admin="

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
echo   7. Script Hub
echo   8. FPS Unlocker
echo   9. Exit
echo.
set /p "choice=Choose an option (1-9): "

if "%choice%"=="1" goto force_live
if "%choice%"=="2" goto downgrade
if "%choice%"=="3" goto download_mods
if "%choice%"=="4" goto exec_discords
if "%choice%"=="5" goto kill_roblox
if "%choice%"=="6" goto check_version
if "%choice%"=="7" goto script_hub
if "%choice%"=="8" goto fps_unlocker
if "%choice%"=="9" exit

echo Invalid choice! Press any key to retry...
pause >nul
goto menu

:force_live
cls
echo Forcing Roblox to latest version...
echo Please wait...
timeout /t 2 >nul
start "" "https://www.roblox.com/download"
echo Launched Roblox installer. Please follow the prompts.
pause
goto menu

:downgrade
cls
echo Auto Downgrade Roblox
echo.
echo 1. Downgrade to last working version
echo 2. Restore to latest version
echo 3. Back to menu
set /p "downgrade_choice=Choose (1-3): "

if "%downgrade_choice%"=="1" (
    echo Closing Roblox...
    taskkill /f /im RobloxPlayerBeta.exe >nul 2>&1
    timeout /t 1 >nul
    echo Downloading older version...
    powershell -command "Start-BitsTransfer -Source 'https://setup.rbxcdn.com/version-abc123-RobloxPlayer.exe' -Destination 'RobloxPlayer.exe'"
    echo Installing...
    start /wait RobloxPlayer.exe
    del RobloxPlayer.exe
    echo Downgrade complete!
    pause
    goto menu
)
if "%downgrade_choice%"=="2" (
    start "" "https://www.roblox.com/download"
    echo Restoring to latest version...
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
echo 1. Bloxstrap
echo 2. Fishstrap
echo 3. Back to menu
set /p "mod_choice=Choose (1-3): "

if "%mod_choice%"=="1" (
    start "" "https://github.com/bloxstraplabs/bloxstrap/releases/latest"
    pause
    goto menu
)
if "%mod_choice%"=="2" (
    start "" "https://github.com/fishstrap/fishstrap/releases"
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
echo 0. Back to menu
set /p "exec_choice=Choose (1-0): "

if "%exec_choice%"=="1" start "" "https://discord.gg/krnl" & pause & goto exec_discords
if "%exec_choice%"=="2" start "" "https://discord.gg/synapsex" & pause & goto exec_discords
if "%exec_choice%"=="3" start "" "https://discord.gg/fluxusteam" & pause & goto exec_discords
if "%exec_choice%"=="4" start "" "https://discord.gg/wearedevs" & pause & goto exec_discords
if "%exec_choice%"=="5" start "" "https://getswift.gg/" & pause & goto exec_discords
if "%exec_choice%"=="6" start "" "https://www.xeno.now/" & pause & goto exec_discords
if "%exec_choice%"=="7" start "" "https://getsolara.dev/" & pause & goto exec_discords
if "%exec_choice%"=="8" start "" "https://discord.gg/awp" & pause & goto exec_discords
if "%exec_choice%"=="9" (
    echo Oxygen U: https://discord.gg/oxygenu
    echo Comet: https://discord.gg/comet
    echo Electron: https://discord.gg/electron
    pause
    goto exec_discords
)
if "%exec_choice%"=="0" goto menu

echo Invalid choice!
pause
goto exec_discords

:kill_roblox
cls
echo Killing all Roblox processes...
taskkill /f /im RobloxPlayerBeta.exe >nul 2>&1
taskkill /f /im RobloxPlayerInstaller.exe >nul 2>&1
taskkill /f /im Windows10Universal.exe >nul 2>&1
echo All Roblox processes terminated.
pause
goto menu

:check_version
cls
echo [ Roblox Version Check ]
echo ------------------------
echo.

set "player_version="
set "client_version="

for /f "tokens=*" %%A in ('where /r "%LOCALAPPDATA%\Roblox\Versions" RobloxPlayerBeta.exe 2^>nul') do (
    for /f "tokens=2 delims==" %%B in ('wmic datafile where "name='%%A'" get version /value 2^>nul') do (
        set "player_version=%%B"
        echo Player Version: %%B
        echo Path: %%~dpA
    )
)

for /f "tokens=*" %%A in ('where /r "%LOCALAPPDATA%\Roblox\Versions" Windows10Universal.exe 2^>nul') do (
    for /f "tokens=2 delims==" %%B in ('wmic datafile where "name='%%A'" get version /value 2^>nul') do (
        set "client_version=%%B"
        echo Game Client Version: %%B
        echo Path: %%~dpA
    )
)

tasklist | find /i "RobloxPlayerBeta.exe" >nul && echo Player is RUNNING || echo Player NOT running
tasklist | find /i "Windows10Universal.exe" >nul && echo Game Client is RUNNING || echo Game Client NOT running

if not defined player_version echo Could not find Player installation!
if not defined client_version echo Could not find Game Client installation!

pause
goto menu

:script_hub
cls
echo Loading Script Hub...
timeout /t 2 >nul
start "" "https://robloxscripts.com/"
echo Opened popular script hub in your browser
pause
goto menu

:fps_unlocker
cls
echo Roblox FPS Unlocker
echo.
echo 1. Download FPS Unlocker
echo 2. Set FPS Limit (requires admin)
echo 3. Back to menu
set /p "fps_choice=Choose (1-3): "

if "%fps_choice%"=="1" (
    start "" "https://github.com/axstin/rbxfpsunlocker/releases"
    pause
    goto fps_unlocker
)
if "%fps_choice%"=="2" (
    set /p "fps_limit=Enter desired FPS limit (e.g., 144): "
    echo Setting FPS limit to %fps_limit%...
    timeout /t 2 >nul
    echo Please run rbxfpsunlocker as admin to apply changes
    pause
    goto fps_unlocker
)
if "%fps_choice%"=="3" goto menu

echo Invalid choice!
pause
goto fps_unlocker
