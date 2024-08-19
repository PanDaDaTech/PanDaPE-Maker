@echo off

echo 删除 Winners 注册表
reg delete HKEY_LOCAL_MACHINE\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Winners /f

echo 复制必要的 Winners 注册表
for /f "delims=" %%i in (%cd%\Winners.txt) do (call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,%%i)

echo 复制必要的注册表
for /r "%cd%\DEFAULT" %%i in (*.txt) do (echo %%i&for /f "delims=" %%i in (%cd%\DEFAULT\%%~nxi) do (call RegCopy "%%i"))
for /r "%cd%\DRIVERS" %%i in (*.txt) do (echo %%i&for /f "delims=" %%i in (%cd%\DRIVERS\%%~nxi) do (call RegCopy "%%i"))
for /r "%cd%\SOFTWARE" %%i in (*.txt) do (echo %%i&for /f "delims=" %%i in (%cd%\SOFTWARE\%%~nxi) do (call RegCopy "%%i"))
for /r "%cd%\SYSTEM" %%i in (*.txt) do (echo %%i&for /f "delims=" %%i in (%cd%\SYSTEM\%%~nxi) do (call RegCopy "%%i"))

echo 补充 RNDIS 注册表
call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\{4d36e972-e325-11ce-bfc1-08002be10318}
call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\ms_rndisusb
call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\ms_rndisusb6
call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\USB\Class_EF&SubClass_04&Prot_01
call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\USB\MS_COMP_RNDIS&MS_SUBCOMP_5162001

call RegCopy /-s HKLM\Software\Microsoft\Windows NT\CurrentVersion

reg delete HKLM\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT /f