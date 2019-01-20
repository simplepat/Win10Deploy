. .\utils\Set-Registry.ps1


#########
# PRIVACY
#########

Write-Host "Disabling error reporting (1/3)..."
Set-Registry -RegKey "HKCU:\Software\Microsoft\Windows\Windows Error Reporting" -RegValue Disabled -RegData 1 -RegType DWord
Write-Host "Disabling error reporting (2/3)..."
Set-Registry -RegKey "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" -RegValue Disabled -RegData 1 -RegType DWord
Write-Host "Disabling error reporting (3/3)..."
Set-Registry -RegKey "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -RegValue Disabled -RegData 1 -RegType DWord
Write-Host "Disabling handwriting data sharing (1/2)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC -RegValue PreventHandwritingDataSharing -RegData 1 -RegType DWord
Write-Host "Disabling handwriting data sharing (2/2)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports -RegValue PreventHandwritingErrorReports -RegData 1 -RegType DWord
Write-Host "Disabling inventory..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat -RegValue DisableInventory -RegData 1 -RegType DWord
Write-Host "Disabling lock screen camera..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -RegValue NoLockScreenCamera -RegData 1 -RegType DWord
Write-Host "Disabling Advertising ID (1/3)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -RegValue Enabled -RegData 0 -RegType DWord
Write-Host "Disabling Advertising ID (2/3)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo -RegValue Enabled -RegData 0 -RegType DWord
Write-Host "Disabling Advertising ID (3/3)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo -RegValue DisabledByGroupPolicy -RegData 1 -RegType DWord
Write-Host "Disabling transmission of typing information..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Input\TIPC -RegValue Enabled -RegData 0 -RegType DWord
Write-Host "Disabling advertising..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\System -RegValue AllowExperimentation -RegData 0 -RegType DWord
Write-Host "Disabling advertising through bluetooth..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Bluetooth -RegValue AllowAdvertising -RegData 0 -RegType DWord
Write-Host "Disabling Customer Experience Improvement Program (1/2)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\SQMClient\Windows -RegValue CEIPEnable -RegData 0 -RegType DWord
Write-Host "Disabling Customer Experience Improvement Program (2/2)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows -RegValue CEIPEnable -RegData 0 -RegType DWord
Write-Host "Disabling backup of messages in the cloud..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\Messaging -RegValue AllowMessageSync -RegData 0 -RegType DWord
Write-Host "Disabling app notifications..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications -RegValue ToastEnabled -RegData 0 -RegType DWord
Write-Host "Disabling access to local language for browsers..."
Set-Registry -RegKey "HKCU:\Control Panel\International\User Profile" -RegValue HttpAcceptLanguageOptOut -RegData 1 -RegType DWord
Write-Host "Disabling settings app online tips..."
Set-Registry -RegKey HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -RegValue AllowOnlineTips -RegData 0 -RegType DWord
Write-Host "Disabling SmartScreen (1/2)..."
Set-Registry -RegKey HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer -RegValue SmartScreenEnabled -RegData Off -RegType String
Write-Host "Disabling SmartScreen (2/2)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost -RegValue EnableWebContentEvaluation -RegData 0 -RegType DWord
Write-Host "Disabling Telemetry (1/5)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection -RegValue AllowTelemetry -RegData 0 -RegType DWord
Write-Host "Disabling Telemetry (2/5)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection -RegValue AllowTelemetry -RegData 0 -RegType DWord
Write-Host "Disabling Telemetry (3/5)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat -RegValue AITEnable -RegData 0 -RegType DWord
Write-Host "Disabling Telemetry (4/5)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy -RegValue TailoredExperiencesWithDiagnosticDataEnabled -RegData 0 -RegType DWord
Write-Host "Disabling Telemetry (5/5)..."
Set-Registry -RegKey HKCU:\Software\Policies\Microsoft\Windows\CloudContent -RegValue DisableTailoredExperiencesWithDiagnosticData -RegData 1 -RegType DWord

Write-Host "Removing AutoLogger file and restricting directory..."
$autoLoggerDir = "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
If (Test-Path "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl") {
    Remove-Item "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl"
}
icacls $autoLoggerDir /deny SYSTEM:`(OI`)`(CI`)F | Out-Null


