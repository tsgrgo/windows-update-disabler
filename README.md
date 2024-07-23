# Windows Update Disabler

![](https://i.imgur.com/pGsWaOt.png 'Something went wrong')

⚡ The one-click way to disable auto updates for good, without leaving leftover stuff running in the background.

> [!WARNING]  
> Before running this script, ensure that Windows is fully updated and not currently installing or downloading updates! Interrupting an update could result in breaking your Windows installation!

## How to Use

### Simple!

1. **Clone or Download:**

    - Clone this repository using `git clone https://github.com/tsgrgo/windows-update-disabler.git` or download it as a ZIP file and extract it.

2. **Check for Active Updates:**

    - Ensure there are no updates currently being installed. Navigate to **Settings > Update & Security > Windows Update** and verify.

3. **Run the Script:**

    - Execute `disable updates.bat`. This will disable automatic Windows updates.

4. **Re-enable Updates (Optional):**
    - If you need to allow automatic updates again, run `enable updates.bat`. This is a complete inverse function of `disable updates.bat` and will undo all the changes it did.

## How to Update Manually

Regular updates are recommended for security. To update manually:

1. **Enable Updates:**

    - Run `enable updates.bat` to re-enable Windows Update.

2. **Perform Updates:**

    - Navigate to **Settings > Update & Security > Windows Update** and install available updates.

3. **Disable Updates Again:**
    - After updating, run `disable updates.bat` again to disable automatic updates.

## Using the Update Service Temporarily

Some applications, like Microsoft Store, depend on the Windows Update service. To temporarily enable the service:

1. **Enable Update Service:**

    - Run `use update service.bat` to re-enable the Windows Update Service.

2. **Use Dependent Applications:**

    - You can now use applications that require the update service.

3. **Disable Update Service Again:**
    - Once done, run `disable updates.bat` to disable the update service again.

## What It Does

The script performs the following actions to disable automatic updates:

-   Disables the **Windows Update Service (wuauserv)**.
-   Disables the **Update Orchestrator Service (UsoSvc)**.
-   Disables the **Windows Update Medic Service (WaaSMedicSvc)**.
-   Disables all update-related scheduled tasks.
-   Applies registry changes to prevent auto-updates.

## Why is PsExec Needed?

Some of the services and tasks involved are protected from user accounts, and they require elevated system privileges to be modified. PsExec allows the script to run commands with the necessary permissions to bypass these restrictions.

PsExec is part of the official Sysinternals suite from Microsoft. More info: https://docs.microsoft.com/en-us/sysinternals/downloads/psexec
