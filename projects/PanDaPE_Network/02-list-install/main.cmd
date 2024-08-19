@echo off

for /r "%cd%" %%i in (*.txt) do (
echo 提取 %%~nxi 列出的文件
wimlib-imagex.exe extract "%install%" %installinfo% @"%cd%\%%~nxi" --dest-dir="%X%" --nullglob --no-acls
)