#############
# APP PRIVACY
#############

Write-Host "Disabling location sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling user account sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation -RegValue Value -RegData Deny -RegType String
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -RegValue Start_TrackProgs -RegData 0 -RegType DWord
Set-Registry -RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2297E4E2-5DBE-466D-A12B-0F8286F0D9CA}" -RegValue Value -RegData Deny -RegType String
Set-Registry -RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}" -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling webcam sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling microphone sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling contacts sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling appointments sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling phone call history sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling email sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling user data sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling chat history sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling documents library sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling pictures library sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling videos library sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling file system access sharing consent..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling background apps (1/3)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications -RegValue Disabled -RegData 1 -RegType DWord
Write-Host "Disabling background apps (2/3)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications -RegValue DisabledByUser -RegData 1 -RegType DWord
Write-Host "Disabling background apps (3/3)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications -RegValue GlobalUserDisabled -RegData 1 -RegType DWord


##########
# SECURITY
##########

Write-Host "Disabling password reveal in Edge..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredUI -RegValue DisablePasswordReveal -RegData 1 -RegType DWord
Write-Host "Disabling user steps recorder (UAR)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat -RegValue DisableUAR -RegData 1 -RegType DWord
Write-Host "Disabling autologger..."
Set-Registry -RegKey HKLM:\System\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener -RegValue Start -RegData 0 -RegType DWord
Write-Host "Disabling Windows Media DRM download..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\WMDRM -RegValue DisableOnline -RegData 1 -RegType DWord
Write-Host "Disabling app access to wireless connections..."
Set-Registry -RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" -RegValue Value -RegData Deny -RegType String
Write-Host "Disabling app access to loosely coupled devices..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled -RegValue Value -RegData Deny -RegType String


######
# EDGE
######

Write-Host "Disabling tracking in the web (1/2)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main -RegValue DoNotTrack -RegData 1 -RegType DWord
Write-Host "Disabling tracking in the web (2/2)..."
Set-Registry -RegKey "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" -RegValue DoNotTrack -RegData 1 -RegType DWord
Write-Host "Disabling page prediction..."
Set-Registry -RegKey "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead" -RegValue FPEnabled -RegData 0 -RegType DWord
Write-Host "Disabling web search suggestions..."
Set-Registry -RegKey "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes" -RegValue ShowSearchSuggestionsGlobal -RegData 0 -RegType DWord
Write-Host "Disabling automatic completion of web addresses in address bar..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Browser -RegValue AllowAddressBarDropdown -RegData 0 -RegType DWord
Write-Host "Disabling web search results reading optimization..."
Set-Registry -RegKey "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" -RegValue OptimizeWindowsSearchResultsForScreenReaders -RegData 0 -RegType DWord
Write-Host "Disabling smartscreen filter (web)..."
Set-Registry -RegKey "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" -RegValue EnabledV9 -RegData 0 -RegType DWord
Write-Host "Disabling Edge data collection..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection -RegValue MicrosoftEdgeDataOptin -RegData 0 -RegType DWord


################
# SYNCHONIZATION
################

Write-Host "Disabling synchronization of all settings..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync -RegValue SyncPolicy -RegData 5 -RegType DWord
Write-Host "Disabling synchronization of design settings..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization -RegValue Enabled -RegData 0 -RegType DWord
Write-Host "Disabling synchronization of browser settings..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings -RegValue Enabled -RegData 0 -RegType DWord
Write-Host "Disabling synchronization of credentials..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials -RegValue Enabled -RegData 0 -RegType DWord
Write-Host "Disabling synchronization of language settings..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language -RegValue Enabled -RegData 0 -RegType DWord
Write-Host "Disabling synchronization of accessibility settings..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility -RegValue Enabled -RegData 0 -RegType DWord
Write-Host "Disabling synchronization of advanced Windows settings..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows -RegValue Enabled -RegData 0 -RegType DWord
Write-Host "Disabling synchronization (1/2)..."
Set-Registry -RegKey HKLM:\Software\Policies\Microsoft\Windows\SettingSync -RegValue DisableSettingSync -RegData 2 -RegType DWord
Write-Host "Disabling synchronization (2/2)..."
Set-Registry -RegKey HKLM:\Software\Policies\Microsoft\Windows\SettingSync -RegValue DisableSettingSyncUserOverride -RegData 1 -RegType DWord



