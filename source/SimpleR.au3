#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\data\Icons\SimpleR.ico
#AutoIt3Wrapper_Compression=0
#AutoIt3Wrapper_Res_Description=Simple launcher to play RotMG
#AutoIt3Wrapper_Res_Fileversion=1.0.1.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=GerRudi
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_HiDpi=n
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so /rm /pe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region
#EndRegion

#include <Misc.au3> ;_IsPressed
#include "./Include/LoadSettings.au3" ;for hotkeys / macros
#include <Inet.au3>
#include <File.au3>
#include <ScreenCapture.au3> ;for screenshot
#include <Date.au3> ; for file-name for screenshot
#include "./Include/IsPressed_UDF.au3"
#include <StringConstants.au3>
#include <APIResConstants.au3>
#include "./Include/InitialSetup.au3"
#include "./Include/ResizeStuff.au3"

#Region MetroGUI
;YOU NEED TO EXCLUDE FOLLOWING FUNCTIONS FROM AU3STRIPPER, OTHERWISE IT WON'T WORK:
#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete
;Please not that Au3Stripper will show errors. You can ignore them as long as you use the above Au3Stripper_Ignore_Funcs parameters.
#EndRegion MetroGUI



Opt("TrayMenuMode", 3) ; The default tray menu items will not be shown and items are not checked when selected. These are options 1 and 2 for TrayMenuMode.
Opt("TrayAutoPause", 0) ; no auto pause for tray
TraySetIcon(@ScriptFullPath, 0)


; ########################################## VARIABLES ################################################
Global $hWnd_FP ;path to the config file
Local $t = _ScreenCompatibility()
Global $AF_compatible
Global $AF_active = 0
Global $Dkstp_w = @DesktopWidth
Global $Dkstp_h = @DesktopHeight
If IsArray($t) Then
	$AF_compatible = 1
Else
	$AF_compatible = 0
EndIf


Global $trayForceFocus
Global $traySettings
Global $trayReloadSettings
Global $trayCommands
Global $trayMrEyeball
Global $trayMETtagcheater
Global $trayMETtagscammer
Global $trayMETUNtagcheater
Global $trayMETUNtagscammer
Global $trayMETcheckscammer
Global $trayMEpassword
Global $trayMEstats
Global $trayMElefttomax
Global $trayMEhideme
Global $trayMEfriends
Global $trayMEserver
Global $trayMEmates
Global $trayMEguild
Global $trayCommandEvent
Global $trayCommandClasses
Global $trayCommandWho
Global $trayCommandNexustutorial
Global $trayCommandServer
Global $traySewer
Global $traySewerTime
Global $traySewerPlace
Global $traySewerNight
Global $traySewerLike
Global $traySewerWho
Global $traySiteRealmeye
Global $traySiteReddit
Global $traySitePfiffel
Global $traySiteProject
Global $trayExit

; ########################################## FUNCTION CALLS ###########################################
main() ;main call
end() ;end call



;############TODO: compare hotkeys in Settings.au3

AutoItSetOption("SendKeyDelay", 1)
AutoItSetOption("SendKeyDownDelay", 1)

