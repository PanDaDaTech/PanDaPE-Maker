@echo off

echo 破解声音功能
binmay.exe -u "%X%\Windows\System32\AudioSrvPolicyManager.dll" -s "83 FB 01 0F 84 92 00 00 00" -r "83 FB 01 E9 93 00 00 00 00"
binmay.exe -u "%X%\Windows\System32\AudioSrvPolicyManager.dll" -s "83 FF 01 74 FF" -S "FF FF FF FF 00" -r "83 FE 01 EB FF" -R "FF FF FF FF 00"
binmay.exe -u "%X%\Windows\System32\AudioSrvPolicyManager.dll" -s "83 FE 01 74 FF" -S "FF FF FF FF 00" -r "83 FE 01 EB FF" -R "FF FF FF FF 00"

echo 破解 USB 弹出功能文件
binmay.exe -u "%X%\Windows\System32\DeviceSetupManager.dll"  -s u:SystemSetupInProgress -r u:DisableDeviceSetupMgr

echo 破解 BitLocker 加解密
binmay.exe -u "%X%\Windows\System32\dsreg.dll" -s u:MiniNT -r u:MiniPE

echo 破解网络状态指示器
binmay.exe -u "%X%\Windows\System32\netprofmsvc.dll" -s u:SystemSetupInProgress -r u:DisableNetworkListMgr

echo 清理破解残留的原始文件
del "%X%\Windows\System32\AudioSrvPolicyManager.dll.org"
del "%X%\Windows\System32\DeviceSetupManager.dll.org"
del "%X%\Windows\System32\dsreg.dll.org"
del "%X%\Windows\System32\netprofmsvc.dll.org"
