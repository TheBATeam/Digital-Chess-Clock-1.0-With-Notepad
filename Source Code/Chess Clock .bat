@echo off
cls
Setlocal enabledelayedexpansion
Cd files
If Not exist _Temp Md _Temp

:Mess
Set Title=Chess Clock ver.1.0 by kvc
Title %Title% - Loading...
Fn.dll font 0
fn.dll cursor 0
Mode 250,60

:Start
REM Startup Screen...
Call Animation.bat
Title Chess Clock ver.1.0 by kvc

:Top
REM Setting Up extra variables...
Set _Space=
For /l %%A in (1,1,40) do set "_Space= !_Space!"
Set Sound=On

REM Setting up console screen...
Set Console_Rows=20
Set Console_Columns=100
Mode %Console_Columns%,%console_Rows%
fn.dll font 9

Set Box_Width=%console_Columns%
Set /a Box_Height=%console_Rows% - 1
Set /a Box_Sepration=%Box_Width% / 2 - 1

REM Setting Up Active player Icon
Set "Active_Box=/g 0 0 /a 64 /g 1 0 /a 64 /g 0 1 /a 64 /g 1 1 /a 64 /g 2 0 /a 64 /g 2 1 /a 64 "

REM Game Type...
Set P_1_Increment=0
Set P_2_Increment=0
Set Increment=0

REM Setting Up Default variables...
set Player_1_Time_Min=5
set Player_1_Time_Sec=0
Set /a Player_1_X_Coord=%Box_Sepration% / 2 - 2
Set /a Player_1_Y_Coord=%Box_Height% / 2
Set "P_1_Coord=%Player_1_X_Coord% %Player_1_Y_Coord%"
Set /a Player_1_Win_Y_Coord=%Box_Height% / 2 + 2
Set "P_1_Win_Coord=%Player_1_X_Coord% %Player_1_Win_Y_Coord%"
Set /a P_1_Active_Box_X=%Box_Sepration% - 4
Set P_1_Active_Box_Y=2
Set "P_1_Active_Box=%P_1_Active_Box_X% %P_1_Active_Box_Y%"

set Player_2_Time_Min=5
set Player_2_Time_Sec=0
Set /a Player_2_X_Coord=%Box_Sepration% + (%Box_Sepration% / 2) - 2
Set /a Player_2_Y_Coord=%Box_Height% / 2
Set "P_2_Coord=%Player_2_X_Coord% %Player_2_Y_Coord%"
Set /a Player_2_Win_Y_Coord=%Box_Height% / 2 + 2
Set "P_2_Win_Coord=%Player_2_X_Coord% %Player_2_Win_Y_Coord%"
Set /a P_2_Active_Box_X=%Box_Width% - 5
Set P_2_Active_Box_Y=2
Set "P_2_Active_Box=%P_2_Active_Box_X% %P_2_Active_Box_Y%"


:Menu
cls
FOR /l %%N in (1,1,2) do (For %%A in (Player_%%N_Time_Min Player_%%N_Time_Sec P_%%N_Increment) do (IF Exist "_Temp\%%A.DB" Set /p %%A=<"_Temp\%%A.DB"))
Call :Box 0 0 12 %Box_Width% - - 77
call typo Pixcel.FO 15 2 88 Chess Clock 
call typo Pixcel.FO 15 1 ff Chess Clock 

REM First Display of Data... on console...
If %Player_1_Time_Min% lss 10 (set "Player_1_Time_Min_Temp=0%Player_1_Time_Min%") ELSE (set "Player_1_Time_Min_Temp=%Player_1_Time_Min%")
If %Player_1_Time_Sec% lss 10 (set "Player_1_Time_Sec_Temp=0%Player_1_Time_Sec%") ELSE (set "Player_1_Time_Sec_Temp=%Player_1_Time_Sec%")

