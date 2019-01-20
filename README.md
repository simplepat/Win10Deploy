# Win10Deploy

*This script automates all Windows 10 system setup steps for a 'standard' developper system (mine, at least :))
*It consists in setting up a full-privacy mode, tweaking the UI, configuring scheduled tasks, startup and services, installing basic dev software & environment, and do a bit of cleaning
*The script was created for personal needs (and tested on a Win10 v1809 virtual machine), however it can easily be tweaked by commenting/decommenting stuff
*There is no "rollback" for each of the tweaks here, so make sure you know what you are doing BEFORE launching, or just comment if you don't !

Note: the script's a first shot, more tweaks and stabilizing/refactoring to come ! 

## Getting Started

### Prerequisites

Start MS Powershell session and allow script from the internet

```
Set-ExecutionPolicy Unrestricted
```

### Installing

```
.\deploy.ps1
```

The deployment process can be broken down to 7 parts:

* Privacy: enforces all privacy settings to max (until build 1809)
* Removes memory-consuming MS scheduled tasks (ie sending telemetry, checking for licence...)
* Tweak all the UI & experience through registry
* Uninstalling unused MS features (ie Hyper-V, IE...)
* Install software
* Enforce software privacy
* Setup (mostly disable) unused services

You're free to comment out those parts according to your needs.


## License

"THE BEER-WARE LICENSE" (Revision 42):

As long as you retain this notice you can do whatever you want with this
stuff. If we meet some day, and you think this stuff is worth it, you can
buy us a beer in return.

This project is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.

## Acknowledgments

* Thanks to Steven Black for hosts file patching: https://github.com/StevenBlack/hosts.git
* Thanks to Dominik Britz (Set-Registry function): https://github.com/DominikBritz
* Thanks to DBremen (Delete-ComputerRestorePoint function): https://github.com/DBremen

