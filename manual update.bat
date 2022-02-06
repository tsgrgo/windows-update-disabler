@echo off
if not "%1"=="admin" (powershell start -verb runas '%0' admin & exit /b)
sc config wuauserv start= auto
echo.
echo Enabled Windows Update Service
echo You can now use Windows Update Assistant to manually install updates.
echo Dont forget to uninstall Update Assistant and rerun the disabler after the update!
echo More info in README
echo.
pause
