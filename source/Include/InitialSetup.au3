#include-once
#include ".\MetroGUI_UDF.au3"
#include ".\_GUIDisable.au3" ; For dim effects when msgbox is displayed
#include ".\IsPressed_UDF.au3"
#include <GUIConstants.au3>
#include <ColorConstants.au3>
#include <FontConstants.au3>
#include <String.au3>
#include <Inet.au3>

AutoItSetOption("GUICloseOnESC", 0)

;Enable high DPI support: Detects the users DPI settings and resizes GUI and all controls to look perfectly sharp.
_Metro_EnableHighDPIScaling() ; Note: Requries "#AutoIt3Wrapper_Res_HiDpi=y" for compiling. To see visible changes without compiling, you have to disable dpi scaling in compatibility settings of Autoit3.exe

;Set Theme
_SetTheme("DarkBlue") ;See MetroThemes.au3 for selectable themes or to add more

;Create resizable Metro GUI
$Form1 = _Metro_CreateGUI("Welcome to SimpleR", 800, 500, -1, -1, True)

;Add/create control buttons to the GUI
$Control_Buttons = _Metro_AddControlButtons(True, False, False, False, False) ;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True

;Set variables for the handles of the GUI-Control buttons. (Above function always returns an array this size and in this order, no matter which buttons are selected.)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
$GUI_MAXIMIZE_BUTTON = $Control_Buttons[1]
$GUI_RESTORE_BUTTON = $Control_Buttons[2]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
$GUI_FULLSCREEN_BUTTON = $Control_Buttons[4]
$GUI_FSRestore_BUTTON = $Control_Buttons[5]
$GUI_MENU_BUTTON = $Control_Buttons[6]


