:: Author: tsgrgo
:: Re-enable Windows auto updates and undo all changes by 'disable updates.bat'
:: PsExec is required to get system privileges - it should be in this directory

if not "%1"=="admin" (powershell start -verb runas '%0' admin & exit /b)
if not "%2"=="system" (powershell . '%~dp0\PsExec.exe' /accepteula -i -s -d '%0' admin system & exit /b)

:: Enable update related services
sc config wuauserv start= auto
sc config UsoSvc start= auto
sc config uhssvc start= delayed-auto

:: Restore renamed services
for %%i in (WaaSMedicSvc, wuaueng) do (
	takeown /f C:\Windows\System32\%%i_BAK.dll && icacls C:\Windows\System32\%%i_BAK.dll /grant *S-1-1-0:F
	rename C:\Windows\System32\%%i_BAK.dll %%i.dll
	icacls C:\Windows\System32\%%i.dll /setowner "NT SERVICE\TrustedInstaller" && icacls C:\Windows\System32\%%i.dll /remove *S-1-1-0
)

:: Update registry
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v FailureActions /t REG_BINARY /d 840300000000000000000000030000001400000001000000c0d4010001000000e09304000000000000000000 /f
reg delete "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /f

:: Enable all update related scheduled tasks
powershell -NoProfile -Command $paths = @( ^
'\Microsoft\Windows\InstallService*', ^
'\Microsoft\Windows\UpdateOrchestrator*', ^
'\Microsoft\Windows\UpdateAssistant*', ^
'\Microsoft\Windows\WaaSMedic*', ^
'\Microsoft\Windows\WindowsUpdate*', ^
'\Microsoft\WindowsUpdate*' ^
); ^
foreach ($path in $paths) { Get-ScheduledTask -TaskPath $path ^| Enable-ScheduledTask -ErrorAction SilentlyContinue }

echo Finished
pause
