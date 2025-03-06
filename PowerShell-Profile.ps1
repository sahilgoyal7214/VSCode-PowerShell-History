
$ShowHistoryPath = $True  # Or $false based on user choice
$ShowProfilePath = $True  # Or $false based on user choice

# Detect if running inside VS Code
$isVSCode = ($env:TERM_PROGRAM -eq "vscode")

# Ensure PSReadLine is loaded
if (!(Get-Module -Name PSReadLine)) {
    Import-Module PSReadLine -ErrorAction SilentlyContinue
}


# Define global history folder
$historyFolder = "$env:USERPROFILE\.ps_history"
if (!(Test-Path $historyFolder)) {
    New-Item -ItemType Directory -Path $historyFolder -Force | Out-Null
}


# Convert full project path into a valid filename
$projectFullPath = (Get-Item $PWD).FullName
$sanitizedProjectName = $projectFullPath -replace "[:\\]", "_"  # Replace invalid chars
$projectHistoryPath = "$historyFolder\$sanitizedProjectName.pshistory"
# Define paths for history files
$globalHistoryPath = "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"


# Function to Save History on Exit
function Save-History {
    $historyFile = if ($isVSCode) { $projectHistoryPath } else { $globalHistoryPath }

    if ($historyFile -and $PWD) {
        try {
            Get-History | Select-Object -ExpandProperty CommandLine | Out-File -FilePath $historyFile -Encoding utf8
        } catch {
            Write-Warning "Failed to save history: $_"
        }
    }
}

# Function to Load History (Direct File-Based Approach)
function Load-History {
    $historyFile = if ($isVSCode) { $projectHistoryPath } else { $globalHistoryPath }
    if (!(Test-Path $historyFile)) {
        # If the file doesn't exist, create an empty one
        New-Item -ItemType File -Path $historyFile -Force | Out-Null
        Write-Output "Created new history file: $historyFile"
    }
    if ((Test-Path $historyFile) -and $ShowHistoryPath) {
        try {
            Write-Output "Using history file: $historyFile"
        } catch {
            Write-Warning "Failed to load history: $_"
        }
    } else {
        Write-Output "No history file found at: $historyFile"
    }
}

# Apply history settings
if ($isVSCode) {
    # Use project-specific history in VS Code
    Load-History

    # Save project-specific history on exit
    Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action { Save-History } | Out-Null

    # Directly set history file in PSReadLine
    Set-PSReadLineOption -HistorySavePath $projectHistoryPath -HistorySaveStyle SaveIncrementally
} else {
    # Use global history in standalone PowerShell
    Set-PSReadLineOption -HistorySavePath $globalHistoryPath -HistorySaveStyle SaveIncrementally
}
if ($ShowProfilePath) {
Write-Output "PowerShell history is set to: $(if ($isVSCode) { 'Project-Specific' } else { 'Global' })"
}







