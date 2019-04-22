#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <Misc.au3>
#Include "NotifyBox.au3"
Opt("GUIOnEventMode", 1)

Global $hMainGUI = GUICreate("Robusto", 210, 410)
GUISetOnEvent($GUI_EVENT_CLOSE, "Close")
GUISwitch($hMainGUI)
GUISetState(@SW_SHOW)

Local $hDLL = DllOpen("user32.dll")
Global Const $configFile = "config.ini"

Global $t_HotKeys[15]
Global $t_Areas[30]
Global $h_key[16]
Global $t_organs[30]
Global $listOrgans[15]
$listOrgans[0] = "head"
$listOrgans[1] = "eyes"
$listOrgans[2] = "mouth"
$listOrgans[3] = "body"
$listOrgans[4] = "rarm"
$listOrgans[5] = "rhand"
$listOrgans[6] = "larm"
$listOrgans[7] = "lhand"
$listOrgans[8] = "groin"
$listOrgans[9] = "rleg"
$listOrgans[10] = "rfoot"
$listOrgans[11] = "lleg"
$listOrgans[12] = "lfoot"
$listOrgans[13] = "bite"
$listOrgans[14] = "kick"

GUICtrlCreateButton("Save", 100, 4, 100, 25)
GUICtrlSetOnEvent(-1, "Save")

Global $prefix = IniRead($configFile, "prefix", "key", "")
GUICtrlCreateButton("Prefix", 5, 4, 50, 25)
GUICtrlSetOnEvent(-1, "Help")
$h_key[0] = GUICtrlCreateInput(IniRead($configFile, "prefix", "key", ""), 65, 5, 25, 24)
GUICtrlSetLimit(-1, 5)

$x = 0
$y = 1
$count = 1
$arrayCount = 0
$increase = 25
$label = 25
For $organ in $listOrgans
	$t_Areas[$x] = IniRead($configFile, $organ, "x", "")
	$t_Areas[$y] = IniRead($configFile, $organ, "y", "")
	$t_HotKeys[$arrayCount] = $prefix & IniRead($configFile, $organ, "key", "")
	HotKeySet($t_HotKeys[$arrayCount], "Main")
	GUICtrlCreateButton($organ, 5, ($count * $increase) + 3, 50, 25)
	GUICtrlSetOnEvent(-1, "Set"&$organ)
	$h_key[$count] = GUICtrlCreateInput(IniRead($configFile, $organ, "key", ""), 65, ($count * $increase) + 3, 25, 24)
	GUICtrlSetLimit(-1, 1)
	$t_organs[$x] = GUICtrlCreateLabel("x : " & $t_Areas[$x], 105, ($count * $label) + 7)
	$t_organs[$y] = GUICtrlCreateLabel("y : " & $t_Areas[$y], 150, ($count * $label) + 7)
	$x = $y + 1
	$y = $y + 2
	$count = $count + 1
	$arrayCount = $arrayCount + 1
Next



While 1
    Sleep(100)
WEnd

Func Main()
	local $prevPos = MouseGetPos()
	Switch @HotKeyPressed
		Case $t_HotKeys[0]
			MouseMove($t_Areas[0], $t_Areas[1], 0)
		Case $t_HotKeys[1]
			MouseMove($t_Areas[2], $t_Areas[3], 0)
		Case $t_HotKeys[2]
			MouseMove($t_Areas[4], $t_Areas[5], 0)
		Case $t_HotKeys[3]
			MouseMove($t_Areas[6], $t_Areas[7], 0)
		Case $t_HotKeys[4]
			MouseMove($t_Areas[8], $t_Areas[9], 0)
		Case $t_HotKeys[5]
			MouseMove($t_Areas[10], $t_Areas[11], 0)
		Case $t_HotKeys[6]
			MouseMove($t_Areas[12], $t_Areas[13], 0)
		Case $t_HotKeys[7]
			MouseMove($t_Areas[14], $t_Areas[15], 0)
		Case $t_HotKeys[8]
			MouseMove($t_Areas[16], $t_Areas[17], 0)
		Case $t_HotKeys[9]
			MouseMove($t_Areas[18], $t_Areas[19], 0)
		Case $t_HotKeys[10]
			MouseMove($t_Areas[20], $t_Areas[21], 0)
		Case $t_HotKeys[11]
			MouseMove($t_Areas[22], $t_Areas[23], 0)
		Case $t_HotKeys[12]
			MouseMove($t_Areas[24], $t_Areas[25], 0)
		Case $t_HotKeys[13]
			MouseMove($t_Areas[26], $t_Areas[27], 0)
		Case $t_HotKeys[14]
			MouseMove($t_Areas[28], $t_Areas[29], 0)
	EndSwitch
	sleep(1)
	MouseClick("primary")
	MouseMove($prevPos[0], $prevPos[1], 0)