If %Player_2_Time_Min% lss 10 (set "Player_2_Time_Min_Temp=0%Player_2_Time_Min%") ELSE (set "Player_2_Time_Min_Temp=%Player_2_Time_Min%")
If %Player_2_Time_Sec% lss 10 (set "Player_2_Time_Sec_Temp=0%Player_2_Time_Sec%") ELSE (set "Player_2_Time_Sec_Temp=%Player_2_Time_Sec%")

Set /a Menu_Title=%Box_Sepration% - 5
Fn.dll Sprite 11 %Menu_Title% 70 "Main Menu:-"
fn.dll locate 13 0 
cmdmenusel 0FF0 "  Start Clock... " " Quick Games {Fischer | Blitz | Standard | Rapid | Tournament}" " Player 1 Time: {%Player_1_Time_Min_Temp%:%Player_1_Time_Sec_Temp% | %P_1_Increment%}               [Click Here to Edit]" " Player 2 Time: {%Player_2_Time_Min_Temp%:%Player_2_Time_Sec_Temp% | %P_2_Increment%}               [Click Here to Edit]" " Timer Sound: {%Sound%}                        [Click to Flip-Settings]" " Help                                     [How to Use ??]"

If /i "%errorlevel%" == "1" (goto :Start_clock)
If /i "%errorlevel%" == "2" (goto :Quick_Game)
If /i "%errorlevel%" == "3" (goto :Player_1_Time)
If /i "%errorlevel%" == "4" (goto :Player_2_Time)
If /i "%errorlevel%" == "5" (goto :Sound)
If /i "%errorlevel%" == "6" (goto :Help)
goto :menu

:Player_1_Time
Call :Box 30 8 6 40 - - 88
Batbox /g 30 8 /c 0x1f /d "%_Space:~0,1%Time Settings For Player 1:%_Space:~28%" /g 31 10 /c 0x87 /d "Enter the Asked value and Press Enter:" /g 31 11 /d "Minutes:" /g 42 11 /d "Seconds:" /g 53 11 /d "Increment:" /c 0x00 /g 31 12 /d "%_Space:~0,8%" /g 42 12 /d "%_Space:~0,8%" /g 53 12 /d "%_Space:~0,10%" /c 0x07 
fn.dll cursor 100
fn.dll locate 12 31
fn.dll color 08

REM Resetting Variables...
Set Player_1_Time_Min=0
Set Player_1_Time_Sec=0
Set P_1_Increment=0

Set /p "Player_1_Time_Min="
Set /a Player_1_Time_Min=%Player_1_Time_Min%
fn.dll Sprite 12 31 0f "%Player_1_Time_Min%"

fn.dll locate 12 42
Set /p "Player_1_Time_Sec="
Set /a Player_1_Time_Sec=%Player_1_Time_Sec%
fn.dll Sprite 12 42 0f "%Player_1_Time_Sec%"

fn.dll locate 12 53
Set /p "P_1_Increment="
Set /a P_1_Increment=%P_1_Increment%
fn.dll Sprite 12 53 0f "%P_1_Increment%"

fn.dll cursor 0

REM Making Both Player times same for the sake of easiness...
Set Player_2_Time_Min=%Player_1_Time_Min%
Set Player_2_Time_Sec=%Player_1_Time_Sec%
Set P_2_Increment=%P_1_Increment%

For %%A in (Player_1_Time_Min Player_1_Time_Sec P_1_Increment Player_2_Time_Min Player_2_Time_Sec P_2_Increment) do (echo.!%%A!>"_Temp\%%A.DB")
goto :Menu

:Player_2_Time
Call :Box 30 8 6 40 - - 88
Batbox /g 30 8 /c 0x1f /d "%_Space:~0,1%Time Settings For Player 2:%_Space:~28%" /g 31 10 /c 0x87 /d "Enter the Asked value and Press Enter:" /g 31 11 /d "Minutes:" /g 42 11 /d "Seconds:" /g 53 11 /d "Increment:" /c 0x00 /g 31 12 /d "%_Space:~0,8%" /g 42 12 /d "%_Space:~0,8%" /g 53 12 /d "%_Space:~0,10%"  /c 0x07
fn.dll cursor 100
fn.dll locate 12 31
fn.dll color 08