Func main()
	$savedGeneral = GetGeneral()
	$savedPaths = GetPaths()

	If Not (FileExists($savedPaths[$sFlashFile][$cAIcontent])) Then
		_Welcome()

	EndIf

	$savedMacros = GetMacros()
	$savedIngame = GetIngame()
	$savedHotkeys = GetHotkeys()
	$savedMacros = _ClearKeys($savedMacros)
	$savedHotkeys = _ClearKeys($savedHotkeys)
	$savedIngame = _ClearKeys($savedIngame, 1)

	$chat = "{" & $savedIngame[$igChat][$cAIKey] & "}"
	$ability = "{" & $savedIngame[$igAbility][$cAIKey] & "}"
	$tell = "{" & $savedIngame[$igTell][$cAIKey] & "}"

	$SWF = _GetSWF()

	_TrayItems()

	;Run Additional Program on Startup
	If $savedGeneral[$bLaunchAdditionalProgram][$cAIactive] = 1 Then
		Run($savedGeneral[$sAdditionalProgramPath][$cAIcontent])
	EndIf

	#Region StartGame
	Local $bProjectorExists = FileExists($savedPaths[$sFlashFile][$cAIcontent])
	If $bProjectorExists Then
		If $savedGeneral[$bTesting][$cAIactive] = 0 Then ; bTesting = 0? (false)
			If $savedGeneral[$bKongregate][$cAIactive] = 1 Then ; bKongregate = 1? (true)
				Run($savedPaths[$sFlashFile][$cAIcontent] & ' ' & $SWF[$cSWFproduction][$cSWFloader] & $savedGeneral[$sKongregateParameters][$cAIcontent])
			Else
				If $savedGeneral[$bAGCLoader][$cAIactive] = 0 Then ;bAGCLoader 0 0? (false)
					;run AGCLIENT
					Run($savedPaths[$sFlashFile][$cAIcontent] & ' ' & $SWF[$cSWFproduction][$cSWFclient])
				Else
					;run AGCLOADER
					Run($savedPaths[$sFlashFile][$cAIcontent] & ' ' & $SWF[$cSWFproduction][$cSWFloader])
				EndIf

			EndIf

		Else
			;Run Testing#####
			If $savedGeneral[$bAGCLoader][$cAIactive] = 0 Then ;bAGCLoader 0 0? (false)
				;run AGCLIENT
				Run($savedPaths[$sFlashFile][$cAIcontent] & ' ' & $SWF[$cSWFtesting][$cSWFclient])
			Else
				;run AGCLOADER
				Run($savedPaths[$sFlashFile][$cAIcontent] & ' ' & $SWF[$cSWFtesting][$cSWFloader])
			EndIf
		EndIf

	Else
		MsgBox(16, "Error", "Could not find Flash Projector at '" & $savedPaths[$sFlashFile][$cAIcontent] & "'")
		Exit
	EndIf
	#EndRegion StartGame


	Global $WindowClass = "[CLASS:ShockwaveFlash]" ; HANDLE for window rename
	If $savedGeneral[$sWindowName][$cAIcontent] <> "" Then ;sWindowName
		WinWait($WindowClass, "", 2)
		WinSetTitle($WindowClass, '', $savedGeneral[$sWindowName][$cAIcontent])
	EndIf
	Global $hWnd = WinGetHandle($WindowClass)

	_solutionchange()
	Local $pid = WinGetProcess($WindowClass)
	ProcessSetPriority($pid, 4)

	If $savedGeneral[$bKeepWindowFocused][$cAIactive] = 1 Then
		TrayTip("Warning", "Force Focus is activated! Use the hotkey or rightclick the Icon to disable! " & "You can deactivate it permanently in the Settings. ", 5, 2)
	EndIf

	If $savedGeneral[$bCustomCursor][$cAIactive] = 1 And FileExists($savedPaths[$sCustomCursorPath][$cAIcontent]) Then
		_SetCursor($savedPaths[$sCustomCursorPath][$cAIcontent], $OCR_NORMAL)
	EndIf

	While WinExists($hWnd)


		If $savedGeneral[$bKeepWindowFocused][$cAIactive] = 1 Then ;bKeepWindowFocused - Warning: aggressive!
			If Not WinActive($hWnd) Then
				WinActivate($hWnd)
			EndIf
		EndIf

		;MACROS
		If $savedGeneral[$bMacros][$cAIactive] = 1 Then
			For $i = UBound($savedMacros, 1) - 1 To 0 Step -1
				If _IsPressed($savedMacros[$i][$cAIKey]) Then
					_SendMacro($savedMacros[$i][$cAImacrotext], $chat)
					Do
						Sleep(100)
					Until Not _IsPressed($savedMacros[$i][$cAIKey])
				EndIf

			Next
		EndIf

		If $savedGeneral[$bHotkeys][$cAIactive] = 1 Then
			For $i = UBound($savedHotkeys, 1) - 1 To 0 Step -1
				If _IsPressed($savedHotkeys[$i][$cAIKey]) Then
					Switch $savedHotkeys[$i][$cAIdescription]

						Case "ResetSize"
							_solutionchange()
						Case "43Maximize"
							_43Maximize()
						Case "Screenshot"
							_captureShot($savedGeneral[$bCursorOnScreenshot][$cAIactive])
						Case "SetAnchor"
							$newanchor = _Metro_InputBox("Please enter the name of your anchor", 11, $savedGeneral[$sDefaultAnchor][$cAIcontent], False, True, $hWnd)
							If Not @error Then
								$savedGeneral[$sDefaultAnchor][$cAIcontent] = $newanchor
							EndIf
						Case "TPAnchor"
							_TPAnchor($savedGeneral[$sDefaultAnchor][$cAIcontent], $chat, $savedIngame[$igCommand][$cAIKey])
						Case "IgnorePM"
							_IgnorePM($tell, $savedIngame[$igCommand][$cAIKey])
						Case "ToggleFocus"
							$savedGeneral[$bKeepWindowFocused][$cAIactive] = _ToggleForceFocus($savedGeneral[$bKeepWindowFocused][$cAIactive])
						Case "ActualFullscreen"
							If $AF_active = 0 Then
								_ChangeScreenRes(800, 600, @DesktopDepth, @DesktopRefresh)
								$AF_active = 1
								WinActivate($hWnd)
								Send('^f') ;hotkey to activate flash projector fullscreen
							Else
								$s = _ChangeScreenRes($Dkstp_w, $Dkstp_h, @DesktopDepth, @DesktopRefresh)
								$AF_active = 0
								WinActivate($hWnd)
								Send('{ESC}') ;exit flash projector fullscreen
								Sleep(100)
								_solutionchange()
							EndIf
						Case Else
					EndSwitch
					Do
						Sleep(200)
					Until Not _IsPressed($savedHotkeys[$i][$cAIKey])
				EndIf
			Next

		EndIf

		Switch TrayGetMsg()
			Case $trayForceFocus
				$savedGeneral[$bKeepWindowFocused][$cAIactive] = _ToggleForceFocus($savedGeneral[$bKeepWindowFocused][$cAIactive])
			Case $traySettings ; Open Settings
				ShellExecute($pathSettings)

			Case $trayReloadSettings ; Reload Settings
				$savedGeneral = GetGeneral()
				$savedPaths = GetPaths()
				$savedMacros = GetMacros()
				$savedIngame = GetIngame()
				$savedHotkeys = GetHotkeys()
				$savedMacros = _ClearKeys($savedMacros)
				$savedHotkeys = _ClearKeys($savedHotkeys)
				$savedIngame = _ClearKeys($savedIngame, 1)
				$chat = "{" & $savedIngame[$igChat][$cAIKey] & "}"
				$ability = "{" & $savedIngame[$igAbility][$cAIKey] & "}"
				$tell = "{" & $savedIngame[$igTell][$cAIKey] & "}"
				If $savedGeneral[$bCustomCursor][$cAIactive] = 1 And FileExists($savedPaths[$sCustomCursorPath][$cAIcontent]) Then
					_SetCursor($savedPaths[$sCustomCursorPath][$cAIcontent], $OCR_NORMAL)
				EndIf
				TrayTip("Reload successful", "The settings were reloaded succuessfully", 2, 16)
