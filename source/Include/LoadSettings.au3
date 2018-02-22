#include-once
#include <StringConstants.au3>
#include <File.au3>
#include <Array.au3>
#include ".\SimpleR_Constants.au3"

#Region Functions
Func GetGeneral($uselocal = 1)
	Local $array
	Local $arrayDefault = DefaultGeneral()

	If FileExists($pathGeneral) And $uselocal = 1 Then
		$array = _LoadFromCSV2D($pathGeneral)
		$array = _UpdateArray($array, $arrayDefault, $pathGeneral)
	Else
		$array=$arrayDefault
		_SaveToCSV($pathGeneral, $arrayDefault)
	EndIf
	Return $array
EndFunc   ;==>GetGeneral

Func GetPaths($uselocal = 1)
	Local $array
	Local $arrayDefault = DefaultPaths()

	If FileExists($pathPaths) And $uselocal = 1 Then
		$array = _LoadFromCSV2D($pathPaths)
		$array = _UpdateArray($array, $arrayDefault, $pathPaths)
	Else
		$array=$arrayDefault
		_SaveToCSV($pathPaths, $arrayDefault)
	EndIf
	For $i = 0 To UBound($array, 1) - 1
		$array[$i][1] = _PathConvert($array[$i][$cAIcontent])
	Next
	Return $array
EndFunc   ;==>GetPaths

Func GetMacros($uselocal = 1)
	Local $array
	Local $arrayDefault = DefaultMacros()

	If FileExists($pathMacros) And $uselocal = 1 Then
		$array = _LoadFromCSV2D($pathMacros)
		$array = _UpdateArray($array, $arrayDefault, $pathMacros)
	Else
		$array=$arrayDefault
		_SaveToCSV($pathMacros, $arrayDefault)
	EndIf
	Return $array
EndFunc   ;==>GetMacros

Func GetIngame($uselocal = 1)
	Local $array
	Local $arrayDefault = DefaultIngame()

	If FileExists($pathIngame) And $uselocal = 1 Then
		$array = _LoadFromCSV2D($pathIngame)
		$array = _UpdateArray($array, $arrayDefault, $pathIngame)
	Else
		$array=$arrayDefault
		_SaveToCSV($pathIngame, $arrayDefault)
	EndIf
	Return $array
EndFunc   ;==>GetIngame

Func GetHotkeys($uselocal = 1)
	Local $array
	Local $arrayDefault = DefaultHotkeys()

	If FileExists($pathHotkeys) And $uselocal = 1 Then
		$array = _LoadFromCSV2D($pathHotkeys)
		$array = _UpdateArray($array, $arrayDefault, $pathHotkeys)
	Else
		$array=$arrayDefault
		_SaveToCSV($pathHotkeys, $arrayDefault)
	EndIf
	Return $array
EndFunc   ;==>GetHotkeys

Func GetRedirects($uselocal = 1)
	Local $array
	Local $arrayDefault = DefaultRedirects()

	If FileExists($pathRedirects) And $uselocal = 1 Then
		$array = _LoadFromCSV2D($pathRedirects)
		$array = _UpdateArray($array, $arrayDefault, $pathRedirects)
	Else
		$array=$arrayDefault
		_SaveToCSV($pathRedirects, $arrayDefault)
	EndIf
	Return $array
EndFunc   ;==>GetHotkeys

