#include-once
#include <StringConstants.au3>
#include <File.au3>
#include <Array.au3>
#include ".\SimpleR_Constants.au3"


#Region Functions
Func GetGeneral($uselocal=1)
	Local $array
	Local $bFileExists = FileExists($pathGeneral)
    If $bFileExists And	$uselocal=1 Then
		$array = _LoadFromCSV2D($pathGeneral)
    Else
		$array = DefaultGeneral()
		_SaveToCSV($pathGeneral, $array)
    EndIf
	Return $array
EndFunc

Func GetPaths($uselocal=1)
	Local $array
	Local $bFileExists = FileExists($pathPaths)
    If $bFileExists Then
		$array = _LoadFromCSV2D($pathPaths)
    Else
		$array = DefaultPaths()
		_SaveToCSV($pathPaths, $array)
    EndIf

	For $i = 0 to Ubound($array, 1) -1

		$array[$i][1] = _PathConvert($array[$i][1])
	Next
	Return $array
EndFunc

Func GetMacros($uselocal=1)
	Local $array
	Local $bFileExists = FileExists($pathMacros)
    If $bFileExists And	$uselocal=1 Then
		$array = _LoadFromCSV2D($pathMacros)
    Else
		$array = DefaultMacros()
		_SaveToCSV($pathMacros, $array)
    EndIf
	Return $array
EndFunc



Func GetIngame($uselocal=1)
	Local $array
	Local $bFileExists = FileExists($pathIngame)
    If $bFileExists And $uselocal=1 Then
		$array = _LoadFromCSV2D($pathIngame)
    Else
		$array = DefaultIngame()
		_SaveToCSV($pathIngame, $array)
    EndIf
	Return $array
EndFunc

Func GetHotkeys($uselocal=1)
	Local $array
	Local $bFileExists = FileExists($pathHotkeys)
    If $bFileExists And	$uselocal=1 Then
		$array = _LoadFromCSV2D($pathHotkeys)
    Else
		$array = DefaultHotkeys()
		_SaveToCSV($pathHotkeys, $array)
    EndIf
	Return $array
EndFunc



