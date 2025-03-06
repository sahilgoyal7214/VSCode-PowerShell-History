# VS Code PowerShell Project-Specific History

This script enables **project-specific command history** in VS Code while keeping **global history** in standalone PowerShell.
## 🛠️ How It Works
- When you use **VS Code**, commands are saved in `.pshistory` inside the project folder.
- When using **standalone PowerShell**, the global history is stored normally.

## 🚀 Features
✔️ **Easy Setup** with `setup.ps1`  
✔️ **VS Code Mode:** Saves & loads history per project (.pshistory)  
✔️ *Standalone Mode:* Uses global PowerShell history (ConsoleHost_history.txt)  
✔️ Auto-loads history when opening PowerShell  
✔️ Auto-saves history when exiting  
✔️ Ensures empty lines are ignored in .pshistory  
✔️ Prevents global history interference in VS Code  
✔️ Displays current mode (Project-Specific / Global) on startup  

## 🔧 Installation

1 **Clone the repository**  
```powershell
git clone https://github.com/sahilgoyal7214/VSCode-PowerShell-History.git
cd VSCode-PowerShell-History 
```

2 **Run the setup script**

```powershell
powershell -ExecutionPolicy Bypass -File setup.ps1
```
3 **Restart VS Code and PowerShell**

Now, each project in **VS Code** will have its own command history! 🚀


## 🧪 How to Test
- In **VS Code Terminal**, run some commands, close & reopen → History should be project-specific.
- In **Standalone PowerShell**, run commands, close & reopen → History should be global.
- Press **Up Arrow (↑)** to check if only the relevant history is loaded.


## Authors

- [Sahil Goyal](https://www.github.com/sahilgoyal7214)
