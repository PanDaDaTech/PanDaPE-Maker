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
