# Install and configure IIS
Write-Host "Installing IIS..."
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Create admin user and set password
$adminUsername = "praveen"
$adminPassword = "Healthedge" | ConvertTo-SecureString -AsPlainText -Force
Write-Host "Creating admin user..."
New-LocalUser -Name $adminUsername -Password $adminPassword -FullName "Admin User" -Description "Administrator account"
Add-LocalGroupMember -Group "Administrators" -Member $adminUsername

Install Git using Chocolatey
# Write-Host "Installing Chocolatey..."
# Set-ExecutionPolicy Bypass -Scope Process -Force
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
# iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Write-Host "Installing Git..."
# choco install git -y

# Configure inbound firewall rules
Write-Host "Configuring inbound firewall rules for ports 5985, 5986, and ICMPv4..."
New-NetFirewallRule -DisplayName "Allow WinRM HTTP" -Direction Inbound -Protocol TCP -LocalPort 5985 -Action Allow
New-NetFirewallRule -DisplayName "Allow WinRM HTTPS" -Direction Inbound -Protocol TCP -LocalPort 5986 -Action Allow
New-NetFirewallRule -DisplayName "Allow ICMPv4-In" -Direction Inbound -Protocol ICMPv4 -Action Allow

Write-Host "Configuration complete!"