#########
# CORTANA
#########

Write-Host "Disabling Cortana (1/15)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana -RegValue value -RegData 0 -RegType DWord
Write-Host "Disabling Cortana (2/15)..."
Set-Registry -RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\Windows Search" -RegValue CortanaConsent -RegData 0 -RegType DWord
Write-Host "Disabling Cortana (3/15)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Personalization\Settings -RegValue AcceptedPrivacyPolicy -RegData 0 -RegType DWord
Write-Host "Disabling Cortana (4/15)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\InputPersonalization -RegValue AcceptedPrivacyPolicy -RegData 0 -RegType DWord
Write-Host "Disabling Cortana (5/15)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\InputPersonalization -RegValue RestrictImplicitInkCollection -RegData 1 -RegType DWord
Write-Host "Disabling Cortana (6/15)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\InputPersonalization -RegValue RestrictImplicitTextCollection -RegData 1 -RegType DWord
Write-Host "Disabling Cortana (7/15)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\InputPersonalization -RegValue HarvestContacts -RegData 0 -RegType DWord
Write-Host "Disabling Cortana (8/15)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore -RegValue HarvestContacts -RegData 0 -RegType DWord
Write-Host "Disabling Cortana (9/15)..."
Set-Registry -RegKey "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -RegValue AllowCortana -RegData 0 -RegType DWord
Write-Host "Disabling Cortana (10/15)..."
Set-Registry -RegKey "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -RegValue AllowSearchToUseLocation -RegData 0 -RegType DWord
Write-Host "Disabling Cortana (11/15)..."
Set-Registry -RegKey "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -RegValue DisableWebSearch -RegData 1 -RegType DWord
Write-Host "Disabling Cortana (12/15)..."
Set-Registry -RegKey "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -RegValue ConnectedSearchUseWeb -RegData 0 -RegType DWord
Write-Host "Disabling Cortana (13/15)..."
Set-Registry -RegKey "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -RegValue ConnectedSearchUseWebOverMeteredConnections -RegData 0 -RegType DWord
Write-Host "Disabling Cortana (14/15)..."
Set-Registry -RegKey "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -RegValue AllowCloudSearch -RegData 0 -RegType DWord
Write-Host "Disabling Cortana (15/15)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Speech_OneCore\Preferences -RegValue ModelDownloadAllowed -RegData 0 -RegType DWord


###################
# LOCATION SERVICES
###################

Write-Host "Disabling functionality to locate the system (1/2)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors -RegValue DisableLocation -RegData 1 -RegType DWord
Write-Host "Disabling functionality to locate the system (2/2)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors -RegValue DisableWindowsLocationProvider -RegData 1 -RegType DWord
Write-Host "Disabling scripting functionality to locate the system..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors -RegValue DisableLocationScripting -RegData 1 -RegType DWord
Write-Host "Disabling sensors to locate the system..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors -RegValue DisableSensors -RegData 1 -RegType DWord
Write-Host "Disabling OneDrive access to position..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive -RegValue DisableLocation -RegData 1 -RegType DWord


#################
# SENSOR SERVICES
#################

Write-Host "Disabling location tracking (1/5)..."
Set-Registry -RegKey "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -RegValue SensorPermissionState -RegData 0 -RegType DWord
Write-Host "Disabling location tracking (2/5)..."
Set-Registry -RegKey "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -RegValue SensorPermissionState -RegData 0 -RegType DWord
Write-Host "Disabling location tracking (3/5)..."
Set-Registry -RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -RegValue SensorPermissionState -RegData 0 -RegType DWord
Write-Host "Disabling location tracking (4/5)..."
Set-Registry -RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -RegValue Status -RegData 0 -RegType DWord
Write-Host "Disabling location tracking (5/5)..."
Set-Registry -RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -RegValue Value -RegData Deny -RegType String


############
# WIFI SENSE
############

