@echo off

for /r "%cd%" %%i in (*.txt) do (
echo ��ȡ %%~nxi �г����ļ�
wimlib-imagex.exe extract "%install%" %installinfo% @"%cd%\%%~nxi" --dest-dir="%X%" --nullglob --no-acls
)
