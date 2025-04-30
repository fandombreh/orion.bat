@echo off
title Orion Tools - Roblox Utilities
color 0a
mode con: cols=85 lines=35

:: Admin check
NET SESSION >nul 2>&1
if %errorLevel% == 0 (
    set "admin=[ADMIN]"
) else (
    set "admin="
)

:: Set version
set "version=1.2"

:: Main Menu
:menu
cls
echo.
echo  -------------------------------------------------------
echo               ORION TOOLS v%version% %admin%                      
echo  -------------------------------------------------------
echo.
echo   1. Force Live Channel + Latest Version
echo   2. Auto Downgrade Roblox
echo   3. Download Bloxstrap / Fishstrap
echo   4. Find Executor Discords
echo   5. Kill Roblox Processes
echo   6. Check Roblox Version
echo   7. System Information
echo   8. Clear Roblox Cache
echo   9. Exit
echo.
set /p choice=Choose an option (1-9): 

if "%choice%"=="1" goto force_live
if "%choice%"=="2" goto downgrade
if "%choice%"=="3" goto download_mods
if "%choice%"=="4" goto exec_discords
if "%choice%"=="5" goto kill_roblox
if "%choice%"=="6" goto check_version
if "%choice%"=="7" goto system_info
if "%choice%"=="8" goto clear_cache
if "%choice%"=="9" exit

echo Invalid choice! Please select 1-9.
timeout /t 2 >nul
goto menu

:force_live
cls
echo [Force Live Channel]
echo -------------------------------
echo Forcing Roblox to latest version...
echo (This may require admin rights)
echo.
echo 1. Open Roblox Download Page
echo 2. Force Update via Command
echo 3. Back to Menu
echo.
set /p live_choice=Choose (1-3): 

if "%live_choice%"=="1" (
    start "" "https://www.roblox.com/download"
    echo Opening Roblox download page...
    timeout /t 2 >nul
    goto menu
)
if "%live_choice%"=="2" (
    echo Attempting to force update...
    if not exist "%LOCALAPPDATA%\Roblox\Versions" (
        echo Roblox not found in default location!
        pause
        goto force_live
    )
    
    for /f "delims=" %%i in ('dir /b /ad "%LOCALAPPDATA%\Roblox\Versions"') do (
        set "version_dir=%%i"
    )
    
    if defined version_dir (
        echo Found Roblox version: %version_dir%
        echo Deleting version manifest to force update...
        del /q "%LOCALAPPDATA%\Roblox\Versions\%version_dir%\version" >nul 2>&1
        if errorlevel 1 (
            echo Failed to delete manifest. Try running as Admin.
        ) else (
            echo Success! Roblox will update on next launch.
        )
    ) else (
        echo Could not find Roblox version directory.
    )
    pause
    goto menu
)
if "%live_choice%"=="3" goto menu

echo Invalid choice!
timeout /t 1 >nul
goto force_live

:downgrade
cls
echo [Roblox Downgrader]
echo -------------------------------
echo WARNING: This may break Roblox. Use at your own risk!
echo.
echo 1. Downgrade to last working version
echo 2. Restore to latest version
echo 3. Back to menu
echo.
set /p downgrade_choice=Choose (1-3): 

if "%downgrade_choice%"=="1" (
    echo Downgrading Roblox...
    call :kill_roblox_silent
    timeout /t 1 >nul
    
    echo Downloading older version...
    set "temp_file=%TEMP%\RobloxPlayer_Old.exe"
    powershell -command "Invoke-WebRequest -Uri 'https://setup.rbxcdn.com/version-abc123-RobloxPlayer.exe' -OutFile '%temp_file%'"
    
    if exist "%temp_file%" (
        echo Installing...
        start /wait "" "%temp_file%"
        del /q "%temp_file%"
        echo Roblox downgraded!
    ) else (
        echo Failed to download older version!
    )
    pause
    goto menu
)
if "%downgrade_choice%"=="2" (
    echo Restoring Roblox to latest version...
    start "" "https://www.roblox.com/download"
    echo Roblox will update to latest version.
    pause
    goto menu
)
if "%downgrade_choice%"=="3" goto menu

echo Invalid choice!
timeout /t 1 >nul
goto downgrade

:download_mods
cls
echo [Roblox Mods Downloader]
echo -------------------------------
echo 1. Bloxstrap (Custom Roblox Launcher)
echo 2. Fishstrap (Alternative Mod)
echo 3. Open Mods Collection Page
echo 4. Back to menu
echo.
set /p mod_choice=Choose (1-4): 

if "%mod_choice%"=="1" (
    start "" "https://github.com/bloxstraplabs/bloxstrap/releases/latest"
    echo Opening Bloxstrap download page...
    goto download_mods
)
if "%mod_choice%"=="2" (
    start "" "https://github.com/fishstrap/fishstrap/releases"
    echo Opening Fishstrap download page...
    goto download_mods
)
if "%mod_choice%"=="3" (
    start "" "https://github.com/topics/roblox-mods"
    echo Opening Roblox mods collection...
    goto download_mods
)
if "%mod_choice%"=="4" goto menu

