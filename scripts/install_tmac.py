import os, wget
import zipfile
from pywinauto.application import Application

tmac_zip = wget.download('https://technitium.com/download/tmac/TMACv6.0.7_Setup.zip')

with zipfile.ZipFile(tmac_zip, 'r') as zip_ref:
    zip_ref.extractall('.')
    
tmac_exe = tmac_zip.split('/')[-1][:-3] + 'exe'
tmac_zip = tmac_zip.split('/')[-1][:-3] + 'zip'
    
app = Application().start(os.path.join(os.getcwd(), tmac_exe))
app.TechnitiumMACAddressChangerv6.Next.click()
app.TechnitiumMACAddressChangerv6.Iagreetoabovetermsofagreement.check_by_click()
app.TechnitiumMACAddressChangerv6.Next.click()
app.TechnitiumMACAddressChangerv6.Next.click()
app.TechnitiumMACAddressChangerv6.Next.click()
app.TechnitiumMACAddressChangerv6.wait("exists enabled visible ready", timeout=30)
app.TechnitiumMACAddressChangerv6.Finish.click()

os.remove(os.path.join(os.getcwd(), tmac_exe))
os.remove(os.path.join(os.getcwd(), tmac_zip))