;~ 		COMMANDS
;~ 			MASTER RAT
			Case $traySewerTime
				WinActivate($hWnd)
				_SendMacro("Its pizza time!", $chat)
			Case $traySewerPlace
				WinActivate($hWnd)
				_SendMacro("Inside my shell.", $chat)
			Case $traySewerNight
				WinActivate($hWnd)
				_SendMacro("A ninja of course!", $chat)
			Case $traySewerLike
				WinActivate($hWnd)
				_SendMacro("Extra cheese, hold the anchovies.", $chat)
			Case $traySewerWho
				WinActivate($hWnd)
				_SendMacro("Dr. Terrible, the mad scientist.", $chat)


;~ 			MR EYEBALL
				; TEMPLATES

			Case $trayMETtagcheater
				WinActivate($hWnd)
				_PrepareSend($savedIngame[$igCommand][$cAIKey] & "tell MrEyeball tag cheater ", $chat)
			Case $trayMETtagscammer
				WinActivate($hWnd)
				_PrepareSend($savedIngame[$igCommand][$cAIKey] & "tell MrEyeball tag scammer ", $chat)
			Case $trayMETUNtagcheater
				WinActivate($hWnd)
				_PrepareSend($savedIngame[$igCommand][$cAIKey] & "tell MrEyeball untag cheater ", $chat)
			Case $trayMETUNtagscammer
				WinActivate($hWnd)
				_PrepareSend($savedIngame[$igCommand][$cAIKey] & "tell MrEyeball untag scammer ", $chat)
			Case $trayMETcheckscammer
				WinActivate($hWnd)
				_PrepareSend($savedIngame[$igCommand][$cAIKey] & "tell MrEyeball scammer ", $chat)


			Case $trayMEpassword
				WinActivate($hWnd)
				_SendMacro($savedIngame[$igCommand][$cAIKey] & "tell MrEyeball password", $chat)
			Case $trayMEstats
				WinActivate($hWnd)
				_SendMacro($savedIngame[$igCommand][$cAIKey] & "tell MrEyeball stats", $chat)
			Case $trayMElefttomax
				WinActivate($hWnd)
				_SendMacro($savedIngame[$igCommand][$cAIKey] & "tell MrEyeball lefttomax", $chat)
			Case $trayMEhideme
				WinActivate($hWnd)
				_SendMacro($savedIngame[$igCommand][$cAIKey] & "tell MrEyeball hide me", $chat)
			Case $trayMEfriends
				WinActivate($hWnd)
				_SendMacro($savedIngame[$igCommand][$cAIKey] & "tell MrEyeball friends", $chat)
			Case $trayMEserver
				WinActivate($hWnd)
				_SendMacro($savedIngame[$igCommand][$cAIKey] & "tell MrEyeball server", $chat)
			Case $trayMEmates
				WinActivate($hWnd)
				_SendMacro($savedIngame[$igCommand][$cAIKey] & "tell MrEyeball mates", $chat)
			Case $trayMEguild
				WinActivate($hWnd)
				_SendMacro($savedIngame[$igCommand][$cAIKey] & "tell MrEyeball hide my guild", $chat)

