
# VSCode PowerShell History Manager


This project provides a **PowerShell profile script** that enables **project-specific command history** when using **VS Code's integrated terminal**. It ensures that PowerShell command history is stored separately for each project, avoiding conflicts between different repositories.

## Features
- **Project-Specific History:** Each project has its own history file.
- **Global History Support:** Uses global history when running standalone PowerShell.
- **Automatic History Loading & Saving:** Ensures past commands persist across sessions.
- **Configurable Profile Settings:** Allows users to enable/disable history and profile path display.

## Installation
### Step 1: Clone the Repository
```sh
git clone https://github.com/your-username/VSCode-PowerShell-History.git
cd VSCode-PowerShell-History
```

### Step 2: Run the Setup Script
```powershell
powershell -ExecutionPolicy Bypass -File setup.ps1
```
The script will:
1. **Backup** your existing PowerShell profile.
2. **Copy** the new profile script to your PowerShell profile directory.
3. **Ask for user preferences** (whether to display history and profile path on startup).
4. **Apply changes** and set up history management.

## Usage
### Project-Specific History
When using **VS Code**, the script creates a unique history file for each project:
```
C:\Users\YourUser\.ps_history\D_Projects_MyProject.pshistory
```
The filename is derived from the full project path, replacing `:` and `\` with `_` to prevent invalid characters.

### Global History (Standalone PowerShell)
If **not running inside VS Code**, PowerShell will use the global history file:
```
C:\Users\YourUser\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
```

## Configuration
After installation, you can modify these preferences inside your PowerShell profile (`$PROFILE`):
```powershell
$ShowHistoryPath = $True   # Set to $False to disable history file path display
$ShowProfilePath = $True   # Set to $False to disable profile path display
```

## How to Test

1. In VS Code Terminal

- Run some commands, close & reopen VS Code.

- Press the Up Arrow (↑) → You should see only project-specific history.

2. In Standalone PowerShell

- Run some commands, close & reopen PowerShell.

- Press the Up Arrow (↑) → You should see only global history.

## Uninstallation
If you want to remove this setup, run:
```powershell
Remove-Item -Path $PROFILE -Force
Restore backup:
Copy-Item -Path "$PROFILE.bak" -Destination "$PROFILE" -Force
```
Then restart your terminal.

## Troubleshooting
- **"Access Denied" Errors?** Run PowerShell with administrator privileges.
- **History File Not Found?** Ensure that `PSReadLine` is installed:
  ```powershell
  Install-Module PSReadLine -Force
  ```
- **Profile Not Loading?** Check if `$PROFILE` is correctly pointing to `Microsoft.PowerShell_profile.ps1`:
  ```powershell
  Write-Output $PROFILE
  ```

## License

<p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/"><a property="dct:title" rel="cc:attributionURL" href="https://github.com/sahilgoyal7214/VSCode-PowerShell-History">VSCode PowerShell History Manager</a> by <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://www.linkedin.com/in/sahil-goyal--/">Sahil Goyal</a> is licensed under <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC BY-NC-SA 4.0<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1" alt=""><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1" alt=""><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/nc.svg?ref=chooser-v1" alt=""><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/sa.svg?ref=chooser-v1" alt=""></a></p>  

### 🔹 What This Means:
- 🆓 You can **use, modify, and share** this project **non-commercially**  
- 🏷️ You **must** give **proper credit** to the original author  
- 🔄 If you modify this project, **you must use the same license**  

🔗 Read more about this license: [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)



## Authors

- [Sahil Goyal](https://www.github.com/sahilgoyal7214)

