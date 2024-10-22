@echo off
setlocal enabledelayedexpansion
set td=%date:~0,4%-%date:~5,2%-%date:~8,2%-%time:~0,2%-%time:~3,2%-%time:~6,2%

cd /d "%~dp0"
title %~n0-%td%-(%cd%)
set "PATH=%cd%\bin;%PATH%"
set "PATH=%cd%\cmd;%PATH%"

set /p cddir=输入虚拟光驱盘符：（不需要加冒号）
if /i "%cddir%"=="" (echo 没有输入虚拟光驱盘符&pause&exit)

if exist %cddir%:\sources\install.wim (set install=%cddir%:\sources\install.wim) else (set install=%cddir%:\sources\install.esd)

echo ————————————————————————————
for /f "tokens=2 delims=: " %%a in ('Dism.exe /English /Get-WimInfo /WimFile:"%install%" ^| findstr /i Index') do (
for /f "tokens=2 delims=:" %%b in ('Dism.exe /English /Get-WimInfo /WimFile:"%install%" /Index:%%a ^| findstr /i Name') do (
for /f "tokens=2 delims=:" %%c in ('Dism.exe /English /Get-WimInfo /WimFile:"%install%" /Index:%%a ^| findstr /i Architecture') do (
echo  %%a    %%b %%c
set index=%%a
)
)
)
echo ————————————————————————————
set /p installinfo=输入install分卷号：
if /i "%installinfo%"=="" (set installinfo=1&echo 没有输入分卷号，已自动选择卷1)
if %installinfo% gtr %index% (echo 没有选择对应的分卷号&cmd /k)

set index=0
echo;
echo 已有的项目：
echo ————————————————————————————
for /d %%i in ("%cd%\project\*") do (
set /a index=index+1
echo  !index!     %%~nxi
)
echo ————————————————————————————
set /p project=请输入项目序号：
if /i "%project%"=="" (echo 没有选择项目&cmd /k)
if %project% gtr %index% (echo 没有选择对应的项目&cmd /k)
set index=0
for /d %%x in ("%cd%\project\*") do (
set /a index=index+1
if !index!==%project% (
set project=%%~nx
)
)

echo;
echo 提取 wim
echo ————————————————————————————
echo  1     boot.wim 卷 2
echo  2     winre.wim
echo ————————————————————————————
set /p bore=请输入项目序号：
if /i "%bore%"=="" (set bore=2&echo 没有选择 wim,已自动选择 winre.wim)
if %bore% geq 3 (echo 没有选择对应的项目&cmd /k)

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
echo 提取 winre.wim
wimlib-imagex.exe extract "%install%" %installinfo% "\Windows\System32\Recovery\winre.wim" --dest-dir="%cd%\storage" --nullglob --no-acls
)

rem 设置 main.cmd 的变量
set "Z=%cd%"
set "S=%cd%\storage
set "X=%cd%\storage\X"
set "C=%cd%\storage\config"

if exist "%cd%\project\%project%\main.cmd" (
echo;
echo [94m执行 %cd%\project\%project%\main.cmd [37m
pushd "%cd%\project\%project%"
call "%cd%\project\%project%\main.cmd"
popd
)

for /r "%cd%\project\%project%" /d %%i in (*) do (
if exist "%%i\main.cmd" (
echo;
echo [94m执行 %%i\main.cmd [37m
pushd "%%i"
call "%%i\main.cmd"
popd
)
)

echo 清理文件
rd /s /q %cd%\storage

echo 制作完成
cmd /k
