@echo off

for /r "%cd%" %%i in (*.7z) do (
echo ��ȡ %%~nxi
7z.exe  x "%cd%\%%~nxi" -y -o"%X%"
)
