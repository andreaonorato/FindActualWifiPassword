@echo off
echo FindActualWifiPassword by andreaonorato
echo This tool works only in Italian Language OS
netsh wlan show network mode=bssid>moreinfo.txt
ping localhost -n 2 >nul

for /f "tokens=2 delims=:" %%a in ('type moreinfo.txt^|find "SSID 1 : "') do (
  set dateid=%%a & goto :continue
)
:continue
set dateid=%dateid:~1%
ping localhost -n 2 >nul
netsh wlan show profile name=%dateid% key=clear>moreinfo.txt

for /f "tokens=2 delims=:" %%a in ('type moreinfo.txt^|find "Contenuto chiave            :"') do (
  set dateid2=%%a & goto :continue1
)
:continue1
set dateid2=%dateid2:~1%
echo.
echo You are connected to %dateid%
echo You will find more info about your WiFi connection in moreinfo.txt
echo In moreinfo.txt, under "Security Settings","Key Content", you will find the password
echo.
PAUSE