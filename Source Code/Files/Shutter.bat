@echo off
setlocal enabledelayedexpansion

set __Space=
for /l %%a in (1,1,250) do (set "__Space= !__Space!")

Set _Var=

Set Line_1=30
Set Line_2=31

for /l %%A in (30,-1,0) do (
	Set "_var=/g 0 !Line_1! /d "!__Space!" /g 0 !Line_2! /d "!__Space!" /w 30 !_var!"
	set /a Line_1-=1
	set /a Line_2+=1
	)

batbox /c 0xff !_Var!
batbox /w 450 /c 0x00 !_Var!
exit /b