#Region DefaultSettings
Func DefaultGeneral()
	Local $SettingsGeneral[][] = [ _
            ["bTesting", "0"], _
            ["bAGCLoader", "0"], _
            ["bUseMacros", "1"], _
			["bUseHotkeys", "1"], _
			["bCustomCursor", "1"], _
			["bKongregate", "0"], _
			["bEnableScreenshots", "1"], _
			["bCursorOnScreenshot", "1"], _
			["bKeepWindowFocused", "0"], _
			["bLaunchAdditionalProgram", "0"], _
			["bEnableAnchor", "1"], _
			["bReserved1", "reserved"], _
			["bReserved1", "reserved"], _
			["bReserved1", "reserved"], _
			["bReserved1", "reserved"], _
			["bReserved1", "reserved"], _
			["bReserved1", "reserved"], _
			["bReserved1", "reserved"], _
			["bReserved1", "reserved"], _
			["bReserved1", "reserved"], _
			["bReserved1", "reserved"], _
			["bReserved1", "reserved"], _
			["bReserved1", "reserved"], _
			["bReserved1", "reserved"], _
			["bReserved1", "reserved"], _
			["sWindowName", "SimpleR Realm of the Mad God"], _
			["sDefaultAnchor", "Kalle"], _
			["sKongregateParameters", "?kongregate_username=USERNAME&kongregate_user_id=USERID&kongregate_game_auth_token=TOKEN&kongregate_api_path=PATH"], _
			["sAdditionalProgramPath", "C:\temp"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
            ["sReserved1", "reserved"]]
	Return $SettingsGeneral
EndFunc

Func DefaultPaths()
	Local $SettingsPaths[][] = [ _
            ["sFlashFile", "\data\flash.exe"], _
            ["sCustomCursorPath", "\data\Cursors\rotmg.cur"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"], _
			["sReserved1", "reserved"]]
	Return $SettingsPaths
EndFunc

Func DefaultMacros()
	Local $SettingsMacros[][] = [ _
			["Macro1", "1", "F1", "He lives and reigns and conquers the world."], _
			["Macro2", "1", "F2", "black"], _
			["Macro3", "1", "F3", "/pause"], _
			["Macro4", "1", "F4", "TRAAAAAAAAAAAAIIIIIIIIIIIIIIIINNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn"], _
			["MacroR", "0", "Key", "text"], _
			["MacroR", "0", "Key", "text"], _
			["MacroR", "0", "Key", "text"], _
			["MacroR", "0", "Key", "text"], _
			["MacroR", "0", "Key", "text"], _
			["MacroR", "0", "Key", "text"], _
			["MacroR", "0", "Key", "text"], _
			["MacroR", "0", "Key", "text"], _
			["MacroR", "0", "Key", "text"], _
			["MacroR", "0", "Key", "text"], _
			["MacroR", "0", "Key", "text"], _
            ["MacroR", "0", "Key", "text"]]
	Return $SettingsMacros
EndFunc

Func DefaultIngame()
	Local $SettingsIngame[][] = [ _
			["Chat", "1", "ENTER"], _
			["Ability", "1", "SPACEBAR"], _
			["Command", "1", "/"], _
			["Tell", "1", "TAB"], _
			["reserved", "0", "Key"], _
			["reserved", "0", "Key"], _
			["reserved", "0", "Key"], _
			["reserved", "0", "Key"], _
			["reserved", "0", "Key"], _
			["reserved", "0", "Key"], _
			["reserved", "0", "Key"], _
            ["reserved", "0", "Key"]]

	Return $SettingsIngame
EndFunc

Func DefaultHotkeys()
	Local $SettingsHotkeys[][] = [ _
			["ResetSize", "1", "F6"], _
			["43Maximize", "1", "F7"], _
			["Screenshot", "1", "Print Screen"], _
			["SetAnchor", "1", "F8"], _
			["TPAnchor", "1", "F9"], _
			["IgnorePM", "1", "F11"], _
			["ToggleFocus", "0", "Num 9"], _
			["ActualFullscreen", "0", "F12"], _
			["HotkeyR", "0", "Key"], _
			["HotkeyR", "0", "Key"], _
			["HotkeyR", "0", "Key"], _
			["HotkeyR", "0", "Key"], _
			["HotkeyR", "0", "Key"], _
			["HotkeyR", "0", "Key"], _
			["HotkeyR", "0", "Key"], _
			["HotkeyR", "0", "Key"], _
            ["HotkeyR", "0", "Key"]]
	Return $SettingsHotkeys
EndFunc


#EndRegion


Func _PathConvert($path)
	If StringInStr($path,":\")<>0 Then
		ConsoleWrite ("Absolute path")
	Else
		$path = @ScriptDir  & $path
	EndIf

	Return $path
EndFunc

Func _LoadFromCSV2D($csvSource)
	Local $result
	_FileReadToArray($csvSource, $result, 4, ";-")

	If @error Then
		SetError(-1)
		Return -1
	EndIf

	If IsArray($result) Then
		Return $result
	Else
		SetError(-1)
		Return -1
	EndIf
EndFunc

Func _LoadFromCSV($csvSource)
	Local $result
	_FileReadToArray($csvSource, $result, $FRTA_NOCOUNT)

	If @error Then
		SetError(-1)
		Return -1
	EndIf

	If IsArray($result) Then
		Return $result
	Else
		SetError(-1)
		Return -1
	EndIf
EndFunc

Func _SaveToCSV($csvSource, $array)

	_FileWriteFromArray($csvSource, $array, Default, Default , ";-")

	If @error Then
		SetError(-1)
		Return -1
	EndIf

	If IsArray($array) Then
		Return $array
	Else
		SetError(-1)
		Return -1
	EndIf

EndFunc

Func _ClearKeys($array, $type = 0)
	For $i = Ubound($array, 1) -1 to 0 Step -1
			If ($array[$i][1]) = 1 Then
				If $type = 0 Then
					$array[$i][2]=_GetKeyByAlpha($array[$i][2])
				EndIf

			Else
				_ArrayDelete($array, $i)
			EndIf
	Next
	Return $array
EndFunc

Func _Compare2DArrays($arrayOLD, $arrayNEW)
	For $i = 0 To UBound($arrayOLD)-1

		For $j = 0 To UBound($arrayOLD,2)-1
			If $arrayOLD[$i][$j] <> $arrayNEW[$i][$j] Then
				Return 1
			EndIf
		Next
	Next
	Return 0
EndFunc

Func _ConvertPath($path, $dir=@ScriptDir)
	Local $length = StringLen($dir)
	If (StringInStr($path, $dir)) Then
		$path=StringTrimLeft($path,$length)
	EndIf
	Return $path
EndFunc


Func _ResetSettings()
	Local $array = GetGeneral(0)
	$array = GetPaths(0)
	$array = GetMacros(0)
	$array = GetIngame(0)
	$array = GetHotkeys(0)
EndFunc

#EndRegion

