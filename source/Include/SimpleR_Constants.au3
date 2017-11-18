;Constants to be used with Scripts related to SimpleR
#include-once


Global Const $user32 = "user32.dll", $HEIGHT = 658, $WIDTH = 816 ;user32.ddl used to change mouse cursor, height + width for resize to default game window size

;Paths
$pathGeneral = @ScriptDir & "\data\General.csv"
$pathPaths = @ScriptDir & "\data\Paths.csv"
$pathMacros = @ScriptDir & "\data\Macros.csv"
$pathIngame = @ScriptDir & "\data\Ingame.csv"
$pathHotkeys = @ScriptDir & "\data\Hotkeys.csv"
$pathSettings = @ScriptDir & "\Settings.exe"

;Array indexes
Global const $cAIdescription = 0
Global const $cAIactive = 1
Global const $cAIcontent = 1
Global const $cAIKey = 2
Global const $cAImacrotext = 3

;Settings
;GENERAL
Global const $bTesting = 0
Global const $bAGCLoader = 1
Global const $bMacros = 2
Global const $bHotkeys = 3
Global const $bCustomCursor = 4
Global const $bKongregate = 5
Global const $bScreenshots = 6
Global const $bCursorOnScreenshot = 7
Global const $bKeepWindowFocused = 8
Global const $bLaunchAdditionalProgram = 9
Global const $bAnchor = 10
;~ ;Reserved 11-24
Global const $sWindowName = 25
Global const $sDefaultAnchor = 26
Global const $sKongregateParameters = 27
Global const $sAdditionalProgramPath = 28
;~ Global const $sLastKnownVersion = 29
;~ Reserved 30 - 44



;MACROS
Global const $cmacro1 = 0
Global const $cmacro2 = 1
Global const $cmacro3 = 2
Global const $cmacro4 = 3
;~  Reserved 5 - 16

;PATHS
Global const $sFlashFile = 0
Global const $sCustomCursorPath = 1
;~ Reserved 3 - 10

;INGAME KEYS
Global const $igChat = 0
Global const $igAbility = 1
Global const $igCommand = 2
Global const $igTell = 3
;~ Reserved 5-12

;HOTKEYS
Global const $hkResetSize = 0
Global const $hk43Maximize = 1
Global const $hkScreenshot = 2
Global const $hkSetAnchor = 3
Global const $hkTPAnchor = 4
Global const $hkIgnorePM = 5
Global const $hkToggleFocus = 6
Global const $hkActualFullscreen = 7
;~  Reserved 9-17

;SWF
Global const $cSWFtesting = 1
Global const $cSWFproduction = 0
Global const $cSWFloader = 0
Global const $cSWFclient = 1
