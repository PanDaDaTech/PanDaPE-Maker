@echo off

echo ����ע�����
for /r "%cd%\DEFAULT" %%i in (*.reg) do (echo DEFAULT %%~nxi&reg import "%cd%\DEFAULT\%%~nxi")
for /r "%cd%\SOFTWARE" %%i in (*.reg) do (echo SOFTWARE %%~nxi&reg import "%cd%\SOFTWARE\%%~nxi")
for /r "%cd%\SYSTEM" %%i in (*.reg) do (echo SYSTEM %%~nxi&reg import "%cd%\SYSTEM\%%~nxi")