;~ 			GENERAL
			Case $trayCommandEvent
				WinActivate($hWnd)
;~ 				MsgBox(0,"","Done")
				_SendMacro($savedIngame[$igCommand][$cAIKey] & "event", $chat)
			Case $trayCommandClasses
				WinActivate($hWnd)
				_SendMacro($savedIngame[$igCommand][$cAIKey] & "c", $chat)
			Case $trayCommandWho
				WinActivate($hWnd)
				_SendMacro($savedIngame[$igCommand][$cAIKey] & "who", $chat)
			Case $trayCommandNexustutorial
				WinActivate($hWnd)
				_SendMacro($savedIngame[$igCommand][$cAIKey] & "nexustutorial", $chat)
			Case $trayCommandServer
				WinActivate($hWnd)
				_SendMacro($savedIngame[$igCommand][$cAIKey] & "server", $chat)
;~ 		END OF COMMANDS

			Case $traySiteRealmeye ; WEBSITE ENTRY -
				ShellExecute("https://realmeye.com/")
			Case $traySiteReddit ; WEBSITE ENTRY -
				ShellExecute("https://reddit.com/r/RotMG")
			Case $traySitePfiffel ; WEBSITE ENTRY -
				ShellExecute("http://pfiffel.com/")
			Case $traySiteProject ; WEBSITE ENTRY -
				ShellExecute("https://github.com/GerRudi/SimpleR-RotMG")
			Case $trayExit ; EXIT ENTRY - closes game, client & restores cursor
				Local $pid = WinGetProcess($WindowClass)
				ProcessClose($pid)
				end()
		EndSwitch

	WEnd

EndFunc   ;==>main