REM Resetting Variables...
Set Player_2_Time_Min=0
Set Player_2_Time_Sec=0
Set P_2_Increment=0

Set /p "Player_2_Time_Min="
Set /a Player_2_Time_Min=%Player_2_Time_Min%
fn.dll Sprite 12 31 0f "%Player_2_Time_Min%"

fn.dll locate 12 42
Set /p "Player_2_Time_Sec="
Set /a Player_2_Time_Sec=%Player_2_Time_Sec%
fn.dll Sprite 12 42 0f "%Player_2_Time_Sec%"

fn.dll locate 12 53
Set /p "P_2_Increment="
Set /a P_2_Increment=%P_2_Increment%
fn.dll Sprite 12 53 0f "%P_2_Increment%"

fn.dll cursor 0

For %%A in (Player_2_Time_Min Player_2_Time_Sec P_2_Increment) do (echo.!%%A!>"_Temp\%%A.DB")
goto :Menu

:Quick_Game
REM Setting Dialouge box...
Call :Box 23 4 12 53 - - 88
Batbox /g 23 4 /c 0x1f /d " Select Game Time %_Space:~0,35%" 

REM Initializing button Texts...
Set "_Button_1_Text=1 | 0"
Set "_Button_2_Text=2 | 1"
Set "_Button_3_Text=3 | 0"
Set "_Button_4_Text=5 | 0"
Set "_Button_5_Text=5 | 5"
Set "_Button_6_Text=10 | 0"
Set "_Button_7_Text=15 | 5"
Set "_Button_8_Text=30 | 0"
Set "_Button_9_Text=30 | 15"
Set "_Button_10_Text=45 | 0"


Set _Text=
Set _X=25
Set _Y=6

For /l %%A in (1,1,5) do (
	Set /a _Temp_X=!_X! + 1
	Set /a _Temp_Y=!_Y! + 1
	
	Set _Button_%%A_X=!_X!
	Set _Button_%%A_Y=!_Y!
	
	Call :Box !_Temp_X! !_Temp_Y! 3 8 - - 00
	Call :Box !_X! !_Y! 3 8 - - 77
	Set "_Text=!_Text!/g !_Temp_X! !_Temp_Y! /d "!_Button_%%A_Text!" "
	Set /a _X+=10
	)

Set _X=25
Set _Y=11

For /l %%A in (6,1,10) do (
	Set /a _Temp_X=!_X! + 1
	Set /a _Temp_Y=!_Y! + 1
	
	Set _Button_%%A_X=!_X!
	Set _Button_%%A_Y=!_Y!
		
	Call :Box !_Temp_X! !_Temp_Y! 3 8 - - 00
	Call :Box !_X! !_Y! 3 8 - - 77
	Set "_Text=!_Text!/g !_Temp_X! !_Temp_Y! /d "!_Button_%%A_Text!" "
	Set /a _X+=10
	)
Batbox /c 0x71 !_Text!
Set _Button=0
:Quick_Game_Input
For /f "Tokens=1,2,3 delims=:" %%A in ('Batbox /m') do (Set _X=%%A && Set _Y=%%B)
For /l %%A in (1,1,10) do (
	Set /a _Button_%%A_X_End=!_Button_%%A_X!+8
	Set /a _Button_%%A_Y_End=!_Button_%%A_Y!+3
	
	If !_X! GEQ !_Button_%%A_X! If !_X! LEQ !_Button_%%A_X_End! If !_Y! GEQ !_Button_%%A_Y! If !_Y! LEQ !_Button_%%A_Y_End! (Set _Button=%%A)
)