#Region Startpage
$s1_welcomeTo = GUICtrlCreateLabel("Welcome to", 40, 70, 720, 40, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($s1_welcomeTo, 768 + 8)
GUICtrlSetColor($s1_welcomeTo, $COLOR_WHITE)
GUICtrlSetFont($s1_welcomeTo, 20, "", "", "Segoe UI")

$s1_simpler = GUICtrlCreateLabel("SimpleR", 40, 110, 720, 80, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($s1_simpler, 768 + 8)
GUICtrlSetColor($s1_simpler, $COLOR_WHITE)
GUICtrlSetFont($s1_simpler, 40, "", "", "Segoe UI")


$s1_description = GUICtrlCreateLabel("The convenient way to play RotMG.", 40, 200, 720, 40, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($s1_description, 768 + 8)
GUICtrlSetColor($s1_description, $COLOR_WHITE)
GUICtrlSetFont($s1_description, 20, "", "", "Segoe UI")


$s1_btnletsgo = _Metro_CreateButtonEx("Let's go!", 300, 400, 200, 50, $ButtonBKColor, $ButtonTextColor, "Arial", 16)
GUICtrlSetResizing($s1_btnletsgo, 768 + 8)

#EndRegion Startpage


#Region FlashPage
$s2_Almost = GUICtrlCreateLabel("We are almost ready to play. " & @CRLF & "Before we can start, we need to download Adobe Flash Projector.", 40, 70, 720, 200, $SS_CENTER)
GUICtrlSetResizing($s2_Almost, 768 + 8)
GUICtrlSetColor($s2_Almost, $COLOR_WHITE)
GUICtrlSetFont($s2_Almost, 20, "", "", "Segoe UI")

$s2_pleaseChoose = GUICtrlCreateLabel("Select version", 220, 260, 120, 20)
GUICtrlSetResizing($s2_pleaseChoose, 768 + 8)
GUICtrlSetColor($s2_pleaseChoose, $COLOR_WHITE)
GUICtrlSetFont($s2_pleaseChoose, 14, "", "", "Segoe UI")

;Global $fpversions = "Flashplayer_26_sa.exe|Flashplayer_25_sa.exe|Flashplayer_24_sa.exe|Flashplayer_23_sa.exe|Flashplayer_22_sa.exe|Flashplayer_21_sa.exe|Flashplayer_20_sa.exe" & _
;		"|Flashplayer_19_sa.exe|Flashplayer_18_sa.exe|Flashplayer_17_sa.exe|Flashplayer_16_sa.exe|Flashplayer_15_sa.exe|Flashplayer_14_sa.exe (common choice)|Flashplayer_13_sa.exe|Flashplayer_12_sa.exe|Flashplayer_11_sa.exe|Flashplayer_10_sa.exe"
Global $fpversions = "Flashplayer_30_sa.exe (recommended)" ; BAND AID FIX


Local $s2_version = GUICtrlCreateCombo("Flashplayer_30_sa.exe (recommended)", 350, 260, 250, 20, $CBS_DROPDOWNLIST)
GUICtrlSetFont($s2_version, 10, "", "", "Segoe UI")
GUICtrlSetData($s2_version, $fpversions, "Flashplayer_30_sa.exe (recommended)")

$s2_alreadyHave = GUICtrlCreateLabel("Click here if you have already downloaded a copy of flash projector.", 220, 300, 400, 20, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($s2_alreadyHave, 768 + 8)
GUICtrlSetColor($s2_alreadyHave, $COLOR_WHITE)
GUICtrlSetFont($s2_alreadyHave, 9, "", "", "Segoe UI")

$s2_startDL = _Metro_CreateButtonEx("Download", 300, 400, 200, 50, $ButtonBKColor, $ButtonTextColor, "Arial", 16)
GUICtrlSetResizing($s2_startDL, 768 + 8)

#EndRegion FlashPage

#Region DLprocess
$s3_dltext = GUICtrlCreateLabel("Downloading... ", 150, 100, 140, 50, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($s3_dltext, 768 + 8)
GUICtrlSetColor($s3_dltext, $COLOR_WHITE)
GUICtrlSetFont($s3_dltext, 14, "", "", "Segoe UI")

$s3_status = GUICtrlCreateLabel("##%  #/# ", 440, 100, 400, 50, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($s3_status, 768 + 8)
GUICtrlSetColor($s3_status, $COLOR_WHITE)
GUICtrlSetFont($s3_status, 14, "", "", "Segoe UI")

$s3_pbar = _Metro_CreateProgress(150, 150, 500, 26)

$s3_tip = GUICtrlCreateLabel("Tip: To make the custom cursor work, please change the game option under Graphics -> Custom Cursor to 'OFF' ", 150, 200, 500, 50)
GUICtrlSetResizing($s3_tip, 768 + 8)
GUICtrlSetColor($s3_tip, $COLOR_WHITE)
GUICtrlSetFont($s3_tip, 14, "", "", "Segoe UI")

#EndRegion DLprocess

#Region FinalPage


$s4_doneText = GUICtrlCreateLabel("Done! " & @CRLF & "Check out the settings (recommended) " & @CRLF & "or start playing the game c:", 40, 70, 720, 120, $SS_CENTER)
GUICtrlSetResizing($s4_doneText, 768 + 8)
GUICtrlSetColor($s4_doneText, $COLOR_WHITE)
GUICtrlSetFont($s4_doneText, 20, "", "", "Segoe UI")

$s4_settings = _Metro_CreateButtonEx("Settings", 100, 300, 200, 50, $ButtonBKColor, $ButtonTextColor, "Arial", 16)
GUICtrlSetResizing($s4_settings, 768 + 8)

$s4_play = _Metro_CreateButtonEx("Play", 500, 300, 200, 50, $ButtonBKColor, $ButtonTextColor, "Arial", 16)
GUICtrlSetResizing($s4_play, 768 + 8)

#EndRegion FinalPage


Func _Welcome()
	_InitialHide()
	_ShowStartpage()

	GUISetState(@SW_SHOW)
	While 1

		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $GUI_CLOSE_BUTTON
				_Metro_GUIDelete($Form1) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
				Exit
			Case $s1_btnletsgo
				_InitialHide()
				_ShowFlashPage()
			Case $s2_alreadyHave
				_GUIDisable($Form1, 0, 30)
				$r = FileOpenDialog("Please choose the flash projector file", @ScriptDir, "Executables (*.exe)", 0, "", $Form1)
				If $r <> "" Then
					FileCopy($r, @ScriptDir & "\data\flash.exe", 8)
					If Not @error Then
						MsgBox(0, "Success", "A copy was created at " & @ScriptDir & "\data\flash.exe")
						_InitialHide()

						_ShowFinalPage()
					EndIf
				EndIf
				_GUIDisable($Form1, 0, 30)
			Case $s2_startDL
				$v = GUICtrlRead($s2_version)
				$v = StringTrimLeft($v, 12)
				$v = StringTrimRight($v, StringLen($v) - 2)
				_InitialHide()
				_ShowDL()
				_StartDL($v)
			Case $s4_settings
				Run($pathSettings)
				_Metro_GUIDelete($Form1) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
				Exit
			Case $s4_play
				_Metro_GUIDelete($Form1) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
				Return 0
		EndSwitch

	WEnd
EndFunc   ;==>_Welcome


Func _InitialHide()
	GUICtrlSetState($s1_welcomeTo, 32)
	GUICtrlSetState($s1_simpler, 32)
	GUICtrlSetState($s1_description, 32)
	GUICtrlSetState($s1_btnletsgo, 32)
	GUICtrlSetState($s2_Almost, 32)
	GUICtrlSetState($s2_pleaseChoose, 32)
	GUICtrlSetState($s2_version, 32)
	GUICtrlSetState($s2_alreadyHave, 32)
	GUICtrlSetState($s2_startDL, 32)

	GUICtrlSetState($s3_dltext, 32)
	GUICtrlSetState($s3_pbar[0], 32)
	GUICtrlSetState($s3_status, 32)
	GUICtrlSetState($s3_tip, 32)

	GUICtrlSetState($s4_doneText, 32)
	GUICtrlSetState($s4_settings, 32)
	GUICtrlSetState($s4_play, 32)

EndFunc   ;==>_InitialHide

Func _ShowStartpage()
	GUICtrlSetState($s1_welcomeTo, 16)
	GUICtrlSetState($s1_simpler, 16)
	GUICtrlSetState($s1_description, 16)
	GUICtrlSetState($s1_btnletsgo, 16)
EndFunc   ;==>_ShowStartpage


Func _ShowFlashPage()
	GUICtrlSetState($s2_Almost, 16)
	GUICtrlSetState($s2_pleaseChoose, 16)
	GUICtrlSetState($s2_version, 16)
	GUICtrlSetState($s2_alreadyHave, 16)
	GUICtrlSetState($s2_startDL, 16)
EndFunc   ;==>_ShowFlashPage

Func _ShowDL()
	GUICtrlSetState($s3_dltext, 16)
	GUICtrlSetState($s3_pbar[0], 16)
	GUICtrlSetState($s3_status, 16)
	GUICtrlSetState($s3_tip, 16)
EndFunc   ;==>_ShowDL

Func _StartDL($fp_version = 30)

	$FileURL = "https://fpdownload.macromedia.com/pub/flashplayer/updaters/" & $fp_version & "/flashplayer_" & $fp_version & "_sa.exe"
	ConsoleWrite($FileURL &@CRLF)
	If Not FileExists(@ScriptDir & "\data)") Then
		DirCreate(@ScriptDir & "\data")
	EndIf
	$FileName = @ScriptDir & "\data\flash.exe"
	$FileSize = InetGetSize($FileURL)
	$TotalSize = InetGetSize($FileURL)
	$flashDL = InetGet($FileURL, $FileName, 0, 1)

	While (InetGetInfo($flashDL, 2)) = False
		$stat = InetGetInfo($flashDL, 0)
		$percent = $stat / $TotalSize * 100
		$percent = Ceiling($percent)
		_Metro_SetProgress($s3_pbar, $percent)
		GUICtrlSetData($s3_status, $percent & "%   " & Round($stat / 1024 / 1024, 1) & " MB/" & Round($TotalSize / 1024 / 1024, 1) & " MB")
		Sleep(100)
	WEnd
	_Metro_SetProgress($s3_pbar, 1100)
	GUICtrlSetData($s3_status, "100" & "%   " & Round($TotalSize / 1024 / 1024, 1) & " MB/" & Round($TotalSize / 1024 / 1024, 1) & " MB")
	If Not @error Then
		_InitialHide()
		_ShowFinalPage()
	EndIf

EndFunc   ;==>_StartDL



Func _ShowFinalPage()
	GUICtrlSetState($s4_doneText, 16)
	GUICtrlSetState($s4_settings, 16)
	GUICtrlSetState($s4_play, 16)
EndFunc   ;==>_ShowFinalPage


