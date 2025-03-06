# # Setup script to configure project-specific history in VS Code

# $profilePath = "$PROFILE"
# $repoProfilePath = "$PWD\PowerShell-Profile.ps1"

# Write-Output "Setting up PowerShell profile..."

# # Backup existing profile (if any)
# if (Test-Path $profilePath) {
#     Copy-Item -Path $profilePath -Destination "$profilePath.bak" -Force
#     Write-Output "Existing profile backed up as Microsoft.PowerShell_profile.ps1.bak"
# }

# # Copy the new profile to the correct location
# Copy-Item -Path $repoProfilePath -Destination $profilePath -Force

# Write-Output "PowerShell profile setup complete! Restart VS Code and PowerShell to apply changes."
# Setup script to configure project-specific history in VS Code

$profilePath = "$PROFILE"
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoProfilePath = "$scriptDirectory\PowerShell-Profile.ps1"

Write-Output "Setting up PowerShell profile..."

# Check if the profile file exists in the repo
if (-not (Test-Path $repoProfilePath)) {
    Write-Error "Error: PowerShell-Profile.ps1 not found in project directory: $scriptDirectory"
    Read-Host "`nPress Enter to exit"
    exit
}

Write-Output "Setting up PowerShell profile..."

# Backup existing profile (if any)
if (Test-Path $profilePath) {
    Copy-Item -Path $profilePath -Destination "$profilePath.bak" -Force
    Write-Output "Existing profile backed up as Microsoft.PowerShell_profile.ps1.bak"
}

# Ask user for preferences
$showHistoryPath = Read-Host "Do you want to print the history file path on startup? (yes/no)(default: yes)"
$showProfilePath = Read-Host "Do you want to print the PowerShell profile path on startup? (yes/no)(default: yes)"

# Convert responses to Boolean values
$showHistoryPath = if ($showHistoryPath -match "^(n|no|N|No)$") { '$False' } else { '$True' }
$showProfilePath = if ($showProfilePath -match "^(n|no|N|No)$") { '$False' } else { '$True' }

# Update PowerShell-Profile.ps1 with user preferences
$profileContent = Get-Content $repoProfilePath -Raw

# Replace existing preference values
$profileContent = $profileContent -replace '\$ShowHistoryPath = \$\w+', "`$ShowHistoryPath = $showHistoryPath"
$profileContent = $profileContent -replace '\$ShowProfilePath = \$\w+', "`$ShowProfilePath = $showProfilePath"

# Save the modified profile
Set-Content -Path $repoProfilePath -Value $profileContent -Encoding utf8

# Copy the updated profile to the correct location
Copy-Item -Path $repoProfilePath -Destination $profilePath -Force

Write-Output "PowerShell profile setup complete! Restart VS Code and PowerShell to apply changes."
# Wait for user to press Enter before exiting
Read-Host "`nPress Enter to exit"