If /i "!_Button!" == "1" (
	Set Player_1_Time_Min=1
	Set Player_1_Time_Sec=0
	Set P_1_Increment=0
	Set Player_2_Time_Min=1
	Set Player_2_Time_Sec=0
	Set P_2_Increment=0
	goto :Start_clock
)

If /i "!_Button!" == "2" (
	Set Player_1_Time_Min=2
	Set Player_1_Time_Sec=0
	Set P_1_Increment=1
	Set Player_2_Time_Min=2
	Set Player_2_Time_Sec=0
	Set P_2_Increment=1
	goto :Start_clock
)

If /i "!_Button!" == "3" (
	Set Player_1_Time_Min=3
	Set Player_1_Time_Sec=0
	Set P_1_Increment=0
	Set Player_2_Time_Min=3
	Set Player_2_Time_Sec=0
	Set P_2_Increment=0
	goto :Start_clock
)

If /i "!_Button!" == "4" (
	Set Player_1_Time_Min=5
	Set Player_1_Time_Sec=0
	Set P_1_Increment=0
	Set Player_2_Time_Min=5
	Set Player_2_Time_Sec=0
	Set P_2_Increment=0
	goto :Start_clock
)

If /i "!_Button!" == "5" (
	Set Player_1_Time_Min=5
	Set Player_1_Time_Sec=0
	Set P_1_Increment=5
	Set Player_2_Time_Min=5
	Set Player_2_Time_Sec=0
	Set P_2_Increment=5
	goto :Start_clock
)

If /i "!_Button!" == "6" (
	Set Player_1_Time_Min=10
	Set Player_1_Time_Sec=0
	Set P_1_Increment=0
	Set Player_2_Time_Min=10
	Set Player_2_Time_Sec=0
	Set P_2_Increment=0
	goto :Start_clock
)

If /i "!_Button!" == "7" (
	Set Player_1_Time_Min=15
	Set Player_1_Time_Sec=0
	Set P_1_Increment=5
	Set Player_2_Time_Min=15
	Set Player_2_Time_Sec=0
	Set P_2_Increment=5
	goto :Start_clock
)

If /i "!_Button!" == "8" (
	Set Player_1_Time_Min=30
	Set Player_1_Time_Sec=0
	Set P_1_Increment=0
	Set Player_2_Time_Min=30
	Set Player_2_Time_Sec=0
	Set P_2_Increment=0
	goto :Start_clock
)

If /i "!_Button!" == "9" (
	Set Player_1_Time_Min=30
	Set Player_1_Time_Sec=0
	Set P_1_Increment=15
	Set Player_2_Time_Min=30
	Set Player_2_Time_Sec=0
	Set P_2_Increment=15
	goto :Start_clock
)

If /i "!_Button!" == "10" (
	Set Player_1_Time_Min=45
	Set Player_1_Time_Sec=0
	Set P_1_Increment=0
	Set Player_2_Time_Min=45
	Set Player_2_Time_Sec=0
	Set P_2_Increment=0
	goto :Start_clock
)

Goto :Quick_Game_Input

:Sound
If /i "%Sound%" == "On" (Set Sound=Off) ELSE (Set Sound=On)
Start /b fn.dll play "Navigation.wav"
goto :menu

:Start_clock

Call :Box 0 0 %Box_Height% %Box_Width% %Box_Sepration% - 0a
If %Player_1_Time_Min% lss 10 (set "Player_1_Time_Min_Temp=0%Player_1_Time_Min%") ELSE (set "Player_1_Time_Min_Temp=%Player_1_Time_Min%")
If %Player_1_Time_Sec% lss 10 (set "Player_1_Time_Sec_Temp=0%Player_1_Time_Sec%") ELSE (set "Player_1_Time_Sec_Temp=%Player_1_Time_Sec%")
If %Player_2_Time_Min% lss 10 (set "Player_2_Time_Min_Temp=0%Player_2_Time_Min%") ELSE (set "Player_2_Time_Min_Temp=%Player_2_Time_Min%")
If %Player_2_Time_Sec% lss 10 (set "Player_2_Time_Sec_Temp=0%Player_2_Time_Sec%") ELSE (set "Player_2_Time_Sec_Temp=%Player_2_Time_Sec%")

