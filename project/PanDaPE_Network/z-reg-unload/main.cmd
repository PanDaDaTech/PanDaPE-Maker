@echo off

echo �滻��Ҫ��ע�����Ŀ
regfind.exe -p HKEY_LOCAL_MACHINE\Tmp_SOFTWARE -y C:\ -y -r X:\ > nul 2>&1
regfind.exe -p HKEY_LOCAL_MACHINE\Tmp_SOFTWARE -y D:\ -y -r X:\ > nul 2>&1
regfind.exe -p HKEY_LOCAL_MACHINE\Tmp_SOFTWARE -y Interactive User -r > nul 2>&1
regfind.exe -p HKEY_LOCAL_MACHINE\Tmp_SOFTWARE -y  X:\$windows.~bt\ -r  X:\ > nul 2>&1
regfind.exe -p HKEY_LOCAL_MACHINE\Tmp_SYSTEM -y  X:\$windows.~bt\ -r  X:\ > nul 2>&1

echo ж��ע���
reg unload HKLM\Src_DEFAULT
reg unload HKLM\Src_DRIVERS
reg unload HKLM\Src_SOFTWARE
reg unload HKLM\Src_SYSTEM

reg unload HKLM\Tmp_DEFAULT
reg unload HKLM\Tmp_DRIVERS
reg unload HKLM\Tmp_SOFTWARE
reg unload HKLM\Tmp_SYSTEM

echo ѹ��ע���
ru.exe -accepteula -h "%X%\Windows\System32\config\DRIVERS" hklm\drv > nul 2>&1
ru.exe -accepteula -h "%X%\Windows\System32\config\SOFTWARE" hklm\soft > nul 2>&1
ru.exe -accepteula -h "%X%\Windows\System32\config\SYSTEM" hklm\sys > nul 2>&1

echo ����ע�����־
del /f /q /a "%X%\Windows\System32\config\*.LOG*" 1>nul 2>nul
del /f /q /a "%X%\Windows\System32\config\*{*}*" 1>nul 2>nul