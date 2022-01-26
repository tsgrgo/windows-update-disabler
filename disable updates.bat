rem Author: tsgrgo
rem Disable windows update completely
rem PsExec is required to get system privileges - it should be in this directory

if not "%1"=="admin" (powershell start -verb runas '%0' admin & exit /b)
if not "%2"=="system" (powershell %~dp0\PsExec.exe /accepteula -i -s -d '%0' admin system & exit /b)

rem Disable update related services
sc stop wuauserv
sc stop UsoSvc
sc stop WaaSMedicSvc
sc config wuauserv start= disabled
sc failure wuauserv reset= 0 actions= ""
sc config UsoSvc start= disabled
sc failure UsoSvc reset= 0 actions= ""

rem Forcefully disable update medic service
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v FailureActions /t REG_BINARY /d 000000000000000000000000030000001400000000000000c0d4010000000000e09304000000000000000000 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f

rem Delete downloaded update files
erase /f /s /q c:\windows\softwaredistribution\*.* && rmdir /s /q c:\windows\softwaredistribution

rem Disable all update related scheduled tasks
powershell -command "Get-ScheduledTask -TaskPath '\Microsoft\Windows\UpdateOrchestrator\' | Disable-ScheduledTask; Get-ScheduledTask -TaskPath '\Microsoft\Windows\UpdateAssistant\' | Disable-ScheduledTask; Get-ScheduledTask -TaskPath '\Microsoft\Windows\WaaSMedic\' | Disable-ScheduledTask; Get-ScheduledTask -TaskPath '\Microsoft\Windows\WindowsUpdate\' | Disable-ScheduledTask"

echo Finished
pause
