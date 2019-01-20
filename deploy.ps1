 <#
.SYNOPSIS
This script automates all Windows 10 system setup steps for a 'standard' developper system (mine, at least)
It consists in setting up a full-privacy mode, tweaking the UI, configuration items and services,
installing basic dev software & environment, and do a bit of cleaning
The script was created for personal needs (and tested on a Win10 v1809 virtual machine), however it can easily be tweaked by commenting/decommenting stuff
There is no "rollback" for each of the tweaks here, so make sure you know what you are doing BEFORE launching, or just comment
.NOTES
Author: Patrick Marshall
Source: https://github.com/simplepat
Thanks: Steven Black (hosts file patching): https://github.com/StevenBlack/hosts.git
Thanks: Dominik Britz (set registry function): https://github.com/DominikBritz
Thanks: DBremen (Delete-ComputerRestorePoint function): https://github.com/DBremen
#>


$ProgressPreference = 'SilentlyContinue'
. .\utils\Delete-ComputerRestorePoint.ps1
. .\utils\Set-Registry.ps1

If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
}

If (!(Test-Path "HKU:")) {
	New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS | Out-Null
}


##################
# PRIVACY SETTINGS
##################

.\privacy_main.ps1


########################
# REMOVE SCHEDULED TASKS
########################

.\remove_win_schtasks.ps1


############################
# ADDITIONAL REGISTRY TWEAKS
############################

.\registry_tweaks.ps1


##############################
# UNINSTALL MS APPS & FEATURES
##############################
 
.\uninstall_ms_features.ps1 


##################
# INSTALL SOFTWARE
##################

.\install_software.ps1


####################################
# ADDITIONAL SETTINGS (FOR SOFTWARE)
####################################

.\software_privacy_tweaks.ps1


##################
# DISABLE SERVICES
##################

python .\setup_services.py


######################
# CUSTOM SYSTEM CONFIG
######################

.\custom_system_config_cleaning.ps1


#######
# OTHER
#######

#.\reimport_personnal_data.ps1

  
# RESTART
Write-Host
Write-Host "Press any key to restart your system..." -ForegroundColor Black -BackgroundColor White
$key = $host.UI.RawUI.ReadKey("NoEchoIncludeKeyDown")
Write-Host "Restarting..."
Restart-Computer


﻿