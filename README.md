# Windows Update Disabler

![](https://i.imgur.com/pGsWaOt.png 'Something went wrong')

⚡ The one-click way to disable auto updates for good, without leaving leftover stuff running in the background.

> [!WARNING]  
> Before you run this script, you must check if Windows is fully updated and isn't currently installing or downloading updates!

## How to Use

Simple!

1. Clone this repository or download it as a ZIP file and extract it.
2. Check if there are no updates currently being installed! (Settings > Update & Security > Windows Update)
3. Run "disable updates.bat" and Windows will never update automatically again.

You can run "enable updates.bat" to undo the changes and allow Windows to update automatically again.

## Recommended Way of Updating

1. Run "enable updates.bat" to re-enable Windows Update
2. Update Windows from settings (Settings > Update & Security > Windows Update)
3. Run "disable updates.bat"

## Manually Update Windows

Tested for Windows 10 only:

1. Run "manual update.bat" to re-enable Windows Update Service (which is essential for installing updates)
2. Download the [Windows 10 Update Assistant](https://www.microsoft.com/software-download/windows10) from the official Microsoft website and use it to install updates.
3. After updating, uninstall the assistant
4. Rerun the disabler script

## What It Does

-   Disables the Windows Update Service (wuauserv).
-   Disables the Update Orchestrator Service (UsoSvc).
-   Disables the Windows Update Medic Service (WaaSMedicSvc).
-   Disables all update-related scheduled tasks.
-   Disallows auto-updates through registry changes.

## Why is PsExec Needed?

Some of the services and tasks involved are protected from user accounts, and they require elevated system privileges to be modified. PsExec allows the script to run commands with the necessary permissions to bypass these restrictions.

PsExec is part of the official Sysinternals suite from Microsoft. More info: https://docs.microsoft.com/en-us/sysinternals/downloads/psexec
