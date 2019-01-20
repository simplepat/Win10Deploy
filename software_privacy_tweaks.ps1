##################
# OFFICE TELEMETRY
##################

Write-Host "Disabling Office Telemetry..."
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\15.0\osm -RegValue enablelogging -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\15.0\osm -RegValue enablefileobfuscation -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\15.0\osm -RegValue enableupload -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\16.0\Common -RegValue sendcustomerdata -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\16.0\Common -RegValue qmenable -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\16.0\Common -RegValue updatereliabilitydata -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\16.0\Common\PTWatson -RegValue ptwoptin -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\16.0\Common\Feedback -RegValue enabled -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\16.0\Common\Feedback -RegValue includescreenshot -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\16.0\Common\Feedback -RegValue includescreenshot -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\16.0\osm -RegValue enablelogging -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\16.0\osm -RegValue enablefileobfuscation -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\16.0\osm -RegValue enableupload -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\16.0\Lync -RegValue disableautomaticsendtracing -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Microsoft\Office\16.0\Outlook\Options\Mail -RegValue EnableLogging -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Microsoft\Office\16.0\Word\Options -RegValue EnableLogging -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\17.0\osm -RegValue enablelogging -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\17.0\osm -RegValue enablefileobfuscation -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Office\17.0\osm -RegValue enableupload -RegData 0 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Microsoft\Office\Common\ClientTelemetry -RegValue DisableTelemetry -RegData 1 -RegType DWord
Set-Registry -RegKey HKCU:\Software\Microsoft\Office\Common\ClientTelemetry -RegValue VerboseLogging -RegData 0 -RegType DWord

###################
# FIREFOX TELEMETRY
###################

Write-Host "Disabling Firefox Telemetry..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Mozilla\Firefox -RegValue DisableTelemetry -RegData 1 -RegType DWord
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Firefox\LockPref -RegValue toolkit.telemetry.enabled -RegData 0 -RegType DWord


##################
# CHROME TELEMETRY
##################

# Write-Host "Disabling Chrome Telemetry..."
# Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Google\Chrome\Recommended -RegValue MetricsReportingEnabled -RegData 0 -RegType DWord
# Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Google\Chrome\Recommended -RegValue DeviceMetricsReportingEnabled -RegData 0 -RegType DWord
# Set-Registry -RegKey HKCU:\Software\Policies\Google\Chrome\Recommended -RegValue MetricsReportingEnabled -RegData 0 -RegType DWord
# Set-Registry -RegKey HKCU:\Software\Policies\Google\Chrome\Recommended -RegValue DeviceMetricsReportingEnabled -RegData 0 -RegType DWord
# Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Google\Chrome -RegValue MetricsReportingEnabled -RegData 0 -RegType DWord
# Set-Registry -RegKey HKCU:\Software\Policies\Google\Chrome -RegValue MetricsReportingEnabled -RegData 0 -RegType DWord
# Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Google\Chrome -RegValue DeviceMetricsReportingEnabled -RegData 0 -RegType DWord
# Set-Registry -RegKey HKCU:\Software\Policies\Google\Chrome -RegValue DeviceMetricsReportingEnabled -RegData 0 -RegType DWord


################
# ADOBE SERVICES
################

Write-Host "Disabling Adobe services..."

# Adobe Genuine Monitor Service | AGMService
Write-Host "Stopping and disabling Adobe Genuine Monitor Service..."
Set-Service AGMService -StartupType Disabled
Stop-Service AGMService

# Adobe Genuine Software Integrity Service | AGSService
Write-Host "Stopping and disabling Adobe Genuine Software Integrity Service..."
Set-Service AGSService -StartupType Disabled
Stop-Service AGSService

# Remove adobe scheduled task
schtasks.exe /Change /TN "AdobeGCInvoker*" /disable




#######
# OTHER
#######

# PGP SERVICE
Set-Service DirMngr -StartupType Manual
Stop-Service DirMngr

# CCLEANER REMOVE FROM BIN CONTEXT
Remove-Item -Path "HKCR:\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\shell\Open CCleaner..." -Recurse
Remove-Item -Path "HKCR:\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\shell\Run CCleaner" -Recurse
schtasks /delete /tn "CCleaner Update" /f


# REMOVE CRAP FROM STARTUP
$software = @("*OneDrive*",
			  "*Spotify*",
			  "*Java*",
			  "*Skype*",
			  "*Adobe*",
			  "*Ccleaner*")
			
$path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"

For ($i=0; $i -lt $software.Length; $i++) {
	Get-CimInstance Win32_StartupCommand | Where-Object {$_.Name -like $software[$i]} | ForEach-Object {
	(Get-ItemProperty $path).psobject.properties | 
		where {$_.value -like $software[$i]} | ForEach-Object {
			Write-Host 'Removing value ', $_.name, $_.value
			Remove-ItemProperty -Path $path -Name $_.name -Force -Whatif
		}
	}			
}


