@echo off

echo ��ȡ install ע����ļ�
wimlib-imagex.exe extract "%install%" %installinfo% "\Windows\System32\config\DEFAULT" --dest-dir="%C%" --nullglob --no-acls
wimlib-imagex.exe extract "%install%" %installinfo% "\Windows\System32\config\DRIVERS" --dest-dir="%C%" --nullglob --no-acls
wimlib-imagex.exe extract "%install%" %installinfo% "\Windows\System32\config\SOFTWARE" --dest-dir="%C%" --nullglob --no-acls
wimlib-imagex.exe extract "%install%" %installinfo% "\Windows\System32\config\SYSTEM" --dest-dir="%C%" --nullglob --no-acls

echo ����ע���
reg load HKLM\Src_DEFAULT %C%\DEFAULT
reg load HKLM\Src_DRIVERS %C%\DRIVERS
reg load HKLM\Src_SOFTWARE %C%\SOFTWARE
reg load HKLM\Src_SYSTEM %C%\SYSTEM

reg load HKLM\Tmp_DEFAULT %X%\Windows\System32\config\DEFAULT
reg load HKLM\Tmp_DRIVERS %X%\Windows\System32\config\DRIVERS
reg load HKLM\Tmp_SOFTWARE %X%\Windows\System32\config\SOFTWARE
reg load HKLM\Tmp_SYSTEM %X%\Windows\System32\config\SYSTEM

echo ��ȡע���Ȩ��
setacl.exe -on "HKLM\Tmp_DRIVERS" -ot reg -actn setowner -ownr "n:Everyone" -rec yes -silent
setacl.exe -on "HKLM\Tmp_DRIVERS" -ot reg -actn ace -ace "n:Everyone;p:full;m:grant;i:so,sc" -op DACL:p_c -rec yes -silent
echo drivers ��ȡ���
setacl.exe -on "HKLM\Tmp_SOFTWARE" -ot reg -actn setowner -ownr "n:Everyone" -rec yes -silent
setacl.exe -on "HKLM\Tmp_SOFTWARE" -ot reg -actn ace -ace "n:Everyone;p:full;m:grant;i:so,sc" -op DACL:p_c -rec yes -silent
echo software ��ȡ���
setacl.exe -on "HKLM\Tmp_SYSTEM" -ot reg -actn setowner -ownr "n:Everyone" -rec yes -silent
setacl.exe -on "HKLM\Tmp_SYSTEM" -ot reg -actn ace -ace "n:Everyone;p:full;m:grant;i:so,sc" -op DACL:p_c -rec yes -silent
echo system ��ȡ���
