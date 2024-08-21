@echo off

for /r "%cd%" %%i in (*.7z) do (
echo Ã·»° %%~nxi
7z.exe  x "%cd%\%%~nxi" -y -o"%X%"
)
