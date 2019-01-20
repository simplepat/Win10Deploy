import os, wget
import zipfile

PLUGINS_PATH = os.path.join(os.environ['APPDATA'], 'Wox', 'Plugins')

plugins_url = [
    'http://api.wox.one/media/plugin/E2D2C23B084D41D1B6F60EC79D62CAH6/Wox.Plugin.IPAddress-275940ee-7ada-4a8a-b874-309e6034f39f.wox',
    'http://api.wox.one/media/plugin/5C0BFEC0DF7011E695980800200C9A66/YoutubeQuery-086bc2f7-a21f-4f76-9f29-349fb7534ce4.wox',
    'http://api.wox.one/media/plugin/ca8c0c3dea2e4f75833482489587d33d/Simple Web Search-999fc5f3-cc79-4ce4-81df-da1ae0497a65.wox',
    'http://api.wox.one/media/plugin/39F78C8D0A5B408595753263017A039A/Wox.Plugin.PirateBay-fd2ad92a-af92-4810-b555-49711397fee4.wox',
    'http://api.wox.one/media/plugin/13F6E017E889C82D4BAB954BB1E0D19C/Wox.Plugin.KickassTorrent-95bb9266-3844-4bef-a057-82ef4692e09d.wox',
    'http://api.wox.one/media/plugin/6c22cffe6b3546ec9087abe149c4a575/Wox.Plugin.Github-1.1.0-c3e6b661-2252-4061-83ae-5890ade1592a.wox',
    'http://api.wox.one/media/plugin/5B7E53D506844D2D8B7001AA19F5EF8F/Wox.Plugin.Todos-566b9986-dda3-437a-aa8b-fcf9b953aedc.wox',
    'http://api.wox.one/media/plugin/BB36CF20434311E6BDF40800200C9A66/Wox.Plugin.Giphy-7100cf9a-4be7-467f-951f-d15d843ecae7.wox',
    'http://api.wox.one/media/plugin/8d80430bbaeb4e49a002213c3bd88c66/Wox.Plugin.Timestamp-1.0-4d9c8352-c081-4aca-80d3-c10e167ae5b1.wox',
    'http://api.wox.one/media/plugin/D2D2C23B084D411DB66EE0C79D6C2A6C/Wox.Plugin.ProcessKiller-5991960e-418a-49ad-9fa1-e9b4dab2d23c.wox'  
]

for pl_url in plugins_url:
    woxfile = wget.download(pl_url, out=PLUGINS_PATH)

    with zipfile.ZipFile(woxfile, 'r') as zip_ref:
        zip_ref.extractall(os.path.join(PLUGINS_PATH, woxfile.split('/')[-1][:-4]))