@echo off

echo 提取 install 注册表文件
wimlib-imagex.exe extract "%install%" %installinfo% "\Windows\System32\config\DEFAULT" --dest-dir="%C%" --nullglob --no-acls
wimlib-imagex.exe extract "%install%" %installinfo% "\Windows\System32\config\DRIVERS" --dest-dir="%C%" --nullglob --no-acls
wimlib-imagex.exe extract "%install%" %installinfo% "\Windows\System32\config\SOFTWARE" --dest-dir="%C%" --nullglob --no-acls
wimlib-imagex.exe extract "%install%" %installinfo% "\Windows\System32\config\SYSTEM" --dest-dir="%C%" --nullglob --no-acls

echo 挂载注册表
reg load HKLM\Src_DEFAULT %C%\DEFAULT
reg load HKLM\Src_DRIVERS %C%\DRIVERS
reg load HKLM\Src_SOFTWARE %C%\SOFTWARE
reg load HKLM\Src_SYSTEM %C%\SYSTEM

reg load HKLM\Tmp_DEFAULT %X%\Windows\System32\config\DEFAULT
reg load HKLM\Tmp_DRIVERS %X%\Windows\System32\config\DRIVERS
reg load HKLM\Tmp_SOFTWARE %X%\Windows\System32\config\SOFTWARE
reg load HKLM\Tmp_SYSTEM %X%\Windows\System32\config\SYSTEM

echo 获取注册表权限
setacl.exe -on "HKLM\Tmp_DRIVERS" -ot reg -actn setowner -ownr "n:Everyone" -rec yes -silent
setacl.exe -on "HKLM\Tmp_DRIVERS" -ot reg -actn ace -ace "n:Everyone;p:full;m:grant;i:so,sc" -op DACL:p_c -rec yes -silent
echo drivers 获取完成
setacl.exe -on "HKLM\Tmp_SOFTWARE" -ot reg -actn setowner -ownr "n:Everyone" -rec yes -silent
setacl.exe -on "HKLM\Tmp_SOFTWARE" -ot reg -actn ace -ace "n:Everyone;p:full;m:grant;i:so,sc" -op DACL:p_c -rec yes -silent
echo software 获取完成
setacl.exe -on "HKLM\Tmp_SYSTEM" -ot reg -actn setowner -ownr "n:Everyone" -rec yes -silent
setacl.exe -on "HKLM\Tmp_SYSTEM" -ot reg -actn ace -ace "n:Everyone;p:full;m:grant;i:so,sc" -op DACL:p_c -rec yes -silent
echo system 获取完成
