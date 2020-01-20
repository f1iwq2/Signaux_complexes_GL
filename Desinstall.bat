@echo off
echo ce script est a executer en mode  
echo administrateur (exécuter en tant qu'administrateur)

echo enregistrement du composant TMScomm32
regsvr32 -u mscomm32.ocx

echo enregistrement de la licence du composant
regedit -u vbctrls.reg

pause
