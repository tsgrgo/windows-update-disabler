:: Author: tsgrgo
:: PsExec is required to get system privileges - it should be in this directory

@echo off
if not "%1"=="admin" (powershell start -verb runas '%0' admin & exit /b)
if not "%2"=="system" (powershell . '%~dp0\PsExec.exe' /accepteula -i -s -d '%0' admin system & exit /b)

:: Restore renamed services
for %%i in (wuaueng) do (
	takeown /f C:\Windows\System32\%%i_BAK.dll && icacls C:\Windows\System32\%%i_BAK.dll /grant *S-1-1-0:F
	rename C:\Windows\System32\%%i_BAK.dll %%i.dll
	icacls C:\Windows\System32\%%i.dll /setowner "NT SERVICE\TrustedInstaller" && icacls C:\Windows\System32\%%i.dll /remove *S-1-1-0
)

:: Change service config
sc config wuauserv start= auto

echo.
echo Enabled Windows Update Service
echo You can now use software that relies on the Windows Update Service.
echo When finished, you can run the disabler again.
echo More info in README
echo.
pause
