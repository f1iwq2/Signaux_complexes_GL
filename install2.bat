@echo off
echo ce script est a executer en mode  
echo administrateur (exécuter en tant qu'administrateur)

echo enregistrement du composant TMScomm32
regsvr32 mscomm32.ocx

rem détermine si OS 32 ou 64 bits
Set _os_bitness=64
IF %PROCESSOR_ARCHITECTURE% == x86 (
  IF NOT DEFINED PROCESSOR_ARCHITEW6432 Set _os_bitness=32
  )
Echo systeme %_os_bitness% bits

echo copie du composant mscomm32 dans windows
if %_os_bitness%==64 copy mscomm32.ocx c:\windows\sysWOW64
if %_os_bitness%==32 copy mscomm32.ocx c:\windows\system32

echo enregistrement de la licence du composant
regedit -s vbctrls.reg

pause
