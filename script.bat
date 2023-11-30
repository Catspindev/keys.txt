@echo off
color 0A
title De-Lag Windows - Optimization Script

:: Display disclaimer and ask for agreement
echo ===========================================================
echo ============ De-Lag Windows Optimization Script ============
echo ===========================================================
echo.
echo   By using this script, you agree that you can't sue the
echo   author or any contributors if it breaks your PC. Use at
echo   your own risk.
echo.
set /p agreement=Type "I agree" to acknowledge the disclaimer and proceed: 

if /i not "%agreement%"=="I agree" (
    echo You did not agree to the disclaimer. Exiting script.
    pause
    exit
)

:: Request administrator privileges
NET SESSION >nul 2>nul
if %errorlevel% neq 0 (
    echo Requesting Administrator Privileges...
    powershell start -verb runas '%0' 
    exit /b
)

:: Rest of the script...

:: URL to fetch license keys
set license_key_url=https://raw.githubusercontent.com/Catspindev/keys.txt/main/keys.txt

:: Fetch license keys from the URL
curl -s -o keys.txt %license_key_url%

:: Check if keys.txt exists
if not exist keys.txt (
    echo Failed to fetch license keys. Exiting script.
    pause
    exit
)

:: Ask the user to enter the license key
set /p entered_license_key=Enter your license key:

:: Check if the entered key matches any key from keys.txt
findstr /i /c:"%entered_license_key%" keys.txt >nul
if %errorlevel% equ 0 (
    echo License key is valid.
    goto store_license_key
) else (
    echo Invalid license key. Exiting script.
    pause
    exit
)

:store_license_key
:: Store the license key in the registry
reg add HKLM\Software\DeLagWindows /v LicenseKey /d "%entered_license_key%" /f

:menu
cls
echo.
echo ===============================================================
echo =================== De-Lag Windows Optimization Script ==================
echo ===============================================================
echo 1. Clean Temporary Files
echo 2. Defragment Drives
echo 3. Check System File Corruption
echo 4. Update System
echo 5. Check Disk for Errors
echo 6. Optimize Startup Programs
echo 7. Disable Windows Search Indexing
echo 8. Clear DNS Cache
echo 9. Disable Unnecessary Services
echo 10. Empty Recycle Bin
echo 11. Adjust Visual Effects for Performance
echo 12. Uninstall Unused Programs
echo 13. Adjust Power Settings
echo 14. Disable Windows Tips and Tricks
echo 15. Delete System Restore Points
echo 16. Install Applications
echo 17. Disable Features
echo 18. Remove Microsoft Edge
echo 19. Reinstall Microsoft Edge
echo 20. DNS Optimizer for Ping
echo 21. Install Visual Studio Code
echo 22. Install OBS
echo 23. Install VirtualBox
echo 24. Debloat Windows
echo 25. Create System Restore Point
echo 26. Restore System from Restore Point
echo 27. Install All Applications
echo 28. Exit
echo ===============================================================
echo ===============================================================
set /p choice=Enter the number of your choice: 

if "%choice%"=="" goto menu
if "%choice%"=="1" goto clean_temp_files
if "%choice%"=="2" goto defragment_drives
if "%choice%"=="3" goto check_system_files
if "%choice%"=="4" goto update_system
if "%choice%"=="5" goto check_disk_errors
if "%choice%"=="6" goto optimize_startup
if "%choice%"=="7" goto disable_search_indexing
if "%choice%"=="8" goto clear_dns_cache
if "%choice%"=="9" goto disable_unnecessary_services
if "%choice%"=="10" goto empty_recycle_bin
if "%choice%"=="11" goto adjust_visual_effects
if "%choice%"=="12" goto uninstall_unused_programs
if "%choice%"=="13" goto adjust_power_settings
if "%choice%"=="14" goto disable_windows_tips
if "%choice%"=="15" goto delete_system_restore_points
if "%choice%"=="16" goto install_applications
if "%choice%"=="17" goto disable_features
if "%choice%"=="18" goto remove_microsoft_edge
if "%choice%"=="19" goto reinstall_microsoft_edge
if "%choice%"=="20" goto dns_optimizer
if "%choice%"=="21" goto install_vscode
if "%choice%"=="22" goto install_obs
if "%choice%"=="23" goto install_virtualbox
if "%choice%"=="24" goto debloat_windows
if "%choice%"=="25" goto create_restore_point
if "%choice%"=="26" goto restore_system
if "%choice%"=="27" goto install_all_applications
if "%choice%"=="28" goto exit_script

:create_restore_point
echo.
echo Creating System Restore Point...
wbadmin start backup -backupTarget:%SystemDrive%\ -include:C: -quiet
echo System restore point created successfully.
pause
goto menu

:restore_system
echo.
echo Restoring System from Restore Point...
wbadmin start systemstaterecovery -version: -quiet
echo System restored successfully.
pause
goto menu

:install_all_applications
echo.
echo Installing All Applications...
:: Install 7-Zip
powershell -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
choco install -y 7zip

:: Install OldNewExplorer
choco install -y OldNewExplorer

:: Install Visual Studio Code
choco install -y vscode

:: Install OBS
choco install -y obs-studio

:: Install VirtualBox
choco install -y virtualbox
echo All applications installed successfully.
pause
goto menu

:exit_script
echo.
echo Exiting De-Lag Windows Script...
exit /b