Batbox /g %P_1_Coord% /c 0x0c /d "%Player_1_Time_Min_Temp%:%Player_1_Time_Sec_Temp%"
Batbox /g %P_2_Coord% /c 0x0c /d "%Player_2_Time_Min_Temp%:%Player_2_Time_Sec_Temp%"
fn.dll sprite 19 0 70 " Main-Menu [Q] | Pause [P] | Stop [S] | Reset-Clock [R] | Switch Player-Time [N] | Sound [O] %_Space:~0,8%"

Title %title% - Press Any Key to start...

Call :Box 30 8 6 40 - - 88
Batbox /g 30 8 /c 0x1f /d "%_Space:~0,1%Chess Clock v.1.0%_Space:~18%" /g 31 10 /c 0x87 /d "Press Any Key to Start..."

Pause >nul
Title %title%

Call :Box 0 0 %Box_Height% %Box_Width% %Box_Sepration% - 0a
Batbox /g %P_1_Coord% /c 0x0c /d "%Player_1_Time_Min_Temp%:%Player_1_Time_Sec_Temp%"
Batbox /g %P_2_Coord% /c 0x0c /d "%Player_2_Time_Min_Temp%:%Player_2_Time_Sec_Temp%"
fn.dll sprite 19 0 70 " Main-Menu [Q] | Pause [P] | Stop [S] | Reset-Clock [R] | Switch Player-Time [N] | Sound [O] %_Space:~0,8%"

:Player_1_Loop

Set /a Player_1_Time_Sec-=1

:Player_1_Time_Sub_loop
If %Player_1_Time_Sec% gtr 59 (Set /a Player_1_Time_Min+=1 && Set /a Player_1_Time_Sec-=60 && goto :Player_1_Time_Sub_loop)

If !Player_1_Time_Sec! lss 0 (
	If /i "!Player_1_Time_Min!" == "0" (
		Batbox /g %P_2_Win_Coord% /c 0x0f /d "Winner..."
		IF /i "%Sound%" == "On" (Start /b fn.dll play "Winner.wav")
		Pause >nul
		Goto :top
		)
	Set /a Player_1_Time_Min-=1
	Set Player_1_Time_Sec=59
	)

If %Player_1_Time_Min% lss 10 (set "Player_1_Time_Min_Temp=0%Player_1_Time_Min%") ELSE (set "Player_1_Time_Min_Temp=%Player_1_Time_Min%")
If %Player_1_Time_Sec% lss 10 (set "Player_1_Time_Sec_Temp=0%Player_1_Time_Sec%") ELSE (set "Player_1_Time_Sec_Temp=%Player_1_Time_Sec%")
IF /i "%Sound%" == "On" (If /i "%Player_1_Time_Min%" == "0" IF %Player_1_Time_Sec% lss 20 (Start /b fn.dll play "Timer.wav"))

Batbox /o %P_2_Active_Box% /c 0x00 %Active_Box% /o %P_1_Active_Box% /c 0xaa %Active_Box% /o 0 0 /g %P_1_Coord% /c 0x0c /d "%Player_1_Time_Min_Temp%:%Player_1_Time_Sec_Temp%"

choice /c nqpsrod /n /t 1 /d d >nul
if /i "%errorlevel%" == "1" (
	IF /i "%Sound%" == "On" (Start /b fn.dll play "Navigation.wav")
	Set /a Player_1_Time_Sec+=%P_1_Increment%
	goto :Player_2_Loop
	)