Func _SendMacro($text, $ChatKey)
	ClipPut($text)
	If @error Then
		;SLOW
		Send($ChatKey)
		Sleep(10)
		Send($text)
		Sleep(10)
		Send("{Enter}")
	Else
		Send($ChatKey)
		While Not StringInStr(ClipGet(), $text) ;wait till "Macro " is found in clipboard
			Sleep(1)
		WEnd
		Send("^{v}")
		Sleep(1)
		Send("{Enter}")
		Sleep(100)
	EndIf
EndFunc   ;==>_SendMacro



Func _PrepareSend($text, $ChatKey)
	ClipPut($text)
	If @error Then
		;SLOW
		Send($ChatKey)
		Sleep(10)
		Send($text)

	Else
		Send($ChatKey)
		While Not StringInStr(ClipGet(), $text) ;wait till "Macro " is found in clipboard
			Sleep(1)
		WEnd
		Send("^{v}")
		Sleep(100)
	EndIf
EndFunc   ;==>_PrepareSend


Func _ToggleForceFocus($currentState)
	If $currentState = 1 Then
		$currentState = 0
		;TT
		TrayTip("Force Focus", "Force Focus was disabled.", 2, 16)
	Else
		$currentState = 1
		;TT
		TrayTip("Force Focus", "Force Focus is now enabled!", 2, 16)
	EndIf
	Return $currentState
EndFunc   ;==>_ToggleForceFocus


Func _TPAnchor($name, $ChatKey, $cmdChar)
	Local $text = $cmdChar & "teleport " & $name

	ClipPut($text)
	If @error Then
		;SLOW
		Send($ChatKey)
		Sleep(10)
		Send($text)
		Sleep(10)
		Send("{Enter}")

	Else
		Send($ChatKey)
		While Not StringInStr(ClipGet(), $text) ;wait till "command " is found in clipboard
			Sleep(1)
		WEnd
		Send("^{v}")
		Sleep(1)
		Send("{Enter}")
	EndIf


EndFunc   ;==>_TPAnchor

Func _IgnorePM($TellKey, $cmdChar)

	Local $text = $cmdChar & "ignore"

	ClipPut($text)
	If @error Then
		;SLOW
		Send($TellKey)
		Sleep(10)
		Send("{HOME}{DEL 5}")
		Sleep(10)
		Send($text)
		Sleep(10)
		Send("{Enter}")

	Else
		While Not StringInStr(ClipGet(), $text) ;wait till "command " is found in clipboard
			Sleep(1)
		WEnd
		Send($TellKey)
		Sleep(10)
		Send("{HOME}{DEL 5}")
		Sleep(10)
		Send("^{v}")
		Sleep(1)
		Send("{Enter}")
	EndIf
EndFunc   ;==>_IgnorePM





Func _solutionchange($a = 150, $b = 150) ; resize window to default
	Local $size[4]
	$size = WinGetPos($hWnd)
	$a = (@DesktopWidth - $WIDTH) / 2
	$b = (@DesktopHeight - $HEIGHT) / 2
	If $size[0] <> $HEIGHT Or $size[1] <> $WIDTH Then
		WinMove($hWnd, "", $a, $b, $WIDTH, $HEIGHT, 1)
	EndIf
EndFunc   ;==>_solutionchange


Func _43Maximize()
	$po = WinGetPos("[CLASS:Shell_TrayWnd]")
	Local $windowheight = @DesktopHeight
	Local $top = 0
	Local $left = @DesktopWidth / 8
	If $po[1] > 0 Then ;Taskbar BOTTOM
		$windowheight = $windowheight - $po[3]
	ElseIf $po[0] = 0 And $po[1] = 0 And $po[2] = @DesktopWidth Then ;Taskbar TOP
		$windowheight = $windowheight - $po[3]
		$top = $po[3]
	Else
	EndIf
	Local $windowwidth = $windowheight * 1.33
	WinMove($hWnd, "", $left, $top, $windowwidth, $windowheight, 1)
EndFunc   ;==>_43Maximize


