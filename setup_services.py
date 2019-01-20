import json
import win32con
import win32service
from winreg import *

'''
This script disables some Windows services through registry
It also looks for and disables some of the shadow services created by MS (which end with a random suite of numbers: _xxxx)
The custom start policy for each service can be found in the utils\services.json file attached
'''


def list_curr_services():

	hscm = win32service.OpenSCManager(None, None, win32con.GENERIC_READ)

	typeFilter = win32service.SERVICE_WIN32
	stateFilter = win32service.SERVICE_STATE_ALL

	statuses = win32service.EnumServicesStatus(hscm, typeFilter, stateFilter)
	
	return [s[0] for s in statuses]
	
	
def find_matches(key, services):

	matches = [service for i, service in enumerate(services) if service.startswith(key)]
	
	if not matches:
		return None, None
	elif len(matches) == 1:
		return matches[0], None
	elif len(matches) == 2:
		return matches[0], matches[1]
		
		
def set_config(svc_name, svc_config):
	
	keyExists, delayedAutoStartValueExists = True, True
	reg = ConnectRegistry(None, HKEY_LOCAL_MACHINE)
	
	try:
		key = OpenKey(reg, 'SYSTEM\CurrentControlSet\Services\\' + svc_name, 0, KEY_WRITE)
	except WindowsError:
		keyExists = False

	try:
		if keyExists:
			try:
				delayedAutoStartValueExists = QueryValueEx(key, "DelayedAutostart")
			except Exception:
				delayedAutoStartValueExists = False
				
			if delayedAutoStartValueExists:
				SetValueEx(key, "DelayedAutostart", 0, REG_DWORD, svc_config['DelayedAutostart']) 
			
			if svc_config['Start'] != svc_config['defaultStart']:
				print("Setting new start value for service {}: {}".format(svc_config['name'], svc_config['Start']))
				SetValueEx(key, "Start", 0, REG_DWORD, svc_config['Start']) 
				
			CloseKey(key)
			
	except EnvironmentError:
		print("Encountered problems writing into the Registry...")
	
	CloseKey(reg)
	
	
if __name__ == '__main__':

	# TODO: add flag to reset all default values
	# parser = ArgumentParser()
	# parser.add_argument('-d', '--default', nargs='+', default=[])
	# args = parser.parse_args()
	
	# list currently available services
	services = list_curr_services()

	# open desired values list
	with open('resources/services.json') as f:  
		tweak_list = json.load(f)

	# start tweaking
	for svc_config in tweak_list:
		service, shadow = find_matches(svc_config['name'], services)
		
		if service is not None:
			set_config(service, svc_config)
			
			if shadow is not None:
				set_config(shadow, svc_config)
			