EndFunc

Func Help()
	_NotifyBox(1, 'Prefix', 'The prefix hotkey that must be pressed before the other keys. ^ = CTRL, ! = ALT, + = SHIFT. You can combine prefixes together.')
EndFunc

Func Save()
	For $i = 0 To UBound($t_HotKeys, 0)
		HotKeySet($t_HotKeys[$i])
	Next
	IniWrite($configFile, "prefix", "key", GUICtrlRead($h_key[0]))
	$prefix = GUICtrlRead($h_key[0])
	local $x = 0
	local $y = 1
	local $count = 1
	local $arrayCount = 0
	For $organ in $listOrgans
		IniWrite($configFile, $organ, "x", $t_Areas[$x])
		IniWrite($configFile, $organ, "y", $t_Areas[$y])
		IniWrite($configFile, $organ, "key", GUICtrlRead($h_key[$count]))
		$t_Hotkeys[$arrayCount] = $prefix & GUICtrlRead($h_key[$count])
		HotKeySet($t_Hotkeys[$arrayCount], "Main")
		$x = $y + 1
		$y = $y + 2
		$count = $count + 1
		$arrayCount = $arrayCount + 1
		sleep(100)
	Next
	_NotifyBox(1, 'Saved', 'Settings Saved.', 3)
EndFunc

Func Sethead()
	SetOrgan("head", 0, 1)
EndFunc
Func Seteyes()
	SetOrgan("eyes", 2, 3)
EndFunc
Func Setmouth()
	SetOrgan("mouth", 4, 5)
EndFunc
Func Setbody()
	SetOrgan("body", 6, 7)
EndFunc
Func Setrarm()
	SetOrgan("rarm", 8, 9)
EndFunc
Func Setrhand()
	SetOrgan("rhand", 10, 11)
EndFunc
Func Setlarm()
	SetOrgan("larm", 12, 13)
EndFunc
Func Setlhand()
	SetOrgan("lhand", 14, 15)
EndFunc
Func Setgroin()
	SetOrgan("groin", 16, 17)
EndFunc
Func Setrleg()
	SetOrgan("rleg", 18, 19)
EndFunc
Func Setrfoot()
	SetOrgan("rfoot", 20, 21)
EndFunc
Func Setlleg()
	SetOrgan("lleg", 22, 23)
EndFunc
Func Setlfoot()
	SetOrgan("lfoot", 24, 25)
EndFunc
Func Setbite()
	SetOrgan("bite", 26, 27)
EndFunc
Func Setkick()
	SetOrgan("kick", 28, 29)
EndFunc


Func SetOrgan($organ, $x, $y)
	_NotifyBox(1, 'Select Target', 'Select the '& $organ &' target in SS13 and hit f')
	local $i = 1
	While $i
		If _IsPressed("46", $hDll) Then
			$i = 0
			$t_Areas[$x] = MouseGetPos(0)
			$t_Areas[$y] = MouseGetPos(1)
			IniWrite($configFile, $organ, "x", $t_Areas[$x])
			IniWrite($configFile, $organ, "y", $t_Areas[$y])
			Sleep(10)
			GUICtrlSetData($t_organs[$x], "x : " & $t_Areas[$x])
			GUICtrlSetData($t_organs[$y], "y : " & $t_Areas[$y])
			_NotifyBox(2, 'Success', 'Coordinates recorded.')
			WinActivate("Robusto")
			WinActivate("Select Target")
			WinActivate("Success")
		EndIf
	Wend
EndFunc

Func Close()
    Exit
EndFunc