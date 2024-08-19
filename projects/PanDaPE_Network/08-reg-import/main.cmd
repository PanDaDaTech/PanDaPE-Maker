@echo off

echo 导入注册表项
for /r "%cd%\DEFAULT" %%i in (*.reg) do (echo DEFAULT %%~nxi&reg import "%cd%\DEFAULT\%%~nxi")
for /r "%cd%\SOFTWARE" %%i in (*.reg) do (echo SOFTWARE %%~nxi&reg import "%cd%\SOFTWARE\%%~nxi")
for /r "%cd%\SYSTEM" %%i in (*.reg) do (echo SYSTEM %%~nxi&reg import "%cd%\SYSTEM\%%~nxi")

echo 处理 msi 服务
reg add "HKLM\Tmp_SYSTEM\ControlSet001\Services\TrustedInstaller" /f /v "Start" /t REG_DWORD /d 3 1>nul 2>nul

echo 修改注册表, 开启来宾共享
reg add "HKLM\Tmp_SYSTEM\ControlSet001\Control\Lsa" /f /v "everyoneincludesanonymous" /t REG_DWORD /d 1 1>nul 2>nul
reg add "HKLM\Tmp_SYSTEM\ControlSet001\Services\LanmanServer\Parameters" /f /v "RestrictNullSessAccess" /t REG_DWORD /d 0 1>nul 2>nul

echo 通过修改注册表实现禁用 StateRepository 服务
reg add "HKLM\Tmp_SYSTEM\ControlSet001\Services\StateRepository" /f /v "Start" /t REG_DWORD /d 4 1>nul 2>nul

echo 关闭 Chrome,Edge 声音沙箱获取权限以保证浏览器播放声音正常
reg add "HKLM\Tmp_SOFTWARE\Policies\Google\Chrome" /f /v "AudioSandboxEnabled" /t REG_DWORD /d 0 1>nul 2>nul
reg add "HKLM\Tmp_SOFTWARE\Policies\Microsoft\Edge" /f /v "AudioSandboxEnabled" /t REG_DWORD /d 0 1>nul 2>nul

echo 开启路由转发功能
reg add "HKLM\Tmp_SYSTEM\ControlSet001\Services\Tcpip\Parameters" /f /v "IPEnableRouter" /d 1 1>nul 2>nul
