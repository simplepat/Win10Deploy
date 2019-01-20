. .\utils\Set-Registry.ps1

# Disable Remote Assistance
Write-Host "Disabling Remote Assistance..."
Set-Registry -RegKey "HKLM:\System\CurrentControlSet\Control\Remote Assistance" -RegValue fAllowToGetHelp -RegData 0 -RegType DWord

# Disable Remote Desktop
Write-Host "Disabling Remote Desktop..."
Set-Registry -RegKey "HKLM:\System\CurrentControlSet\Control\Terminal Server" -RegValue fDenyTSConnections -RegData 1 -RegType DWord
Set-Registry -RegKey "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -RegValue UserAuthentication -RegData 1 -RegType DWord
 
# Disable Action Center
Write-Host "Disabling Action Center..."
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Windows\Explorer -RegValue DisableNotificationCenter -RegData 1 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications -RegValue ToastEnabled -RegData 0 -RegType DWord

# Disable Autoplay
Write-Host "Disabling Autoplay..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers -RegValue DisableAutoplay -RegData 1 -RegType DWord

# Disable touch keyboard popup on login
Write-Host "Disabling touch keyboard popup on login..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic -RegValue FirstRunSucceeded -RegData 0 -RegType DWord
 
# Disable Autorun for all drives
Write-Host "Disabling Autorun for all drives..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -RegValue NoDriveTypeAutoRun -RegData 255 -RegType DWord

# Disable Sticky keys prompt
Write-Host "Disabling Sticky keys prompt..."
Set-Registry -RegKey "HKCU:\Control Panel\Accessibility\StickyKeys" -RegValue Flags -RegData 506 -RegType String

# Change date & time format
Write-Host "Changing date & time format..."
Set-Registry -RegKey "HKCU:\Control Panel\International" -RegValue sShortDate -RegData "dd-MM-yyyy" -RegType String
Set-Registry -RegKey "HKCU:\Control Panel\International" -RegValue sTimeFormat -RegData "HH:mm:ss" -RegType String
Set-Registry -RegKey "HKCU:\Control Panel\International" -RegValue sShortTime -RegData "HH:mm" -RegType String
 
# Hide Search button / box (will be replaced by Wox)
Write-Host "Hiding Search Box / Button..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\Search -RegValue SearchboxTaskbarMode -RegData 0 -RegType DWord

# Show known file extensions
Write-Host "Showing known file extensions..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -RegValue HideFileExt -RegData 0 -RegType DWord
 
# Show hidden files
Write-Host "Showing hidden files..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -RegValue Hidden -RegData 1 -RegType DWord
 
# Change default Explorer view to "This PC"
Write-Host "Changing default Explorer view to This PC..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -RegValue LaunchTo -RegData 1 -RegType DWord
 
# Remove Videos icon from computer namespace
Write-Host "Removing Videos icon from computer namespace..."
Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" -Recurse -ErrorAction SilentlyContinue

# Remove 3D Objects icon from computer namespace
Write-Host "Removing 3D Objects icon from computer namespace..."
Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue

# Remove Music icon from computer namespace
Write-Host "Removing Music icon from computer namespace..."
Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Recurse -ErrorAction SilentlyContinue

# Remove Libraries icon from computer namespace
#Write-Host "Removing Libraries icon from computer namespace..."
#Set-Registry -RegKey "HKCR:\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" -RegValue "System.IsPinnedToNameSpaceTree" -RegData 0 -RegType DWord
#Set-ItemProperty -Path "HKCR:\Wow6432Node\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" -Name "System.IsPinnedToNameSpaceTree" -Type DWord -Value 0

# Remove OneDrive icon from computer namespace
Write-Host "Removing OneDrive icon from computer namespace..."
Set-Registry -RegKey "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -RegValue "System.IsPinnedToNameSpaceTree" -RegData 0 -RegType DWord
Set-Registry -RegKey "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -RegValue  "System.IsPinnedToNameSpaceTree" -RegData 0 -RegType DWord

# Disable Quick Access: recent/frequent files
Write-Host "Disabling quick access - recent/frequent files..."
Set-Registry -RegKey HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -RegValue ShowRecent -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -RegValue NoRecentDocsHistory -RegData 1 -RegType DWord
Set-Registry -RegKey HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -RegValue ShowFrequent -RegData 0 -RegType DWord

# Set "Open with..." to always open with another app (no store)
Write-Output "Disabling search for app in store for unknown extensions..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -RegValue NoUseStoreOpenWith -RegData 1 -RegType DWord

# Dark theme for Windows
Write-Host "Enabling dark theme..."
Set-Registry -RegKey HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -RegValue AppsUseLightTheme -RegData 0 -RegType DWord

# Disabling shared experiences
Write-Output "Disabling Shared Experiences..."
Set-Registry -RegKey HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP -RegValue RomeSdkChannelUserAuthzPolicy -RegData 0 -RegType DWord

# Disabling scheduled defragmentation
Write-Output "Disabling scheduled defragmentation..."
Disable-ScheduledTask -TaskName "Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null

# Show task manager details
Write-Output "Showing task manager details..."
If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager")) {
	New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Force | Out-Null
}
$preferences = Get-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager -Name Preferences -ErrorAction SilentlyContinue
If (!($preferences)) {
	$taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
	While (!($preferences)) {
		Start-Sleep -m 250
		$preferences = Get-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager -Name Preferences -ErrorAction SilentlyContinue
	}
	Stop-Process $taskmgr
}
$preferences.Preferences[28] = 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager -Name Preferences -Type Binary -Value $preferences.Preferences

# Show file operations details
Write-Output "Showing file operations details..."
Set-Registry -RegKey HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager -RegValue EnthusiastMode -RegData 1 -RegType DWord

# Enable file delete confirmation dialog
Write-Output "Enabling file delete confirmation dialog..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -RegValue ConfirmFileDelete -RegData 1 -RegType DWord

# Hide people icon
Write-Output "Hiding People icon in taskbar..."
Set-Registry -RegKey HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People -RegValue PeopleBand -RegData 0 -RegType DWord

# Hide task view button 
Set-Registry -RegKey HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -RegValue ShowTaskViewButton -RegData 0 -RegType DWord

# Enable Num Lock on startup
Write-Output "Enabling NumLock after startup..."	
Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 2147483650
Add-Type -AssemblyName System.Windows.Forms
If (!([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
	$wsh = New-Object -ComObject WScript.Shell
	$wsh.SendKeys('{NUMLOCK}')
}

# Disable Xbox game mode
Write-Output "Disabling Xbox game mode..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR -RegValue AllowGameDVR -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Microsoft\GameBar -RegValue AllowAutoGameMode -RegData 0 -RegType DWord

# Disable licence checking
Write-Output "Disabling licence checking..."
Set-Registry -RegKey "HKLM:\Software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" -RegValue NoGenTicket -RegData 1 -RegType DWord

