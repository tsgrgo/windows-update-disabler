rem Author: tsgrgo
rem Reenable windows auto updates (manual update is more recommended)
rem PsExec is required to get system privileges - it should be in this directory

if not "%1"=="admin" (powershell start -verb runas '%0' admin & exit /b)
if not "%2"=="system" (powershell %~dp0\PsExec.exe /accepteula -i -s -d '%0' admin system & exit /b)

rem Enable update related services
sc config wuauserv start= auto
sc config UsoSvc start= auto

rem Enable update medic service
rename C:\Windows\System32\WaaSMedicSvc_BAK.dll WaaSMedicSvc.dll
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v FailureActions /t REG_BINARY /d 840300000000000000000000030000001400000001000000c0d4010001000000e09304000000000000000000 /f
reg delete "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /f

rem Enable all update related scheduled tasks
powershell -command "Get-ScheduledTask -TaskPath '\Microsoft\Windows\UpdateOrchestrator\' | Enable-ScheduledTask; Get-ScheduledTask -TaskPath '\Microsoft\Windows\UpdateAssistant\' | Enable-ScheduledTask; Get-ScheduledTask -TaskPath '\Microsoft\Windows\WaaSMedic\' | Enable-ScheduledTask; Get-ScheduledTask -TaskPath '\Microsoft\Windows\WindowsUpdate\' | Enable-ScheduledTask"

echo Finished
pause