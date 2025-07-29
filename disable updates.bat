:: Author: tsgrgo
:: Completely disable Windows Update
:: PsExec is required to get system privileges - it should be in this directory

if not "%1"=="admin" (powershell start -verb runas '%0' admin & exit /b)
if not "%2"=="system" (powershell . '%~dp0\PsExec.exe' /accepteula -i -s -d '%0' admin system & exit /b)

:: Disable update related services
for %%i in (wuauserv, UsoSvc, uhssvc, WaaSMedicSvc) do (
	net stop %%i
	sc config %%i start= disabled
	sc failure %%i reset= 0 actions= ""
)

:: Brute force rename services
for %%i in (WaaSMedicSvc, wuaueng) do (
	takeown /f C:\Windows\System32\%%i.dll && icacls C:\Windows\System32\%%i.dll /grant *S-1-1-0:F
	rename C:\Windows\System32\%%i.dll %%i_BAK.dll
	icacls C:\Windows\System32\%%i_BAK.dll /setowner "NT SERVICE\TrustedInstaller" && icacls C:\Windows\System32\%%i_BAK.dll /remove *S-1-1-0
)

:: Update registry
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v FailureActions /t REG_BINARY /d 000000000000000000000000030000001400000000000000c0d4010000000000e09304000000000000000000 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f

:: Delete downloaded update files
erase /f /s /q c:\windows\softwaredistribution\*.* && rmdir /s /q c:\windows\softwaredistribution

:: Disable all update related scheduled tasks
powershell -NoProfile -Command $paths = @( ^
'\Microsoft\Windows\InstallService*', ^
'\Microsoft\Windows\UpdateOrchestrator*', ^
'\Microsoft\Windows\UpdateAssistant*', ^
'\Microsoft\Windows\WaaSMedic*', ^
'\Microsoft\Windows\WindowsUpdate*', ^
'\Microsoft\WindowsUpdate*' ^
); ^
foreach ($path in $paths) { Get-ScheduledTask -TaskPath $path ^| Disable-ScheduledTask -ErrorAction SilentlyContinue }

echo Finished
pause