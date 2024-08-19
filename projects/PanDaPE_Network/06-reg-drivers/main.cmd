@echo off

echo 复制必要的 inf 注册表
for /r "%cd%\copy-inf" %%i in (*.txt) do (
echo %%i
for /f "delims=" %%i in (%cd%\copy-inf\%%~nxi) do (
call RegCopy "HKLM\DRIVERS\DriverDatabase\DriverInfFiles\%%i"
call RegCopy HKLM\DRIVERS\DriverDatabase\DriverPackages,%%i*
call RegCopy "HKLM\SYSTEM\DriverDatabase\DriverInfFiles\%%i"
call RegCopy HKLM\SYSTEM\DriverDatabase\DriverPackages,%%i*
)
)

echo 删除不需要的 inf 注册表
for /r "%cd%\del-inf" %%i in (*.txt) do (
echo %%i
for /f "delims=" %%i in (%cd%\del-inf\%%~nxi) do (
call RegDel "HKLM\DRIVERS\DriverDatabase\DriverInfFiles\%%i"
call RegDel HKLM\DRIVERS\DriverDatabase\DriverPackages,%%i*
call RegDel "HKLM\SYSTEM\DriverDatabase\DriverInfFiles\%%i"
call RegDel HKLM\SYSTEM\DriverDatabase\DriverPackages,%%i*
)
)
