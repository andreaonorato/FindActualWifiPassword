@echo off
echo FindActualWifiPassword by andreaonorato
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
echo.
echo You are connected to %dateid% and the password is %dateid2%
echo.
echo If the password is ~1, it means you are not connected to any server
echo More info about your WiFi connection in file.txt
echo.
PAUSE