@echo off

echo ɾ�� Winners ע���
reg delete HKEY_LOCAL_MACHINE\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Winners /f

echo ���Ʊ�Ҫ�� Winners ע���
for /f "delims=" %%i in (%cd%\Winners.txt) do (call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,%%i)

echo ���Ʊ�Ҫ��ע���
for /r "%cd%\DEFAULT" %%i in (*.txt) do (echo %%i&for /f "delims=" %%i in (%cd%\DEFAULT\%%~nxi) do (call RegCopy "%%i"))
for /r "%cd%\DRIVERS" %%i in (*.txt) do (echo %%i&for /f "delims=" %%i in (%cd%\DRIVERS\%%~nxi) do (call RegCopy "%%i"))
for /r "%cd%\SOFTWARE" %%i in (*.txt) do (echo %%i&for /f "delims=" %%i in (%cd%\SOFTWARE\%%~nxi) do (call RegCopy "%%i"))
for /r "%cd%\SYSTEM" %%i in (*.txt) do (echo %%i&for /f "delims=" %%i in (%cd%\SYSTEM\%%~nxi) do (call RegCopy "%%i"))

echo ���� RNDIS ע���
call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\{4d36e972-e325-11ce-bfc1-08002be10318}
call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\ms_rndisusb
call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\ms_rndisusb6
call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\USB\Class_EF&SubClass_04&Prot_01
call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\USB\MS_COMP_RNDIS&MS_SUBCOMP_5162001

call RegCopy /-s HKLM\Software\Microsoft\Windows NT\CurrentVersion

reg delete HKLM\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT /f