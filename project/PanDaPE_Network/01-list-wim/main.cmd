@echo off

for /r "%cd%" %%i in (*.txt) do (
echo ��ȡ %%~nxi �г����ļ�
wimlib-imagex.exe extract "%wim%" %roll% @"%cd%\%%~nxi" --dest-dir="%X%" --nullglob --no-acls
)