Write-Host "Disabling Wi-Fi Sense (1/6)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting -RegValue value -RegData 0 -RegType DWord
Write-Host "Disabling Wi-Fi Sense (2/6)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots -RegValue value -RegData 0 -RegType DWord
Write-Host "Disabling Wi-Fi Sense (3/6)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\WiFiSenseCredShared -RegValue value -RegData 0 -RegType DWord
Write-Host "Disabling Wi-Fi Sense (4/6)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\WiFiSenseOpen -RegValue value -RegData 0 -RegType DWord
Write-Host "Disabling Wi-Fi Sense (5/6)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config -RegValue WiFISenseAllowed -RegData 0 -RegType DWord
Write-Host "Disabling Wi-Fi Sense (6/6)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config -RegValue AutoConnectAllowedOEM -RegData 0 -RegType DWord



################
# WINDOWS UPDATE
################

Write-Host "Disabling Windows Update via P2P (1/3)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config -RegValue DODownloadMode -RegData 0 -RegType DWord
Write-Host "Disabling Windows Update via P2P (2/3)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization -RegValue DODownloadMode -RegData 0 -RegType DWord
Write-Host "Disabling Windows Update via P2P (3/3)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization -RegValue SystemSettingsDownloadMode -RegData 0 -RegType DWord
Write-Host "Disabling update of speech data..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Speech -RegValue AllowSpeechModelUpdate -RegData 0 -RegType DWord
Write-Host "Changing Windows Updates to notify to schedule restart..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings -RegValue UxOption -RegData 1 -RegType DWord
Write-Host "Disabling update of maps (1/3)..."
Set-Registry -RegKey HKLM:\SYSTEM\Maps -RegValue AutoUpdateEnabled -RegData 0 -RegType DWord
Write-Host "Disabling update of maps (2/3)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\Maps -RegValue AutoDownloadAndUpdateMapData -RegData 0 -RegType DWord
Write-Host "Disabling update of maps (3/3)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\Maps -RegValue AllowUntriggeredNetworkTrafficOnSettingsPage -RegData 0 -RegType DWord
Write-Host "Disabling automatic & forced updates (1/4)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -RegValue NoAutoUpdate -RegData 0 -RegType DWord
Write-Host "Disabling automatic & forced updates (2/4)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -RegValue AUOptions -RegData 2 -RegType DWord
Write-Host "Disabling automatic & forced updates (3/4)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -RegValue ScheduledInstallDay -RegData 0 -RegType DWord
Write-Host "Disabling automatic & forced updates (4/4)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -RegValue ScheduledInstallTime -RegData 3 -RegType DWord


##################
# WINDOWS EXPLORER
##################

Write-Host "Disabling file explorer ads (1/2)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue SystemPaneSuggestionsEnabled -RegData 0 -RegType DWord
Write-Host "Disabling showing recently opened items in Start bar..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -RegValue Start_TrackDocs -RegData 0 -RegType DWord
Write-Host "Disabling file explorer ads (2/2)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -RegValue ShowSyncProviderNotifications -RegData 0 -RegType DWord
Write-Host "Disabling network traffic pre user sign-in..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\OneDrive -RegValue PreventNetworkTrafficPreUserSignIn -RegData 1 -RegType DWord


##################
# WINDOWS DEFENDER
##################

Write-Host "Disabling SpyNet reporting..."
Set-Registry -RegKey "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -RegValue SpyNetReporting -RegData 0 -RegType DWord
Write-Host "Disabling SpyNet samples submission..."
Set-Registry -RegKey "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -RegValue SubmitSamplesConsent -RegData 0 -RegType DWord
Write-Host "Disabling MS Defender sending reports on infections..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\MRT -RegValue DontReportInfectionInformation -RegData 1 -RegType DWord


#################
# CLOUD CLIPBOARD
#################

Write-Host "Disabling cloud clipboard (1/4)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -RegValue AllowClipboardHistory -RegData 0 -RegType DWord
Write-Host "Disabling cloud clipboard (2/4)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -RegValue EnableCloudClipboard -RegData 0 -RegType DWord
Write-Host "Disabling cloud clipboard (3/4)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -RegValue CloudClipboardAutomaticUpload -RegData 0 -RegType DWord
Write-Host "Disabling cloud clipboard (4/4)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent -RegValue DisableWindowsConsumerFeatures -RegData 1 -RegType DWord


