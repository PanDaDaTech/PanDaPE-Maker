@echo off
setlocal enabledelayedexpansion
set td=2024.07.13

cd /d "%~dp0"
title %~n0-%td%-(%cd%)
set "PATH=%cd%\bin;%PATH%"
set "PATH=%cd%\cmd;%PATH%"

set /p cddir=ÊäÈëĞéÄâ¹âÇıÅÌ·û£º£¨²»ĞèÒª¼ÓÃ°ºÅ£©
if /i "%cddir%"=="" (echo Ã»ÓĞÊäÈëĞéÄâ¹âÇıÅÌ·û&pause&exit)

if exist %cddir%:\sources\install.wim (set install=%cddir%:\sources\install.wim) else (set install=%cddir%:\sources\install.esd)

echo ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
for /f "tokens=2 delims=: " %%a in ('Dism.exe /English /Get-WimInfo /WimFile:"%install%" ^| findstr /i Index') do (
for /f "tokens=2 delims=:" %%b in ('Dism.exe /English /Get-WimInfo /WimFile:"%install%" /Index:%%a ^| findstr /i Name') do (
for /f "tokens=2 delims=:" %%c in ('Dism.exe /English /Get-WimInfo /WimFile:"%install%" /Index:%%a ^| findstr /i Architecture') do (
echo  %%a    %%b %%c
set index=%%a
)
)
)
echo ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
set /p installinfo=ÊäÈëinstall·Ö¾íºÅ£º
if /i "%installinfo%"=="" (set installinfo=1&echo Ã»ÓĞÊäÈë·Ö¾íºÅ£¬ÒÑ×Ô¶¯Ñ¡Ôñ¾í1)
if %installinfo% gtr %index% (echo Ã»ÓĞÑ¡Ôñ¶ÔÓ¦µÄ·Ö¾íºÅ&cmd /k)

set index=0
echo;
echo ÒÑÓĞµÄÏîÄ¿£º
echo ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
for /d %%i in ("%cd%\projects\*") do (
set /a index=index+1
echo  !index!     %%~nxi
)
echo ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
set /p project=ÇëÊäÈëÏîÄ¿ĞòºÅ£º
if /i "%project%"=="" (echo Ã»ÓĞÑ¡ÔñÏîÄ¿&cmd /k)
if %project% gtr %index% (echo Ã»ÓĞÑ¡Ôñ¶ÔÓ¦µÄÏîÄ¿&cmd /k)
set index=0
for /d %%x in ("%cd%\projects\*") do (
set /a index=index+1
if !index!==%project% (
set project=%%~nx
)
)

echo;
echo ÌáÈ¡ wim
echo ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
echo  1     boot.wim ¾í 2
echo  2     winre.wim
echo ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
set /p bore=ÇëÊäÈëÏîÄ¿ĞòºÅ£º
if /i "%bore%"=="" (set bore=2&echo Ã»ÓĞÑ¡Ôñ wim,ÒÑ×Ô¶¯Ñ¡Ôñ winre.wim)
if %bore% geq 3 (echo Ã»ÓĞÑ¡Ôñ¶ÔÓ¦µÄÏîÄ¿&cmd /k)

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
echo ÌáÈ¡ winre.wim
wimlib-imagex.exe extract "%install%" %installinfo% "\Windows\System32\Recovery\winre.wim" --dest-dir="%cd%\storage" --nullglob --no-acls
)

rem ÉèÖÃ main.cmd µÄ±äÁ¿
set "Z=%cd%"
set "S=%cd%\storage
set "X=%cd%\storage\X"
set "C=%cd%\storage\config"

if exist "%cd%\projects\%project%\main.cmd" (
echo;
echo [94mÖ´ĞĞ %cd%\projects\%project%\main.cmd [37m
pushd "%cd%\projects\%project%"
call "%cd%\projects\%project%\main.cmd"
popd
)

for /r "%cd%\projects\%project%" /d %%i in (*) do (
if exist "%%i\main.cmd" (
echo;
echo [94mÖ´ĞĞ %%i\main.cmd [37m
pushd "%%i"
call "%%i\main.cmd"
popd
)
)

echo ÇåÀíÎÄ¼ş
rd /s /q %cd%\storage

echo ÖÆ×÷Íê³É
cmd /k
