@echo off

echo ����ע�����
for /r "%cd%\DEFAULT" %%i in (*.reg) do (echo DEFAULT %%~nxi&reg import "%cd%\DEFAULT\%%~nxi")
for /r "%cd%\SOFTWARE" %%i in (*.reg) do (echo SOFTWARE %%~nxi&reg import "%cd%\SOFTWARE\%%~nxi")
for /r "%cd%\SYSTEM" %%i in (*.reg) do (echo SYSTEM %%~nxi&reg import "%cd%\SYSTEM\%%~nxi")

echo ���� msi ����
reg add "HKLM\Tmp_SYSTEM\ControlSet001\Services\TrustedInstaller" /f /v "Start" /t REG_DWORD /d 3 1>nul 2>nul

echo �޸�ע���, ������������
reg add "HKLM\Tmp_SYSTEM\ControlSet001\Control\Lsa" /f /v "everyoneincludesanonymous" /t REG_DWORD /d 1 1>nul 2>nul
reg add "HKLM\Tmp_SYSTEM\ControlSet001\Services\LanmanServer\Parameters" /f /v "RestrictNullSessAccess" /t REG_DWORD /d 0 1>nul 2>nul

echo ͨ���޸�ע���ʵ�ֽ��� StateRepository ����
reg add "HKLM\Tmp_SYSTEM\ControlSet001\Services\StateRepository" /f /v "Start" /t REG_DWORD /d 4 1>nul 2>nul

echo �ر� Chrome,Edge ����ɳ���ȡȨ���Ա�֤�����������������
reg add "HKLM\Tmp_SOFTWARE\Policies\Google\Chrome" /f /v "AudioSandboxEnabled" /t REG_DWORD /d 0 1>nul 2>nul
reg add "HKLM\Tmp_SOFTWARE\Policies\Microsoft\Edge" /f /v "AudioSandboxEnabled" /t REG_DWORD /d 0 1>nul 2>nul

echo ����·��ת������
reg add "HKLM\Tmp_SYSTEM\ControlSet001\Services\Tcpip\Parameters" /f /v "IPEnableRouter" /d 1 1>nul 2>nul
