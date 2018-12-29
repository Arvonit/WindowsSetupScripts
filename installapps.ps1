# Windows App Installation Script
# Author: SkinnyBonesArv

# Intro
Write-Host "Welcome to the app installation script!" -ForegroundColor Green
Write-Host "By SkinnyBonesArv`n" -ForegroundColor Green

# Check to see if script is ran elevated
$state = New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.Windowsidentity]::GetCurrent())
if (-NOT($state.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)))
{
    Write-Host "Script needs administrative privilleges to run. Exiting script..." -ForegroundColor Red
    exit
}

# Check to see if Chocolately is installed
if (-NOT(Get-Item "C:\ProgramData\chocolatey\choco.exe")) 
{   
    Write-Host "Chocolately not found. Installing..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Host "Chocolately install complete.`n" -ForegroundColor Green
}


# Prompt user for choice
$option = Read-Host @"
Please select one of the following options.
1 - Install default apps
2 - Install developer apps
3 - Install gaming apps
4 - Exit`n
"@

Write-Output ""

# Perform selected action
switch ($option) 
{
    # Install basic apps
    1 { Write-Host "Installing default apps..."; choco install defaultapps.config -y }
    # Install developer apps
    2 { Write-Host "Installing developer apps..."; choco install devapps.config -y }
    # Install gaming apps
    3 { Write-Host "Installing gaming apps..."; choco install gamingapps.config -y }
    # Exit script
    4 { Write-Host "Exiting script..."; exit }
}