###################
# TIMELINE FEATURES
###################

Write-Host "Disabling activity feed (1/3)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -RegValue EnableActivityFeed -RegData 0 -RegType DWord
Write-Host "Disabling activity feed (2/3)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -RegValue PublishUserActivities -RegData 0 -RegType DWord
Write-Host "Disabling activity feed (3/3)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -RegValue UploadUserActivities -RegData 0 -RegType DWord



######
# MISC
######

Write-Host "Disabling feedback (1/5)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Siuf\Rules -RegValue NumberOfSIUFInPeriod -RegData 0 -RegType DWord
Write-Host "Disabling feedback (2/5)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Siuf\Rules -RegValue PeriodInNanoSeconds -RegData 0 -RegType DWord
Write-Host "Disabling feedback (3/5)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Siuf\Rules -RegValue NumberOfSIUFInPeriod -RegData 0 -RegType DWord
Write-Host "Disabling feedback (4/5)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Microsoft\Siuf\Rules -RegValue PeriodInNanoSeconds -RegData 0 -RegType DWord
Write-Host "Disabling feedback (5/5)..."
Set-Registry -RegKey HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection -RegValue DoNotShowFeedbackNotifications -RegData 1 -RegType DWord
Write-Host "Disabling Bing Search in Start Menu..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\Search -RegValue BingSearchEnabled -RegData 0 -RegType DWord
Write-Host "Disabling lock screen picture change..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue RotatingLockScreenEnabled -RegData 0 -RegType DWord
Write-Host "Disabling lock screen advertising/rating..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue RotatingLockScreenOverlayEnabled -RegData 0 -RegType DWord
Write-Host "Disabling content delivery manager (1/11)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue SilentAppsEnabled -RegData 0 -RegType DWord
Write-Host "Disabling content delivery manager (2/11)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue SoftLandingEnabled -RegData 0 -RegType DWord
Write-Host "Disabling content delivery manager (3/11)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue SubscribedContent-338387Enabled -RegData 0 -RegType DWord
Write-Host "Disabling content delivery manager (4/11)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue SubscribedContent-338389Enabled -RegData 0 -RegType DWord
Write-Host "Disabling content delivery manager (5/11)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue SubscribedContent-338393Enabled -RegData 0 -RegType DWord
Write-Host "Disabling content delivery manager (6/11)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue SubscribedContent-353697Enabled -RegData 0 -RegType DWord
Write-Host "Disabling suggestions in timeline..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue SubscribedContent-353698Enabled -RegData 0 -RegType DWord
Write-Host "Disabling content delivery manager (7/11)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue ContentDeliveryAllowed -RegData 0 -RegType DWord
Write-Host "Disabling content delivery manager (8/11)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue OemPreInstalledAppsEnabled -RegData 0 -RegType DWord
Write-Host "Disabling content delivery manager (9/11)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue PreInstalledAppsEnabled -RegData 0 -RegType DWord
Write-Host "Disabling content delivery manager (10/11)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue PreInstalledAppsEnabled -RegData 0 -RegType DWord
Write-Host "Disabling content delivery manager (11/11)..."
Set-Registry -RegKey HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValue PreInstalledAppsEverEnabled -RegData 0 -RegType DWord
Write-Host "Disabling Windows tips (1/2)..."
Set-Registry -RegKey HKLM:\Software\Policies\Microsoft\Windows\CloudContent -RegValue DisableSoftLanding -RegData 1 -RegType DWord
Write-Host "Disabling Windows spotlight features..."
Set-Registry -RegKey HKLM:\Software\Policies\Microsoft\Windows\CloudContent -RegValue DisableWindowsSpotlightFeatures -RegData 1 -RegType DWord
Write-Host "Disabling Windows tips (2/2)..."
Set-Registry -RegKey HKLM:\Software\Policies\Microsoft\WindowsInkWorkspace -RegValue AllowSuggestedAppsInWindowsInkWorkspace -RegData 0 -RegType DWord