echo Invalid choice!
timeout /t 1 >nul
goto download_mods

:exec_discords
cls
echo [Executor Discords]
echo -------------------------------
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
echo.
set /p exec_choice=Choose (1-10): 

set "discord_url="
if "%exec_choice%"=="1" set "discord_url=https://discord.gg/krnl"
if "%exec_choice%"=="2" set "discord_url=https://discord.gg/synapsex"
if "%exec_choice%"=="3" set "discord_url=https://discord.gg/fluxusteam"
if "%exec_choice%"=="4" set "discord_url=https://discord.gg/wearedevs"
if "%exec_choice%"=="5" set "discord_url=https://getswift.gg/"
if "%exec_choice%"=="6" set "discord_url=https://www.xeno.now/"
if "%exec_choice%"=="7" set "discord_url=https://getsolara.dev/"
if "%exec_choice%"=="8" set "discord_url=https://discord.gg/awp"

if defined discord_url (
    start "" "%discord_url%"
    echo Opening %discord_url%
    pause
    goto exec_discords
)

if "%exec_choice%"=="9" (
    cls
    echo [More Executor Tools]
    echo -------------------------------
    echo Oxygen U: https://discord.gg/oxygenu
    echo Comet: https://discord.gg/comet
    echo Electron: https://discord.gg/electron
    echo Delta: https://discord.gg/deltaexec
    echo.
    pause
    goto exec_discords
)
if "%exec_choice%"=="10" goto menu

echo Invalid choice!
timeout /t 1 >nul
goto exec_discords

:kill_roblox
call :kill_roblox_silent
echo Done! All Roblox processes terminated.
pause
goto menu

:kill_roblox_silent
cls
echo Killing all Roblox processes...
taskkill /f /im RobloxPlayerBeta.exe >nul 2>&1
taskkill /f /im RobloxPlayerInstaller.exe >nul 2>&1
taskkill /f /im RobloxStudioBeta.exe >nul 2>&1
goto :eof

:check_version
cls
echo [Roblox Version Check]
echo -------------------------------
echo Checking Roblox version...
echo.

:: Check common install locations
set "found=0"
set "install_path="
set "roblox_version="

for %%D in (
    "%ProgramFiles(x86)%\Roblox\Versions"
    "%LOCALAPPDATA%\Roblox\Versions"
    "%ProgramW6432%\Roblox\Versions"
) do (
    if exist "%%D" (
        for /f "delims=" %%V in ('dir /b /ad "%%D" 2^>nul') do (
            if exist "%%D\%%V\RobloxPlayerBeta.exe" (
                for /f "tokens=2 delims==" %%P in ('wmic datafile where "name='%%D\%%V\RobloxPlayerBeta.exe'" get version /value 2^>nul') do (
                    set "roblox_version=%%P"
                    set "install_path=%%D\%%V"
                    set "found=1"
                )
            )
        )
    )
)

if %found% == 1 (
    echo Installed Version: %roblox_version%
    echo Installation Path: %install_path%
) else (
    echo Could not find Roblox installation!
    echo Try running as Administrator if you have it installed.
)

:: Check running processes
tasklist /FI "IMAGENAME eq RobloxPlayerBeta.exe" 2>nul | find /I "RobloxPlayerBeta.exe" >nul
if %errorlevel% == 0 (
    echo.
    echo [STATUS] Roblox is currently RUNNING
) else (
    echo.
    echo [STATUS] Roblox is NOT running
)

:: Check for updates
if %found% == 1 (
    echo.
    echo Checking for latest version...
    for /f "delims=" %%I in ('powershell -command "(Invoke-WebRequest -Uri 'https://clientsettingscdn.roblox.com/v2/client-version/WindowsPlayer' -UseBasicParsing).Content | ConvertFrom-Json | Select-Object -ExpandProperty clientVersionUpload" 2^>nul') do (
        set "latest_version=%%I"
    )
    
    if defined latest_version (
        echo Latest Version: %latest_version%
        if "%roblox_version%" == "%latest_version%" (
            echo Your Roblox is UP TO DATE
        ) else (
            echo Your Roblox is OUT OF DATE
        )
    )
)

pause
goto menu

:system_info
cls
echo [System Information]
echo -------------------------------
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory"
echo.
wmic cpu get name
echo.
echo Roblox Path: %LOCALAPPDATA%\Roblox
echo.
pause
goto menu

:clear_cache
cls
echo [Clear Roblox Cache]
echo -------------------------------
echo WARNING: This will delete temporary Roblox files
echo but won't affect your games or settings.
echo.
set /p cache_confirm=Are you sure? (Y/N): 

if /i "%cache_confirm%"=="Y" (
    echo Clearing cache...
    rd /s /q "%TEMP%\Roblox" >nul 2>&1
    rd /s /q "%LOCALAPPDATA%\Roblox\logs" >nul 2>&1
    del /q "%LOCALAPPDATA%\Roblox\*.log" >nul 2>&1
    echo Cache cleared successfully!
) else (
    echo Operation cancelled.
)
pause
goto menu
