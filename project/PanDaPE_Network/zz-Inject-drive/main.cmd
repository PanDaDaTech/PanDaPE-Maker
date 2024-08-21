@echo off

echo 提取 dism 注入驱动的必须文件
wimlib-imagex.exe extract "%wim%" %roll% @"%cd%\file.txt" --dest-dir="%X%" --nullglob --no-acls
wimlib-imagex.exe extract "%wim%" %roll% @"%cd%\folder.txt" --dest-dir="%X%" --nullglob --no-acls

echo 注入驱动
dism.exe /Image:"%X%" /Add-Driver /Driver:"%Z%\drive" /recurse /ForceUnsigned

echo 删除注入驱动的残留文件
for /f "delims=" %%i in (%cd%\file.txt) do (del /f /q /a "%X%\%%i")
for /f "delims=" %%i in (%cd%\folder.txt) do (for /d %%j in (%X%\%%i) do (rd /s /q "%%j"))

rd /s /q "%X%\Windows\servicing"
del /f /q /a "%X%\Windows\INF\setupapi.offline.log"
del /f /q /a "%X%\Windows\System32\config\*.LOG*"
del /f /q /a "%X%\Windows\System32\config\*{*}*"

echo 精简无用注册表项
reg load HKLM\Tmp_SYSTEM %X%\Windows\System32\config\SYSTEM
reg load HKLM\Tmp_DRIVERS %X%\Windows\System32\config\DRIVERS
reg import %cd%\OEM-DRV-lite.reg
reg import %cd%\OEM-SYS-lite.reg
reg unload HKLM\Tmp_SYSTEM
reg unload HKLM\Tmp_DRIVERS

echo 压缩注册表
ru.exe -accepteula -h "%X%\Windows\System32\config\DRIVERS" hklm\drv > nul 2>&1
ru.exe -accepteula -h "%X%\Windows\System32\config\SOFTWARE" hklm\soft > nul 2>&1
ru.exe -accepteula -h "%X%\Windows\System32\config\SYSTEM" hklm\sys > nul 2>&1

echo 清理注册表日志
del /f /q /a "%X%\Windows\System32\config\*.LOG*" 1>nul 2>nul
del /f /q /a "%X%\Windows\System32\config\*{*}*" 1>nul 2>nul
