<powershell>

# Beginning of bootstrap script
# This script bootstraps the Windows system and is loaded through user data
#

# Create Terraform directory 
$path = 'C:\terraform'
if (-not (Test-Path $path)) {
  New-Item $path -ItemType directory
}

# Set logfile and function for writing logfile
$logfile = "C:\Terraform\user_data.log"
Function lwrite {
    Param ([string]$logstring)
    Add-Content $logfile -value $logstring
}

$mtime = Get-Date
lwrite("$mtime Starting bootstrap powershell script")

$user = "${auser}"
$test = Get-LocalUser | Where-Object {$_.Name -eq $user}
if ( -not $test) {
  $mtime = Get-Date
  lwrite("$mtime Creating new local username: $user")
  & net user $user ${apwd} /add /y
  lwrite("$mtime Adding username to local Administrators Group")
  & net localgroup administrators $user /add
}

### Force Enabling WinRM and skip profile check
$mtime = Get-Date
lwrite("$mtime Enabling PSRemoting SkipNetworkProfileCheck")
Enable-PSRemoting -SkipNetworkProfileCheck -Force 

$mtime = Get-Date
lwrite("$mtime Set Execution Policy Unrestricted")
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

$ComputerName = "$env:computername"
$RemoteHostName = $ComputerName + ".rtc.local" 
$Cert = New-SelfSignedCertificate -DnsName $RemoteHostName, $ComputerName `
    -CertStoreLocation "cert:\LocalMachine\My" `
    -FriendlyName "Test WinRM Cert"

$Cert | Out-String

$Thumbprint = $Cert.Thumbprint

lwrite("$mtime Enable HTTPS in WinRM")
$WinRmHttps = "@{Hostname=`"$RemoteHostName`"; CertificateThumbprint=`"$Thumbprint`"}"
winrm create winrm/config/Listener?Address=*+Transport=HTTPS $WinRmHttps

lwrite("$mtime Set Basic Auth in WinRM")
$WinRmBasic = "@{Basic=`"true`"}"
winrm set winrm/config/service/Auth $WinRmBasic

lwrite("$mtime Open Firewall Ports and disable firewall just in case")
netsh advfirewall firewall add rule name="Windows Remote Management (HTTP-In)" dir=in action=allow protocol=TCP localport=5985
netsh advfirewall firewall add rule name="Windows Remote Management (HTTPS-In)" dir=in action=allow protocol=TCP localport=5986
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

### Force Enabling WinRM and skip profile check
Enable-PSRemoting -SkipNetworkProfileCheck -Force

# Set Trusted Hosts * for WinRM HTTPS
Set-Item -Force wsman:\localhost\client\trustedhosts *

$mtime = Get-Date
lwrite("$mtime End bootstrap powershell script")
</powershell>
<persist>true</persist>
