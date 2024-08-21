@echo off

echo 替换必要的注册表项目
regfind.exe -p HKEY_LOCAL_MACHINE\Tmp_SOFTWARE -y C:\ -y -r X:\ > nul 2>&1
regfind.exe -p HKEY_LOCAL_MACHINE\Tmp_SOFTWARE -y D:\ -y -r X:\ > nul 2>&1
regfind.exe -p HKEY_LOCAL_MACHINE\Tmp_SOFTWARE -y Interactive User -r > nul 2>&1
regfind.exe -p HKEY_LOCAL_MACHINE\Tmp_SOFTWARE -y  X:\$windows.~bt\ -r  X:\ > nul 2>&1
regfind.exe -p HKEY_LOCAL_MACHINE\Tmp_SYSTEM -y  X:\$windows.~bt\ -r  X:\ > nul 2>&1

echo 卸载注册表
reg unload HKLM\Src_DEFAULT
reg unload HKLM\Src_DRIVERS
reg unload HKLM\Src_SOFTWARE
reg unload HKLM\Src_SYSTEM

reg unload HKLM\Tmp_DEFAULT
reg unload HKLM\Tmp_DRIVERS
reg unload HKLM\Tmp_SOFTWARE
reg unload HKLM\Tmp_SYSTEM