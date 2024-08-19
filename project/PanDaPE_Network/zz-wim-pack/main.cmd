@echo off

for /f "tokens=1-3 delims=/ " %%a in ("%date%") do (  
set d=%%a-%%b-%%c
for /f "tokens=1-3 delims=:.," %%d in ("%time%") do (  
set t=%%d-%%e-%%f
)
)

echo ´ò°ü wim
wimlib-imagex.exe capture "%X%" "%Z%\%d%-%t%-%project%.wim" "PanDaPE_Win11" "Win11PE_Enterprise" --compress=lzx:100 --boot --check 