Func _captureShot($showCursor = 1)
	If Not WinActive($hWnd) Then
		Return -1
	EndIf
	Local $cDate = _NowCalc()
	Local $newTimeOnly, $newDateOnly
	If Not FileExists(@ScriptDir & "\Screenshots\") Then
		DirCreate(@ScriptDir & "\Screenshots\")
	EndIf


	_DateTimeSplit($cDate, $newDateOnly, $newTimeOnly)
	Local $filename = @ScriptDir & "\Screenshots\RotMG " & $newDateOnly[3] & "-" & $newDateOnly[2] & "-" & $newDateOnly[1] & " " & $newTimeOnly[1] & "-" & $newTimeOnly[2] & "-" & $newTimeOnly[3] & ".jpg"
	If $showCursor = 1 Then
		_ScreenCapture_CaptureWnd($filename, $hWnd)
		Sleep(50)
	Else
		_ScreenCapture_CaptureWnd($filename, $hWnd, 0, 0, -1, -1, False)
		Sleep(50)
	EndIf

	TrayTip("Screenshot saved", "Screenshot saved to: " & $filename, 2, 16)

	Return 0
EndFunc   ;==>_captureShot



Func end($a = 0) ;cursor reset
	_SetCursor($a, $OCR_NORMAL, 1)
	If @DesktopWidth <> $Dkstp_w Then
		_ChangeScreenRes($Dkstp_w, $Dkstp_h, @DesktopDepth, @DesktopRefresh)
	EndIf
	Exit
EndFunc   ;==>end





; change the system cursor
; WARNING: very CPU intensive
; used to run in a While (Winactive()) loop, but was removed which recuced CPU useage around -1000%
; therefore, it's now only set once when running the game and once closing the game
Func _SetCursor($CursorFile, $RepCursor, $flag = 0) ;changes cursor
	Local Const $SPI_SETCURSORS = 0x0057 ;Used in $flag 1 to restore Cursor
	Local $temp
	If $flag = 0 Then
		$temp = DllCall($user32, 'int', 'LoadCursorFromFile', 'str', $CursorFile)
		If Not @error Then
			DllCall($user32, 'int', 'SetSystemCursor', 'int', $temp[0], 'int', $RepCursor)
			If Not @error Then
				DllCall($user32, 'int', 'DestroyCursor', 'int', $temp[0])
			Else
				Return -2
			EndIf
		Else
			Return -1
		EndIf
	ElseIf $flag = 1 Then
		DllCall($user32, 'int', 'SystemParametersInfo', 'int', $SPI_SETCURSORS, 'int', 0, 'int', 0, 'int', 0)
		If @error Then
			Return -3
		EndIf
	EndIf
EndFunc   ;==>_SetCursor


; creates tray menu entries
Func _TrayItems()

	Global $trayForceFocus = TrayCreateItem("Toggle Force Focus")

	TrayCreateItem("")
	;Options
	$traySettings = TrayCreateItem("Open Settings")
	$trayReloadSettings = TrayCreateItem("Reload Settings")
	TrayCreateItem("")
	$trayCommands = TrayCreateMenu("Commands")

	$trayMrEyeball = TrayCreateMenu("Mr. Eyeball", $trayCommands)

	$trayMETtagcheater = TrayCreateItem("cheater <player>", $trayMrEyeball)
	$trayMETtagscammer = TrayCreateItem("scammer <player>", $trayMrEyeball)
	$trayMETUNtagcheater = TrayCreateItem("NO cheater <player>", $trayMrEyeball)
	$trayMETUNtagscammer = TrayCreateItem("NO scammer <player>", $trayMrEyeball)
	$trayMETcheckscammer = TrayCreateItem("CHECK if scammer <player>", $trayMrEyeball)
	TrayCreateItem("", $trayMrEyeball)

	$trayMEpassword = TrayCreateItem("Password", $trayMrEyeball)
	$trayMEstats = TrayCreateItem("Stats", $trayMrEyeball)
	$trayMElefttomax = TrayCreateItem("LeftToMax", $trayMrEyeball)
	$trayMEhideme = TrayCreateItem("Hide Me", $trayMrEyeball)

	$trayMEfriends = TrayCreateItem("Friends", $trayMrEyeball)
	$trayMEserver = TrayCreateItem("Server", $trayMrEyeball)
	TrayCreateItem("", $trayMrEyeball)
	$trayMEmates = TrayCreateItem("Mates", $trayMrEyeball)
	$trayMEguild = TrayCreateItem("Hide My Guild", $trayMrEyeball)

	TrayCreateItem("", $trayCommands)
	$trayCommandEvent = TrayCreateItem("/event", $trayCommands)
	$trayCommandClasses = TrayCreateItem("/classes", $trayCommands)
	$trayCommandWho = TrayCreateItem("/who", $trayCommands)
	$trayCommandNexustutorial = TrayCreateItem("/nexustutorial", $trayCommands)
	$trayCommandServer = TrayCreateItem("/server", $trayCommands)

	TrayCreateItem("", $trayCommands)
	$traySewer = TrayCreateMenu("Master Rat Answers", $trayCommands)
	$traySewerTime = TrayCreateItem("What time is it? ", $traySewer)
	$traySewerPlace = TrayCreateItem("Where is the safest place in the world? ", $traySewer)
	$traySewerNight = TrayCreateItem("What is fast, quiet and hidden by the night? ", $traySewer)
	$traySewerLike = TrayCreateItem("How do you like your pizza? ", $traySewer)
	$traySewerWho = TrayCreateItem("Who did this to me? ", $traySewer)

	TrayCreateItem("")
	;Misc
	$traySiteRealmeye = TrayCreateItem("Visit RealmEye.com")
	$traySiteReddit = TrayCreateItem("Visit /r/RotMG")
	$traySitePfiffel = TrayCreateItem("Visit Pfiffel.com")
	$traySiteProject = TrayCreateItem("Visit the SimpleR website")
	TrayCreateItem("")
	;Exit
	$trayExit = TrayCreateItem("Exit")

	TraySetState(1) ; Show the tray menu.
EndFunc   ;==>_TrayItems


Func _GetSWF()
	;First try grabbing directly from source, then from version.txt as it is sometimes incorrect
	Local $SWF[][] = [ _
			["productionLoader", "productionClient"], _
			["TestingLoader", "TestingClient"]]
	Local $temp[] = ["prodID", "testID"]
	Local $bnrysrc[] = ["prodID", "testID"]
	Local $v1, $v2

	$bnrysrc[0] = InetRead('http://www.realmofthemadgod.com/index.html', 1)
	$bnrysrc[1] = InetRead('http://testing.realmofthemadgod.com/index.html', 1)

	$v1 = StringRegExp(BinaryToString($bnrysrc[0]), '(?:<embed src="AGCLoader)(.{0,})(?:.swf")', 1)
	$v2 = StringRegExp(BinaryToString($bnrysrc[1]), '(?:<embed src="AGCLoader)(.{0,})(?:.swf")', 1)
	If IsArray($v1) Then
		$SWF[0][0] = ("https://realmofthemadgodhrd.appspot.com/AGCLoader" & $v1[0] & ".swf")
		$SWF[0][1] = ("https://realmofthemadgodhrd.appspot.com/AssembleeGameClient" & $v1[0] & ".swf")

		$SWF[1][0] = ("http://testing.realmofthemadgod.com/AGCLoader" & $v2[0] & ".swf")
		$SWF[1][1] = ("http://testing.realmofthemadgod.com/AssembleeGameClient" & $v2[0] & ".swf")

	Else
		$temp[0] = _INetGetSource("http://www.realmofthemadgod.com/version.txt")
		$temp[1] = _INetGetSource("http://testing.realmofthemadgod.com/version.txt")


		$SWF[0][0] = ("https://realmofthemadgodhrd.appspot.com/AGCLoader" & $temp[0] & ".swf")
		$SWF[0][1] = ("https://realmofthemadgodhrd.appspot.com/AssembleeGameClient" & $temp[0] & ".swf")

		$SWF[1][0] = ("http://testing.realmofthemadgod.com/AGCLoader" & $temp[1] & ".swf")
		$SWF[1][1] = ("http://testing.realmofthemadgod.com/AssembleeGameClient" & $temp[1] & ".swf")
	EndIf

	Return $SWF
EndFunc   ;==>_GetSWF
