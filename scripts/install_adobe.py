import os, subprocess
import wget
import json
import zipfile
from pywinauto.application import Application
from argparse import ArgumentParser

TMP_NET_ADAPTERS = '$env:TEMP\netadapters'

def powershell_exec(cmd):
	startupinfo = subprocess.STARTUPINFO()
	startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
	proc = subprocess.Popen(["powershell", cmd], stdout=subprocess.PIPE, startupinfo=startupinfo)

def get_enabled_net_adapters():
	cmd = "Get-NetAdapter | ? status -eq up | export-clixml -path {}".format(TMP_NET_ADAPTERS)
	powershell_exec(cmd)
	
def disable_internet():
	print('Disabling internet')
	cmd = "import-clixml -path {} | Disable-NetAdapter -Confirm:$false".format(TMP_NET_ADAPTERS)
	powershell_exec(cmd)
    
def restore_internet():
	print('Re-enabling internet')
	cmd = "import-clixml -path {} | Enable-NetAdapter -Confirm:$false".format(TMP_NET_ADAPTERS)
	powershell_exec(cmd)	
    
def unzip(myfile, path):
	print('Unzipping package...')
	zip_ref = zipfile.ZipFile(myfile, 'r')
	zip_ref.extractall(os.path.join(os.getcwd(), path))
	zip_ref.close()
    
                                  
								  
def install(package):

	file_dl_ok, installed = False, False
     
	print('Downloading {} {}...'.format(package['name'], package['version']))
	pk = wget.download(package['url'])
	
	if pk.endswith('.exe'):
		disable_internet()
		app = Application().start(pk)
		sleep(60)		
		restore_internet()
	
	elif pk.endswith('.zip'):
		try:
			unzip(pkzip, package['name']+package['version'])
			file_dl_ok = True
		except BadZipFile:
			print('Download probably failed... please try again')			
			
		if file_dl_ok:
			disable_internet()
			app = Application().start(os.path.join(os.getcwd(), package['name']+package['version'], "Set-up.exe"))
			sleep(60)
			restore_internet()

	# final check if install is OK
	installed = check_path_install(package['name'], package['checkpath']) 
	
	# if install is ok, remove install files
	if installed:
		os.remove(os.path.join(os.getcwd(), software_zipfile))
		os.rmdir(os.path.join(os.getcwd(), soft_param['software_name']))
		
		
def check_path_after_install(softname, path):
	print('Checking install path...')
	installed = os.path.exists(path)
	if installed:
		print(softname.capitalize() + 'installed successfully...')
	else:
		print(softname.capitalize() + 'install failed !')		
	return installed
	
                              
                                  
def get_matching_param(param, obj):	
	try:
		spl = obj.split(':')
		name, version = spl[0], spl[1]
		res = [pk for pk in param if pk['name'] == name and pk['version'] == version][0]
	except:
		res = None
	return res	
	
	
	
if __name__ == '__main__':
    
	parser = ArgumentParser()
	parser.add_argument('-s', '--software', nargs='+', default=[])
	args = parser.parse_args()
	
	with open('adobe_packages.json', 'r') as f: 
		param = json.load(f)
    		
	get_enabled_net_adapters()
        
	# install software    
	for obj in args.software:
		package = get_matching_param(param, obj)
		if package is not None:
			install(package)
		else:
			print("Software/version not found")
			
			
# IF MSI: app = pywinauto.Application().Start(r'msiexec.exe /i 7z920-x64.msi')
