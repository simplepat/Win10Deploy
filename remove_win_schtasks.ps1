Write-Output "Removing Microsoft scheduled tasks..."
schtasks.exe /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Autochk\Proxy" /disable
schtasks.exe /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
schtasks.exe /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable
schtasks.exe /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /disable
schtasks.exe /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /disable
schtasks.exe /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable
schtasks.exe /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /disable
schtasks.exe /Change /TN "Microsoft\Windows\License Manager\TempSignedLicenseExchange" /disable
schtasks.exe /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /disable
schtasks.exe /Change /TN "Microsoft\Windows\Clip\License Validation" /disable
schtasks.exe /Change /TN "\Microsoft\Windows\ApplicationData\DsSvcCleanup" /disable
schtasks.exe /Change /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable
schtasks.exe /Change /TN "\Microsoft\Windows\PushToInstall\LoginCheck" /disable
schtasks.exe /Change /TN "\Microsoft\Windows\PushToInstall\Registration" /disable
schtasks.exe /Change /TN "\Microsoft\Windows\Shell\FamilySafetyMonitor" /disable
schtasks.exe /Change /TN "\Microsoft\Windows\Shell\FamilySafetyMonitorToastTask" /disable
schtasks.exe /Change /TN "\Microsoft\Windows\Shell\FamilySafetyRefreshTask" /disable
schtasks.exe /Change /TN "\Microsoft\Windows\Subscription\EnableLicenseAcquisition" /disable
schtasks.exe /Change /TN "\Microsoft\Windows\Subscription\LicenseAcquisition" /disable
del /F /Q "C:\Windows\System32\Tasks\Microsoft\Windows\SettingSync\*" 