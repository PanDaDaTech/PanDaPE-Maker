@echo off
setlocal enabledelayedexpansion
set td=2024.07.13

cd /d "%~dp0"
title %~n0-%td%-(%cd%)
set "PATH=%cd%\bin;%PATH%"
set "PATH=%cd%\cmd;%PATH%"

set /p cddir=������������̷���������Ҫ��ð�ţ�
if /i "%cddir%"=="" (echo û��������������̷�&pause&exit)

if exist %cddir%:\sources\install.wim (set install=%cddir%:\sources\install.wim) else (set install=%cddir%:\sources\install.esd)

echo ��������������������������������������������������������
for /f "tokens=2 delims=: " %%a in ('Dism.exe /English /Get-WimInfo /WimFile:"%install%" ^| findstr /i Index') do (
for /f "tokens=2 delims=:" %%b in ('Dism.exe /English /Get-WimInfo /WimFile:"%install%" /Index:%%a ^| findstr /i Name') do (
for /f "tokens=2 delims=:" %%c in ('Dism.exe /English /Get-WimInfo /WimFile:"%install%" /Index:%%a ^| findstr /i Architecture') do (
echo  %%a    %%b %%c
set index=%%a
)
)
)
echo ��������������������������������������������������������
set /p installinfo=����install�־�ţ�
if /i "%installinfo%"=="" (set installinfo=1&echo û������־�ţ����Զ�ѡ���1)
if %installinfo% gtr %index% (echo û��ѡ���Ӧ�ķ־��&cmd /k)

set index=0
echo;
echo ���е���Ŀ��
echo ��������������������������������������������������������
for /d %%i in ("%cd%\projects\*") do (
set /a index=index+1
echo  !index!     %%~nxi
)
echo ��������������������������������������������������������
set /p project=��������Ŀ��ţ�
if /i "%project%"=="" (echo û��ѡ����Ŀ&cmd /k)
if %project% gtr %index% (echo û��ѡ���Ӧ����Ŀ&cmd /k)
set index=0
for /d %%x in ("%cd%\projects\*") do (
set /a index=index+1
if !index!==%project% (
set project=%%~nx
)
)

echo;
echo ��ȡ wim
echo ��������������������������������������������������������
echo  1     boot.wim �� 2
echo  2     winre.wim
echo ��������������������������������������������������������
set /p bore=��������Ŀ��ţ�
if /i "%bore%"=="" (set bore=2&echo û��ѡ�� wim,���Զ�ѡ�� winre.wim)
if %bore% geq 3 (echo û��ѡ���Ӧ����Ŀ&cmd /k)

if exist %cd%\storage (rd /s /q %cd%\storage)
mkdir "%cd%\storage\config"
mkdir "%cd%\storage\X"

if %bore%==1 (
set "wim=%cddir%:\sources\boot.wim"
set "roll=2"
)
if %bore%==2 (
set "wim=%cd%\storage\winre.wim"
set "roll=1"
echo ��ȡ winre.wim
wimlib-imagex.exe extract "%install%" %installinfo% "\Windows\System32\Recovery\winre.wim" --dest-dir="%cd%\storage" --nullglob --no-acls
)

rem ���� main.cmd �ı���
set "Z=%cd%"
set "S=%cd%\storage
set "X=%cd%\storage\X"
set "C=%cd%\storage\config"

if exist "%cd%\projects\%project%\main.cmd" (
echo;
echo [94mִ�� %cd%\projects\%project%\main.cmd [37m
pushd "%cd%\projects\%project%"
call "%cd%\projects\%project%\main.cmd"
popd
)

for /r "%cd%\projects\%project%" /d %%i in (*) do (
if exist "%%i\main.cmd" (
echo;
echo [94mִ�� %%i\main.cmd [37m
pushd "%%i"
call "%%i\main.cmd"
popd
)
)

echo �����ļ�
rd /s /q %cd%\storage

echo �������
cmd /k