if /i "%errorlevel%" == "2" (goto :Menu)
if /i "%errorlevel%" == "3" (
	Title %title% - Press Any Key to start...

	Call :Box 30 8 6 40 - - 88
	Batbox /g 30 8 /c 0x1f /d "%_Space:~0,1%Chess Clock v.1.0%_Space:~18%" /g 31 10 /c 0x87 /d "  Press Any Key to Start..."

	Pause >nul
	Title %title%
	Call :Box 0 0 %Box_Height% %Box_Width% %Box_Sepration% - 0a
	Batbox /g %P_1_Coord% /c 0x0c /d "%Player_1_Time_Min_Temp%:%Player_1_Time_Sec_Temp%"
	Batbox /g %P_2_Coord% /c 0x0c /d "%Player_2_Time_Min_Temp%:%Player_2_Time_Sec_Temp%"
	)
if /i "%errorlevel%" == "4" (Pause >nul && goto :Menu)
if /i "%errorlevel%" == "5" (
	FOR /l %%N in (1,1,2) do (
		For %%A in (Player_%%N_Time_Min Player_%%N_Time_Sec P_%%N_Increment) do (Set /p %%A=<"_Temp\%%A.DB")
		)
	goto :Start_clock
	)
if /i "%errorlevel%" == "6" (If /i "%Sound%" == "On" (Set Sound=Off) ELSE (Set Sound=On))
goto :Player_1_Loop



:Player_2_Loop

Set /a Player_2_Time_Sec-=1

:Player_2_Time_Sub_loop
If %Player_2_Time_Sec% gtr 59 (Set /a Player_2_Time_Min+=1 && Set /a Player_2_Time_Sec-=60 && goto :Player_2_Time_Sub_loop)

If !Player_2_Time_Sec! lss 0 (
	If /i "!Player_2_Time_Min!" == "0" (
		Batbox /g %P_1_Win_Coord% /c 0x0f /d "Winner..."
		IF /i "%Sound%" == "On" (Start /b fn.dll play "Winner.wav")
		Pause >nul
		Goto :top
		)
	Set /a Player_2_Time_Min-=1
	Set Player_2_Time_Sec=59
	)

If %Player_2_Time_Min% lss 10 (set "Player_2_Time_Min_Temp=0%Player_2_Time_Min%") ELSE (set "Player_2_Time_Min_Temp=%Player_2_Time_Min%")
If %Player_2_Time_Sec% lss 10 (set "Player_2_Time_Sec_Temp=0%Player_2_Time_Sec%") ELSE (set "Player_2_Time_Sec_Temp=%Player_2_Time_Sec%")
IF /i "%Sound%" == "On" (If /i "%Player_2_Time_Min%" == "0" IF %Player_2_Time_Sec% lss 20 (Start /b fn.dll play "Timer.wav"))

Batbox /o %P_1_Active_Box% /c 0x00 %Active_Box% /o %P_2_Active_Box% /c 0xaa %Active_Box% /o 0 0 /g %P_2_Coord% /c 0x0c /d "%Player_2_Time_Min_Temp%:%Player_2_Time_Sec_Temp%"

choice /c nqpsrod /n /t 1 /d d >nul
if /i "%errorlevel%" == "1" (
	IF /i "%Sound%" == "On" (Start /b fn.dll play "Navigation.wav")
	Set /a Player_2_Time_Sec+=%P_2_Increment%
	goto :Player_1_Loop
	)
if /i "%errorlevel%" == "2" (goto :Menu)
if /i "%errorlevel%" == "3" (
	Title %title% - Press Any Key to start...

	Call :Box 30 8 6 40 - - 88
	Batbox /g 30 8 /c 0x1f /d "%_Space:~0,1%Chess Clock v.1.0%_Space:~18%" /g 31 10 /c 0x87 /d "  Press Any Key to Start..."

	Pause >nul
	Title %title%
	Call :Box 0 0 %Box_Height% %Box_Width% %Box_Sepration% - 0a
	Batbox /g %P_1_Coord% /c 0x0c /d "%Player_1_Time_Min_Temp%:%Player_1_Time_Sec_Temp%"
	Batbox /g %P_2_Coord% /c 0x0c /d "%Player_2_Time_Min_Temp%:%Player_2_Time_Sec_Temp%"
	)
