# DISABLE BLUETOOTH
Write-Host "Disabling Bluetooth..."
[CmdletBinding()] Param (
    [Parameter(Mandatory=$true)][ValidateSet('Off', 'On')][string]$BluetoothStatus
)
If ((Get-Service bthserv).Status -eq 'Stopped') { Start-Service bthserv }
Add-Type -AssemblyName System.Runtime.WindowsRuntime
$asTaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMethods() | ? { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' })[0]
Function Await($WinRtTask, $ResultType) {
    $asTask = $asTaskGeneric.MakeGenericMethod($ResultType)
    $netTask = $asTask.Invoke($null, @($WinRtTask))
    $netTask.Wait(-1) | Out-Null
    $netTask.Result
}
[Windows.Devices.Radios.Radio,Windows.System.Devices,ContentType=WindowsRuntime] | Out-Null
[Windows.Devices.Radios.RadioAccessStatus,Windows.System.Devices,ContentType=WindowsRuntime] | Out-Null
Await ([Windows.Devices.Radios.Radio]::RequestAccessAsync()) ([Windows.Devices.Radios.RadioAccessStatus]) | Out-Null
$radios = Await ([Windows.Devices.Radios.Radio]::GetRadiosAsync()) ([System.Collections.Generic.IReadOnlyList[Windows.Devices.Radios.Radio]])
$bluetooth = $radios | ? { $_.Kind -eq 'Bluetooth' }
[Windows.Devices.Radios.RadioState,Windows.System.Devices,ContentType=WindowsRuntime] | Out-Null
Await ($bluetooth.SetStateAsync($BluetoothStatus)) ([Windows.Devices.Radios.RadioAccessStatus]) | Out-Null

# PATCH HOSTS FILE (& adds additional telemetry IPs)
Write-Host "Patching hosts file to block ads..."
Set-Service Dnscache -StartupType Manual
Stop-Service Dnscache
cd $env:LOCALAPPDATA
git clone https://github.com/StevenBlack/hosts.git
cd .\hosts
Copy-Item -Path $PSScriptRoot\resources\myhosts -Destination .
pip install --user -r requirements.txt
python updateHostsFile.py --auto --replace --backup --extensions fakenews
cd $PSScriptRoot

# SET BIN SIZE TO 2GB MAX
Write-Host "Setting max bin size..."
Get-ChildItem HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\BitBucket\Volume | Set-ItemProperty -Name MaxCapacity -Value 2000

# CLOSE-LID ACTION: DO NOTHING
Write-Host "Setting close-lid action..."
powercfg -setacvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
powercfg -setdcvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0

# REMOVE ALL RESTORE POINTS
Write-Host "Removing all restore points..."
$removeDate = Get-Date
Get-ComputerRestorePoint | Where { $_.ConvertToDateTime($_.CreationTime) -lt  $removeDate } | Delete-ComputerRestorePoints

# DISABLE RESTORE POINTS
Write-Host "Disabling restore points..."
Disable-ComputerRestore -Drive "C:\"
vssadmin delete shadows /all /Quiet
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore -RegValue DisableConfig -RegData 1 -RegType DWord
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore -RegValue DisableSR -RegData 1 -RegType DWord
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore -RegValue DisableConfig -RegData 1 -RegType DWord
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore -RegValue DisableSR -RegData 1 -RegType DWord
schtasks.exe /Change /TN "\Microsoft\Windows\SystemRestore\SR" /disable
	
# DISK CLEANUP (system files & old windows installs files, if any)
Write-Host "Cleaning up disk..."
cleanmgr.exe /VERYLOWDISK
cleanmgr.exe /AUTOCLEAN

# REMOVE CRAPPY FOLDERS
Write-Host "Removing crappy folders from C:..."
Remove-Item –path c:\PerfLogs –recurse
Remove-Item –path c:\Intel –recurse
Remove-Item -path $env:USERPROFILE\MicrosoftEdgeBackups -recurse
Remove-Item ($env:USERPROFILE+'\Pictures\Camera Roll') -Recurse -Force
Remove-Item ($env:USERPROFILE+'\Pictures\Saved Pictures') -Recurse -Force

# REMOVE ITEMS FROM CONTEXT MENU
Write-Host "Removing 'Share' & 'Add to library' in context menu"
Remove-Item -Path HKCR:\*\shellex\ContextMenuHandlers\ModernSharing -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location" -Recurse -Force -ErrorAction SilentlyContinue

# ADDING 'TAKE OWNERSHIP' command to the context menu
regedit /s .\utils\Add_Take_Ownership_with_Pause_to_context_menu.reg

# PIN ITEMS IN QUICK ACCESS
Write-Host "Pinning items to quick access..."
$o = new-object -com shell.application
$o.Namespace($env:USERPROFILE).Self.InvokeVerb("pintohome")

# ADD SECONDARY EN-US KEYBOARD
Write-Host "Adding secondary en-US keyboard..."
$langs = Get-WinUserLanguageList
$langs.Add("en-US")
Set-WinUserLanguageList $langs -Force



#################
# PERSONNAL STUFF
#################

# CREATE ICONS IN TASKBAR
Write-Host "Applying pre-defined taskbar layout..."
Import-StartLayout -LayoutPath .\resources\StartLayout.xml -MountPath C:\

# SET PICTURE AS DESKTOP BACKGROUND
Write-Host "Setting desktop background..."
Set-ItemProperty -path "HKCU:\Control Panel\Desktop" -name WallPaper -value .\resources\milky_way_15-wallpaper-3840x1600.jpg
rundll32.exe user32.dll,UpdatePerUserSystemParameters ,1 ,True

# SET DEFAULT APPS
Write-Host "Setting pre-defined default apps..."
dism /online /Import-DefaultAppAssociations:".\resources\AppAssociations.xml"

