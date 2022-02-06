Windows Update Disabler
===================================
The one-click way to disable auto updates for good, without leaving leftover stuff running in the background.

WARNING
-------------------
Before you run this script, you must check if Windows is fully updated and doesn't currently installing or downloading updates!

How to use?
-------------------

Simple! Download the code as a zip, extract it and run "disable updates.bat"
Windows will never update automatically again.

To undo all the changes, run "reenable updates.bat"

Manually update Windows
-------------------

Tested for Windows 10 only:

1. Run "manual update.bat" to re-enable Windows Update Service (which is essential for installing updates)

2. Download Windows Update Assistant https://www.microsoft.com/software-download/windows10

3. After updating, uninstall the assistant

4. Rerun the disabler script

What it does
-----------

- Disables Windows Update service (wuauserv)

- Disables Update Orchestrator service (UsoSvc)

- Disables Windows Update Medic service (WaaSMedicSvc)

- Disables all update related scheduled tasks

- Disallow auto-updates through registry

Why is PsExec needed?
-----------

Some of these services and scheduled tasks are protected from user accounts. With PsExec it is possible to run commands with elevated system privileges to bypass the restrictions.

More info: https://docs.microsoft.com/en-us/sysinternals/downloads/psexec
