@echo off
netsh wlan show network mode=bssid>file.txt
ping localhost -n 2 >nul

for /f "tokens=2 delims=:" %%a in ('type file.txt^|find "SSID 1 : "') do (
  set dateid=%%a & goto :continue
)
:continue
set dateid=%dateid:~1%
ping localhost -n 2 >nul
netsh wlan show profile name=%dateid% key=clear>file.txt

for /f "tokens=2 delims=:" %%a in ('type file.txt^|find "Contenuto chiave            :"') do (
  set dateid2=%%a & goto :continue1
)
:continue1
set dateid2=%dateid2:~1%
echo Your WiFi is %dateid% and the password is %dateid2%
echo More info about your WiFi connection in file.txt
PAUSE