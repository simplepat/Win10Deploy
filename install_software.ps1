function Refresh-EnvAndPath {
	refreshenv
	$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# INSTALL CHOCOLATEY PACKAGE MANAGER
Write-Host "Installing package manager..."
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation

Write-Host "Installing software..."

# CONSOLE
choco install git.install --params "/GitAndUnixToolsOnPath"
Refresh-EnvAndPath
choco install sourcecodepro conemu
Copy-Item -Path .\resources\ConEmu.xml -Destination $env:APPDATA

# UTILITIES
choco install vcredist-all dotnetfx

# CLI UTILITIES
choco install ffmpeg wget aria2 gpg4win-vanilla

# SOFTWARE
choco install 7zip.install firefox tor-browser thunderbird notepadplusplus.install ccleaner
choco install cloudstation office365proplus skype qbittorrent imageglass universal-usb-installer
choco install procmon winscp.install windirstat sumatrapdf.install lockhunter code-notes
choco install f.lux.install virtualclonedrive k-litecodecpackmega signal expressvpn
choco install spotify --ignore-checksums

# DEV
choco install anaconda3 --params ("/JustMe /AddToPath /D:"+$env:LOCALAPPDATA)
choco install vcpython27 visualstudio2017buildtools jdk8 mongodb robo3t.install 
Refresh-EnvAndPath

# PYTHON+SPARK ENV
Write-Host "Upgrading pip..."
python -m pip install --upgrade pip
pip install wget pywinauto jupyterthemes keras tensorflow tensorflow-gpu
Write-Host "Applying jupyter theme..."
jt -t onedork -f source
Write-Host "Creating python2 environment..."
conda create -n python2 python=2.7 -y
Write-Host "Installing Spark + jupyter kernel..."
.\scripts\install_spark.ps1
Write-Host "Setting Tensorflow as Keras backend..."
Copy-Item -Path .\resources\keras.json -Destination $env:USERPROFILE\.keras

# IDE
choco install pycharm-community intellijidea-community datagrip postman atom
choco install visualstudio2017community --package-parameters "--add Microsoft.VisualStudio.Workload.NativeGame;includeRecommended Component.Unreal Microsoft.VisualStudio.Component.Windows81SDK --quiet --norestart"
choco install epicgameslauncher

# ATOM PACKAGES
[Environment]::SetEnvironmentVariable("PATH", ($env:PATH + (';'+$env:LOCALAPPDATA+'\atom\bin')), "User")
Refresh-EnvAndPath
apm install autocomplete-python hyperclick atom-file-icons minimap script atom-beautify highlight-selected
apm install open-recent autoclose-html

# NETWORK UTILITIES
choco install wireshark winpcap nmap
python .\scripts\install_tmac.py

# DEVOPS/CLOUD
choco install docker-toolbox --params ("/COMPONENTS='dockercompose' /TASKS='modifypath'")
choco install awscli terraform kubernetes-cli minikube virtualbox vagrant 

# SEARCH
choco install everything
choco install wox -i
python .\scripts\install_wox_plugins.py

# ADOBE SUITE
python .\scripts\install_adobe.py -s photoshop:2018cc lightroom:2018cc premiere:2018cc aftereffects:2018cc

# OTHER
# choco install sandboxie.install
# choco install opencv 
# choco install nodejs.install -fy
# choco install golang 
# choco install steam
# choco install make
# choco install gnuwin


# SET NEW SCHEDULED TASK TO UPDATE PACKAGES EVERY WEEK
$GotTask = (&schtasks.exe /query /tn "choco-upgrade-all-every-week") 2> $null
if ($GotTask -ne $null) {
   Write-Host "Existing choco-upgrade-all-every-week scheduled task found. Keeping existing scheduled task." -foreground magenta
   exit 
   } else {
    Write-Host " "
    &schtasks.exe /Create /SC WEEKLY /RU SYSTEM /RL HIGHEST /TN "choco-upgrade-all-every-week" /TR "choco upgrade all -y" /F
    Write-Host "Now configured to run ""choco upgrade all -y"" every week." -foreground magenta
  }
 

 
#Set-MpPreference -DisableRealtimeMonitoring $false