#Region DefaultSettings
Func DefaultGeneral()
	Local $SettingsGeneral[][] = [ _
			["bTesting", "0"], _
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
EndFunc   ;==>DefaultGeneral

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
EndFunc   ;==>DefaultPaths

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
EndFunc   ;==>DefaultMacros

Func DefaultIngame()
	Local $SettingsIngame[][] = [ _
			["Chat", "1", "ENTER"], _
			["Ability", "1", "SPACE"], _
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
EndFunc   ;==>DefaultIngame

Func DefaultHotkeys()
	Local $SettingsHotkeys[][] = [ _
			["ResetSize", "1", "F6"], _
			["43Maximize", "1", "F7"], _
			["Screenshot", "1", "PRINTSCREEN"], _
			["SetAnchor", "1", "F8"], _
			["TPAnchor", "1", "F9"], _
			["IgnorePM", "1", "F11"], _
			["ToggleFocus", "0", "Numpad9"], _
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
EndFunc   ;==>DefaultHotkeys

Func DefaultRedirects()
	Local $SettingsRedirects[][] = [ _
			["Redirect1", "0", "X2Mouse","0"], _
			["Redirect2", "0", "X1Mouse", "F5"], _
			["RedirectR", "0", "Mousekey", "Key"], _
			["RedirectR", "0", "Mousekey", "Key"], _
			["RedirectR", "0", "Mousekey", "Key"], _
			["RedirectR", "0", "Mousekey", "Key"], _
			["RedirectR", "0", "Mousekey", "Key"], _
			["RedirectR", "0", "Mousekey", "Key"], _
			["RedirectR", "0", "Mousekey", "Key"], _
			["RedirectR", "0", "Mousekey", "Key"]]
	Return $SettingsRedirects
EndFunc   ;==>DefaultHotkeys

#EndRegion DefaultSettings

Func _PathConvert($path)
	If Not StringInStr($path, ":\") <> 0 Then
		$path = @ScriptDir & $path
	EndIf

	Return $path
EndFunc   ;==>_PathConvert

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
EndFunc   ;==>_LoadFromCSV2D

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
EndFunc   ;==>_LoadFromCSV

Func _SaveToCSV($csvSource, $array)
	If Not FileExists(@ScriptDir & "\data\") Then
		DirCreate(@ScriptDir & "\data\")
	EndIf
	_FileWriteFromArray($csvSource, $array, Default, Default, ";-")

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
EndFunc   ;==>_SaveToCSV

Func _ClearKeys($array, $type = 0)
	For $i = UBound($array, 1) - 1 To 0 Step -1
		If ($array[$i][1]) = 1 Then
			If $type = 0 Then
				$array[$i][$cAIKey] = _GetKeyByAlpha($array[$i][$cAIKey])
			EndIf

		Else
			_ArrayDelete($array, $i)
		EndIf
	Next
	Return $array
EndFunc   ;==>_ClearKeys

Func _Compare2DArrays($arrayOLD, $arrayNEW)
	For $i = 0 To UBound($arrayOLD) - 1

		For $j = 0 To UBound($arrayOLD, 2) - 1
			If $arrayOLD[$i][$j] <> $arrayNEW[$i][$j] Then
				Return 1
			EndIf
		Next
	Next
	Return 0
EndFunc   ;==>_Compare2DArrays

Func _ConvertPath($path, $dir = @ScriptDir)
	Local $length = StringLen($dir)
	If (StringInStr($path, $dir)) Then
		$path = StringTrimLeft($path, $length)
	EndIf
	Return $path
EndFunc   ;==>_ConvertPath

Func _ResetSettings()
	Local $array = GetGeneral(0)
	$array = GetPaths(0)
	$array = GetMacros(0)
	$array = GetIngame(0)
	$array = GetHotkeys(0)
EndFunc   ;==>_ResetSettings

Func _UpdateArray($savedArray, $defaultArray, $savePath)
	Local $updated = 0
	For $i = 0 To UBound($savedArray) - 1
		If $savedArray[$i][$cAIdescription] <> $defaultArray[$i][$cAIdescription] Then
			For $j = 0 To UBound($savedArray, 2) - 1
				$savedArray[$i][$j] = $defaultArray[$i][$j]
			Next
			$updated = 1
		EndIf
	Next
	If $updated = 1 Then
		_SaveToCSV($savePath, $savedArray)
	EndIf
	Return $savedArray
EndFunc   ;==>_UpdateArray

#EndRegion Functions