if /i "%errorlevel%" == "4" (Pause >nul && goto :Menu)
if /i "%errorlevel%" == "5" (
	FOR /l %%N in (1,1,2) do (
		For %%A in (Player_%%N_Time_Min Player_%%N_Time_Sec P_%%N_Increment) do (Set /p %%A=<"_Temp\%%A.DB")
		)
	goto :Start_clock
	)
if /i "%errorlevel%" == "6" (If /i "%Sound%" == "On" (Set Sound=Off) ELSE (Set Sound=On))
goto :Player_2_Loop


REM -------------------------------------------------
REM Extra functions are below this line....
REM -------------------------------------------------

:Help
Fn.dll color 77
cls
Fn.dll color 70
Echo.
Echo.Chess Clock is an app. used in various Chess Games / Tournaments to limit time usage in the Game.
Echo.
Echo.The Main menu can be used in both possible ways- Via the KEYBOARD or the MOUSE,Thanks to 'The
ECHO.CMDMenuSel.exe' Tool... The 3D-Text On the Console is Written Using 'The Typography Function by Kvc'
Echo.You can Check 'Source Code' for more info,Read the Attached 'License' File before start Using This
Echo.Awesome Application...
ECHo.
Echo.The App. is very easy to use as Name of Each option defines itself ... You may use the 'Quick-game'
Echo.option for specified standard Time-Intervls,For custom time-You Can simply Click on 'Player-1/2
Echo.Time' and Type Custom time limit + Enter...Now You can start the Clock by clicking/Selecting 'Start
Echo.Clock'option...
Echo.
Echo.
Echo.For More Batch Apps, Visit: Https://Batchprogrammers.blogspot.com
Echo.This Program is Created By 'Kvc', #TheBATeam ...
Echo.
Echo. Press Any key to Go Back...
pause >nul
Fn.dll color 00
cls
Fn.dll color 07
goto :Menu

:Box
setlocal Enabledelayedexpansion
set _string=
set "_SpaceWidth=/d ""
set _final=

set x_val=%~1
set y_val=%~2
set sepr=%~5
if /i "!sepr!" == "-" (set sepr=)
set char=%~6
if /i "!char!" == "-" (set char=)
if defined char (set char=!char:~0,1!) ELSE (set "char= ")
set color=%~7
if defined color (if /i "!color!" == "-" (set color=) Else (set "color=/c 0x%~7"))

set _Hor_line=/a 196
set _Ver_line=/a 179
set _Top_sepr=/a 194
set _Base_sepr=/a 193
set _Top_left=/a 218
set _Top_right=/a 191
set _Base_right=/a 217
set _Base_left=/a 192

set /a _char_width=%~4-2
set /a _box_height=%~3-2

for /l %%A in (1,1,!_char_width!) do (
	if /i "%%A" == "%~5" (
	set "_string=!_string! !_Top_sepr!"
	set "_SpaceWidth=!_SpaceWidth!" !_Ver_line! /d ""
	) ELSE (
	set "_string=!_string! !_Hor_line!"
	set "_SpaceWidth=!_SpaceWidth!!char!"
	)
)

set "_SpaceWidth=!_SpaceWidth!""
set "_final=!_final! /g !x_val! !y_val! !_Top_left! !_string! !_Top_right!"
set /a y_val+=1

for /l %%A in (1,1,!_box_height!) do (
set "_final=!_final! /g !x_val! !y_val! !_Ver_line! !_SpaceWidth! !_Ver_line!"
set /a y_val+=1
)

set "_final=!_final! /g !x_val! !y_val! !_Base_left! !_string:194=193! !_Base_right!"

endlocal && batbox.exe %color% %_final% /c0x07 /g 0 0
goto :eof
