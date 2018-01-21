#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\data\Icons\Settings.ico
#AutoIt3Wrapper_Res_Description=Settings GUI for SimpleR
#AutoIt3Wrapper_Res_Fileversion=1.0.1.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=GerRudi
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so /rm /pe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include ".\include\MetroGUI_UDF.au3"
#include ".\include\_GUIDisable.au3" ; For dim effects when msgbox is displayed
#include ".\Include\LoadSettings.au3" ;for hotkeys / macros
#include "./Include/IsPressed_UDF.au3"
#include <GUIConstants.au3>
#include <ColorConstants.au3>
#include <FontConstants.au3>
; ===============================================================================================================================
; Name ..........: Settings GUI for SimpleR
; ===============================================================================================================================
#Region MetroGUI settings

#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete
_SetTheme("DarkBlue")

#EndRegion MetroGUI settings


AutoItSetOption("GUICloseOnESC", 0)

;Create resizable Metro GUI
$Form1 = _Metro_CreateGUI("SimpleR Settings", 800, 700, -1, -1, True)

;Add/create control buttons to the GUI
$Control_Buttons = _Metro_AddControlButtons(True, True, True, True, True) ;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True

;Set variables for the handles of the GUI-Control buttons. (Above function always returns an array this size and in this order, no matter which buttons are selected.)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
$GUI_MAXIMIZE_BUTTON = $Control_Buttons[1]
$GUI_RESTORE_BUTTON = $Control_Buttons[2]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
$GUI_FULLSCREEN_BUTTON = $Control_Buttons[4]
$GUI_FSRestore_BUTTON = $Control_Buttons[5]
$GUI_MENU_BUTTON = $Control_Buttons[6]
;======================================================================================================================================================================


#Region VARIABLES
Global $savedGeneral
Global $savedPaths
Global $savedMacros
Global $savedIngame
Global $savedHotkeys
Global $savedRedirects

Global $newGeneral
Global $newPaths
Global $newMacros
Global $newIngame
Global $newHotkeys
Global $newRedirects

#EndRegion VARIABLES



#Region GENERAL
$lblMenu = GUICtrlCreateLabel("▲   Open Menu", 20, 30, 120, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblMenu, 768 + 8)
GUICtrlSetColor($lblMenu, $COLOR_WHITE)
GUICtrlSetFont($lblMenu, 9, "", "", "Segoe UI")

$tgUseMacros = _Metro_CreateToggle("Use macros", 40, 70, 250, 30)
GUICtrlSetResizing($tgUseMacros, 768 + 8)

$tgUseHotkeys = _Metro_CreateToggle("Use hotkeys", 40, 130, 250, 30)
GUICtrlSetResizing($tgUseHotkeys, 768 + 8)

$tgUseCustomCursor = _Metro_CreateToggle("Use Custom cursor", 40, 190, 250, 30)
GUICtrlSetResizing($tgUseCustomCursor, 768 + 8)

$lblCustomCursorPath = GUICtrlCreateLabel("C...", 120, 250, 600, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblCustomCursorPath, 768 + 8)
GUICtrlSetColor($lblCustomCursorPath, $COLOR_GRAY)
GUICtrlSetFont($lblCustomCursorPath, 11.5, "", "", "Segoe UI")

$browseCustomCursorPath = _Metro_CreateButton("Browse...", 40, 245, 70, 30)
GUICtrlSetResizing($browseCustomCursorPath, 768 + 8)

$tgForceFocus = _Metro_CreateToggle("Force focus on game window (avoid clicking out of the window)", 40, 310, 600, 30)
GUICtrlSetResizing($tgForceFocus, 768 + 8)

$lblGameName = GUICtrlCreateLabel("Window name:", 40, 370, 120, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblGameName, 768 + 8)
GUICtrlSetColor($lblGameName, $COLOR_WHITE)
GUICtrlSetFont($lblGameName, 11.5, "", "", "Segoe UI")

$inputGameName = GUICtrlCreateInput("RotMG", 170, 370, 550, 30)
GUICtrlSetResizing($inputGameName, 768 + 8)
GUICtrlSetColor($inputGameName, $COLOR_WHITE)
GUICtrlSetBkColor($inputGameName, $COLOR_BLACK)
GUICtrlSetFont($inputGameName, 11.5, "", "", "Segoe UI")
GUICtrlSetCursor($inputGameName, 5)

#EndRegion GENERAL

#Region MACROS
;M1
$tgMacro1 = _Metro_CreateToggle("", 40, 70, 60, 30)
GUICtrlSetResizing($tgMacro1, 768 + 8)

$btnMacro1 = GUICtrlCreateLabel("<KEY>", 120, 70, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnMacro1, 768 + 8)
GUICtrlSetColor($btnMacro1, $COLOR_WHITE)
GUICtrlSetFont($btnMacro1, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnMacro1, "0x1E648C")
GUICtrlSetCursor($btnMacro1, 0)

$inputMacro1 = GUICtrlCreateInput("Macro Text 1", 230, 70, 490, 30)
GUICtrlSetResizing($inputMacro1, 768 + 8)
GUICtrlSetColor($inputMacro1, $COLOR_WHITE)
GUICtrlSetBkColor($inputMacro1, $COLOR_BLACK)
GUICtrlSetFont($inputMacro1, 11.5, "", "", "Segoe UI")
GUICtrlSetCursor($inputMacro1, 5)

;M2
$tgMacro2 = _Metro_CreateToggle("", 40, 130, 60, 30)
GUICtrlSetResizing($tgMacro2, 768 + 8)

$btnMacro2 = GUICtrlCreateLabel("<KEY>", 120, 130, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnMacro2, 768 + 8)
GUICtrlSetColor($btnMacro2, $COLOR_WHITE)
GUICtrlSetFont($btnMacro2, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnMacro2, "0x1E648C")
GUICtrlSetCursor($btnMacro2, 0)

$inputMacro2 = GUICtrlCreateInput("Macro Text 2", 230, 130, 490, 30)
GUICtrlSetResizing($inputMacro2, 768 + 8)
GUICtrlSetColor($inputMacro2, $COLOR_WHITE)
GUICtrlSetBkColor($inputMacro2, $COLOR_BLACK)
GUICtrlSetFont($inputMacro2, 11.5, "", "", "Segoe UI")
GUICtrlSetCursor($inputMacro2, 5)

;M3
$tgMacro3 = _Metro_CreateToggle("", 40, 190, 60, 30)
GUICtrlSetResizing($tgMacro3, 768 + 8)

$btnMacro3 = GUICtrlCreateLabel("<KEY>", 120, 190, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnMacro3, 768 + 8)
GUICtrlSetColor($btnMacro3, $COLOR_WHITE)
GUICtrlSetFont($btnMacro3, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnMacro3, "0x1E648C")
GUICtrlSetCursor($btnMacro3, 0)

$inputMacro3 = GUICtrlCreateInput("Macro Text 3", 230, 190, 490, 30)
GUICtrlSetResizing($inputMacro3, 768 + 8)
GUICtrlSetColor($inputMacro3, $COLOR_WHITE)
GUICtrlSetBkColor($inputMacro3, $COLOR_BLACK)
GUICtrlSetFont($inputMacro3, 11.5, "", "", "Segoe UI")
GUICtrlSetCursor($inputMacro3, 5)

;M4
$tgMacro4 = _Metro_CreateToggle("", 40, 250, 60, 30)
GUICtrlSetResizing($tgMacro4, 768 + 8)

$btnMacro4 = GUICtrlCreateLabel("<KEY>", 120, 250, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnMacro4, 768 + 8)
GUICtrlSetColor($btnMacro4, $COLOR_WHITE)
GUICtrlSetFont($btnMacro4, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnMacro4, "0x1E648C")
GUICtrlSetCursor($btnMacro4, 0)

$inputMacro4 = GUICtrlCreateInput("Macro Text 4", 230, 250, 490, 30)
GUICtrlSetResizing($inputMacro4, 768 + 8)
GUICtrlSetColor($inputMacro4, $COLOR_WHITE)
GUICtrlSetBkColor($inputMacro4, $COLOR_BLACK)
GUICtrlSetFont($inputMacro4, 11.5, "", "", "Segoe UI")
GUICtrlSetCursor($inputMacro4, 5)

#EndRegion MACROS


#Region Hotkeys
;H1
$tgHotkey1 = _Metro_CreateToggle("", 40, 70, 60, 30)
GUICtrlSetResizing($tgHotkey1, 768 + 8)

$btnHotkey1 = GUICtrlCreateLabel("<KEY>", 120, 70, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnHotkey1, 768 + 8)
GUICtrlSetColor($btnHotkey1, $COLOR_WHITE)
GUICtrlSetFont($btnHotkey1, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnHotkey1, "0x1E648C")
GUICtrlSetCursor($btnHotkey1, 0)

$lblHotkey1 = GUICtrlCreateLabel("Reset Game to default window size", 230, 75, 490, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblHotkey1, 768 + 8)
GUICtrlSetColor($lblHotkey1, $COLOR_WHITE)
GUICtrlSetFont($lblHotkey1, 11.5, "", "", "Segoe UI")

;H2
$tgHotkey2 = _Metro_CreateToggle("", 40, 130, 60, 30)
GUICtrlSetResizing($tgHotkey2, 768 + 8)

$btnHotkey2 = GUICtrlCreateLabel("<KEY>", 120, 130, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnHotkey2, 768 + 8)
GUICtrlSetColor($btnHotkey2, $COLOR_WHITE)
GUICtrlSetFont($btnHotkey2, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnHotkey2, "0x1E648C")
GUICtrlSetCursor($btnHotkey2, 0)

$lblHotkey2 = GUICtrlCreateLabel("Maximize game window with 4:3 aspect ratio", 230, 135, 490, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblHotkey2, 768 + 8)
GUICtrlSetColor($lblHotkey2, $COLOR_WHITE)
GUICtrlSetFont($lblHotkey2, 11.5, "", "", "Segoe UI")

;H8
$tgHotkey8 = _Metro_CreateToggle("", 40, 190, 60, 30)
GUICtrlSetResizing($tgHotkey8, 768 + 8)

$btnHotkey8 = GUICtrlCreateLabel("<KEY>", 120, 190, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnHotkey8, 768 + 8)
GUICtrlSetColor($btnHotkey8, $COLOR_WHITE)
GUICtrlSetFont($btnHotkey8, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnHotkey8, "0x1E648C")
GUICtrlSetCursor($btnHotkey8, 0)

$lblHotkey8 = GUICtrlCreateLabel("Toggle actual 4:3 Fullscreen (temp. changes screen resolution)", 230, 195, 490, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblHotkey8, 768 + 8)
GUICtrlSetColor($lblHotkey8, $COLOR_WHITE)
GUICtrlSetFont($lblHotkey8, 11.5, "", "", "Segoe UI")

;H3
$tgHotkey3 = _Metro_CreateToggle("", 40, 250, 60, 30)
GUICtrlSetResizing($tgHotkey3, 768 + 8)

$btnHotkey3 = GUICtrlCreateLabel("<KEY>", 120, 250, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnHotkey3, 768 + 8)
GUICtrlSetColor($btnHotkey3, $COLOR_WHITE)
GUICtrlSetFont($btnHotkey3, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnHotkey3, "0x1E648C")
GUICtrlSetCursor($btnHotkey3, 0)

$lblHotkey3 = GUICtrlCreateLabel("Save a Screenshot of the game client", 230, 255, 490, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblHotkey3, 768 + 8)
GUICtrlSetColor($lblHotkey3, $COLOR_WHITE)
GUICtrlSetFont($lblHotkey3, 11.5, "", "", "Segoe UI")

;H3+
$tgIncludeCursor = _Metro_CreateToggle("Show cursor on screenshot", 120, 290, 250, 30)
GUICtrlSetResizing($tgIncludeCursor, 768 + 8)

;H4,5 ALL
$tgEnableAnchor = _Metro_CreateToggle("Enable save anchor feature", 40, 350, 350, 30)
GUICtrlSetResizing($tgEnableAnchor, 768 + 8)

$btnHotkey4 = GUICtrlCreateLabel("<KEY>", 120, 390, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnHotkey4, 768 + 8)
GUICtrlSetColor($btnHotkey4, $COLOR_WHITE)
GUICtrlSetFont($btnHotkey4, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnHotkey4, "0x1E648C")
GUICtrlSetCursor($btnHotkey4, 0)

$lblHotkey4 = GUICtrlCreateLabel("Set your anchor", 240, 395, 490, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblHotkey4, 768 + 8)
GUICtrlSetColor($lblHotkey4, $COLOR_WHITE)
GUICtrlSetFont($lblHotkey4, 11.5, "", "", "Segoe UI")

$btnHotkey5 = GUICtrlCreateLabel("<KEY>", 120, 430, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnHotkey5, 768 + 8)
GUICtrlSetColor($btnHotkey5, $COLOR_WHITE)
GUICtrlSetFont($btnHotkey5, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnHotkey5, "0x1E648C")
GUICtrlSetCursor($btnHotkey5, 0)

$lblHotkey5 = GUICtrlCreateLabel("Teleport to your anchor", 240, 435, 490, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblHotkey5, 768 + 8)
GUICtrlSetColor($lblHotkey5, $COLOR_WHITE)
GUICtrlSetFont($lblHotkey5, 11.5, "", "", "Segoe UI")

$inputDefaultAnchor = GUICtrlCreateInput("<Name>", 240, 470, 200, 30)
GUICtrlSetResizing($inputDefaultAnchor, 768 + 8)
GUICtrlSetColor($inputDefaultAnchor, $COLOR_WHITE)
GUICtrlSetBkColor($inputDefaultAnchor, $COLOR_BLACK)
GUICtrlSetFont($inputDefaultAnchor, 11.5, "", "", "Segoe UI")
GUICtrlSetCursor($inputDefaultAnchor, 5)

$lblDefaultAnchor = GUICtrlCreateLabel("Default anchor:", 120, 475, 120, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblDefaultAnchor, 768 + 8)
GUICtrlSetColor($lblDefaultAnchor, $COLOR_WHITE)
GUICtrlSetFont($lblDefaultAnchor, 11.5, "", "", "Segoe UI")

;H6
$tgHotkey6 = _Metro_CreateToggle("", 40, 530, 60, 30)
GUICtrlSetResizing($tgHotkey6, 768 + 8)

$btnHotkey6 = GUICtrlCreateLabel("<KEY>", 120, 530, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnHotkey6, 768 + 8)
GUICtrlSetColor($btnHotkey6, $COLOR_WHITE)
GUICtrlSetFont($btnHotkey6, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnHotkey6, "0x1E648C")
GUICtrlSetCursor($btnHotkey6, 0)

$lblHotkey6 = GUICtrlCreateLabel("Ignore the last person that sent you a message", 230, 535, 490, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblHotkey6, 768 + 8)
GUICtrlSetColor($lblHotkey6, $COLOR_WHITE)
GUICtrlSetFont($lblHotkey6, 11.5, "", "", "Segoe UI")

;H7
$tgHotkey7 = _Metro_CreateToggle("", 40, 590, 60, 30)
GUICtrlSetResizing($tgHotkey7, 768 + 8)

$btnHotkey7 = GUICtrlCreateLabel("<KEY>", 120, 590, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnHotkey7, 768 + 8)
GUICtrlSetColor($btnHotkey7, $COLOR_WHITE)
GUICtrlSetFont($btnHotkey7, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnHotkey7, "0x1E648C")
GUICtrlSetCursor($btnHotkey7, 0)

$lblHotkey7 = GUICtrlCreateLabel("Toggle 'force focus on game'", 230, 595, 490, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblHotkey7, 768 + 8)
GUICtrlSetColor($lblHotkey7, $COLOR_WHITE)
GUICtrlSetFont($lblHotkey7, 11.5, "", "", "Segoe UI")

#EndRegion Hotkeys


#Region IngameKeys
;CHAT
$btnIngame1 = GUICtrlCreateLabel("<KEY>", 40, 70, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnIngame1, 768 + 8)
GUICtrlSetColor($btnIngame1, $COLOR_WHITE)
GUICtrlSetFont($btnIngame1, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnIngame1, "0x1E648C")
GUICtrlSetCursor($btnIngame1, 0)

$lblIngame1 = GUICtrlCreateLabel("Ingame Chat key (Default: ENTER)", 150, 75, 490, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblIngame1, 768 + 8)
GUICtrlSetColor($lblIngame1, $COLOR_WHITE)
GUICtrlSetFont($lblIngame1, 11.5, "", "", "Segoe UI")

;Ability
$btnIngame2 = GUICtrlCreateLabel("<KEY>", 40, 130, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnIngame2, 768 + 8)
GUICtrlSetColor($btnIngame2, $COLOR_WHITE)
GUICtrlSetFont($btnIngame2, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnIngame2, "0x1E648C")
GUICtrlSetCursor($btnIngame2, 0)

$lblIngame2 = GUICtrlCreateLabel("Ingame Ability key (Default: SPACEBAR)", 150, 135, 490, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblIngame2, 768 + 8)
GUICtrlSetColor($lblIngame2, $COLOR_WHITE)
GUICtrlSetFont($lblIngame2, 11.5, "", "", "Segoe UI")

;TELL
$btnIngame3 = GUICtrlCreateLabel("<KEY>", 40, 190, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnIngame3, 768 + 8)
GUICtrlSetColor($btnIngame3, $COLOR_WHITE)
GUICtrlSetFont($btnIngame3, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnIngame3, "0x1E648C")
GUICtrlSetCursor($btnIngame3, 0)

$lblIngame3 = GUICtrlCreateLabel("Ingame Tell key (Default: TAB)", 150, 195, 490, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblIngame3, 768 + 8)
GUICtrlSetColor($lblIngame3, $COLOR_WHITE)
GUICtrlSetFont($lblIngame3, 11.5, "", "", "Segoe UI")

;COMMAND SYMBOL
$inputCommandSymbol = GUICtrlCreateInput("<smybol>", 40, 250, 100, 30)
GUICtrlSetResizing($inputCommandSymbol, 768 + 8)
GUICtrlSetColor($inputCommandSymbol, $COLOR_WHITE)
GUICtrlSetBkColor($inputCommandSymbol, $COLOR_BLACK)
GUICtrlSetFont($inputCommandSymbol, 11.5, "", "", "Segoe UI")
GUICtrlSetCursor($inputCommandSymbol, 5)

$lblIngame4 = GUICtrlCreateLabel("Command Symbol (Default: '/')", 150, 255, 490, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblIngame4, 768 + 8)
GUICtrlSetColor($lblIngame4, $COLOR_WHITE)
GUICtrlSetFont($lblIngame4, 11.5, "", "", "Segoe UI")

#EndRegion IngameKeys


#Region Others
;Play with Kongregate Toggle
$tgbKongregate = _Metro_CreateToggle("Play with Kongregate", 40, 70, 250, 30)
GUICtrlSetResizing($tgbKongregate, 768 + 8)

;Kongregate Parameters Input
$lblsKongregateParameters = GUICtrlCreateLabel("Kongregate Parameters:", 40, 110, 160, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblsKongregateParameters, 768 + 8)
GUICtrlSetColor($lblsKongregateParameters, $COLOR_WHITE)
GUICtrlSetFont($lblsKongregateParameters, 11.5, "", "", "Segoe UI")

$inputsKongregateParameters = GUICtrlCreateInput("?params", 210, 105, 465, 30)
GUICtrlSetResizing($inputsKongregateParameters, 768 + 8)
GUICtrlSetColor($inputsKongregateParameters, $COLOR_WHITE)
GUICtrlSetBkColor($inputsKongregateParameters, $COLOR_BLACK)
GUICtrlSetFont($inputsKongregateParameters, 11.5, "", "", "Segoe UI")
GUICtrlSetCursor($inputsKongregateParameters, 5)

;Kongregate help
$btnKongregateHelp = _Metro_CreateButton("?", 680, 105, 40, 30)
GUICtrlSetResizing($btnKongregateHelp, 768 + 8)

;Launch additional Program Toggle
$tgbAdditionalProgram = _Metro_CreateToggle("Launch an additional program when starting the game (Discord, Spotify, ...)", 40, 160, 600, 30)
GUICtrlSetResizing($tgbAdditionalProgram, 768 + 8)

$lblsAdditionalProgramPath = GUICtrlCreateLabel("C...", 120, 205, 600, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblsAdditionalProgramPath, 768 + 8)
GUICtrlSetColor($lblsAdditionalProgramPath, $COLOR_GRAY)
GUICtrlSetFont($lblsAdditionalProgramPath, 11.5, "", "", "Segoe UI")

$browsesAdditionalProgramPath = _Metro_CreateButton("Browse...", 40, 200, 70, 30)
GUICtrlSetResizing($browsesAdditionalProgramPath, 768 + 8)


;Flash directory
$lblAdvancedWarning = GUICtrlCreateLabel("Do NOT modify the settings below unless you know what you're doing.", 40, 280, 600, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblAdvancedWarning, 768 + 8)
GUICtrlSetColor($lblAdvancedWarning, $COLOR_WHITE)
GUICtrlSetFont($lblAdvancedWarning, 11.5, "", "", "Segoe UI")

$lblFlashProjectorInfo = GUICtrlCreateLabel("Path for flash projector file:", 40, 325, 600, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblFlashProjectorInfo, 768 + 8)
GUICtrlSetColor($lblFlashProjectorInfo, $COLOR_WHITE)
GUICtrlSetFont($lblFlashProjectorInfo, 11.5, "", "", "Segoe UI")

$browsesFlashFile = _Metro_CreateButton("Browse...", 40, 350, 70, 30)
GUICtrlSetResizing($browsesFlashFile, 768 + 8)

$lblsFlashFile = GUICtrlCreateLabel("C...", 120, 355, 600, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblsFlashFile, 768 + 8)
GUICtrlSetColor($lblsFlashFile, $COLOR_GRAY)
GUICtrlSetFont($lblsFlashFile, 11.5, "", "", "Segoe UI")

;(Testing / AGC)
$tgbTesting = _Metro_CreateToggle("Connect to testing", 40, 400, 600, 30)
GUICtrlSetResizing($tgbTesting, 768 + 8)

$tgbAGCLoader = _Metro_CreateToggle("Use AGCLoader instead of AssembleeGameClient", 40, 440, 600, 30)
GUICtrlSetResizing($tgbAGCLoader, 768 + 8)

; Key redirect
$lblKeyRedirect = GUICtrlCreateLabel("Key redirects (bind ingame actions to your mouse)", 40, 490, 600, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblKeyRedirect, 768 + 8)
GUICtrlSetColor($lblKeyRedirect, $COLOR_WHITE)
GUICtrlSetFont($lblKeyRedirect, 11.5, "", "", "Segoe UI")


;redirect1
$tgRedirect1 = _Metro_CreateToggle("", 40, 530, 60, 30)
GUICtrlSetResizing($tgRedirect1, 768 + 8)

$btnRedirectHotkey1 = GUICtrlCreateLabel("<KEY>", 120, 530, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnRedirectHotkey1, 768 + 8)
GUICtrlSetColor($btnRedirectHotkey1, $COLOR_WHITE)
GUICtrlSetFont($btnRedirectHotkey1, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnRedirectHotkey1, "0x1E648C")
GUICtrlSetCursor($btnRedirectHotkey1, 0)


$lblRedirect1 = GUICtrlCreateLabel("will press the ingame key: ", 230, 535, 170, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblRedirect1, 768 + 8)
GUICtrlSetColor($lblRedirect1, $COLOR_WHITE)
GUICtrlSetFont($lblRedirect1, 11.5, "", "", "Segoe UI")

$btnRedirectGamekey1 = GUICtrlCreateLabel("<KEY>", 420, 530, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnRedirectGamekey1, 768 + 8)
GUICtrlSetColor($btnRedirectGamekey1, $COLOR_WHITE)
GUICtrlSetFont($btnRedirectGamekey1, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnRedirectGamekey1, "0x1E648C")
GUICtrlSetCursor($btnRedirectGamekey1, 0)


;redirec2
$tgRedirect2 = _Metro_CreateToggle("", 40, 570, 60, 30)
GUICtrlSetResizing($tgRedirect2, 768 + 8)

$btnRedirectHotkey2 = GUICtrlCreateLabel("<KEY>", 120, 570, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnRedirectHotkey2, 768 + 8)
GUICtrlSetColor($btnRedirectHotkey2, $COLOR_WHITE)
GUICtrlSetFont($btnRedirectHotkey2, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnRedirectHotkey2, "0x1E648C")
GUICtrlSetCursor($btnRedirectHotkey2, 0)


$lblRedirect2 = GUICtrlCreateLabel("will press the ingame key: ", 230, 575, 170, 30, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing($lblRedirect2, 768 + 8)
GUICtrlSetColor($lblRedirect2, $COLOR_WHITE)
GUICtrlSetFont($lblRedirect2, 11.5, "", "", "Segoe UI")

$btnRedirectGamekey2 = GUICtrlCreateLabel("<KEY>", 420, 570, 100, 30, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($btnRedirectGamekey2, 768 + 8)
GUICtrlSetColor($btnRedirectGamekey2, $COLOR_WHITE)
GUICtrlSetFont($btnRedirectGamekey2, 11.5, "", "", "Segoe UI Bold")
GUICtrlSetBkColor($btnRedirectGamekey2, "0x1E648C")
GUICtrlSetCursor($btnRedirectGamekey2, 0)



#EndRegion Others

$ESCinfo = GUICtrlCreateLabel("Press ESC to cancel.", 40, 650, 690, 40, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing($ESCinfo, 768 + 8)
GUICtrlSetColor($ESCinfo, $COLOR_WHITE)
GUICtrlSetFont($ESCinfo, 20, "", "", "Segoe UI Bold")
GUICtrlSetCursor($ESCinfo, -1)

Local $r = ""
Local $tmp = ""
Local $noexit
_InitializeSettings()

;remove fullscreen button function and stuff
$ControlBtnsAutoMode = False
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $GUI_CLOSE_BUTTON
			$noexit = _PrepareExit()
		Case $GUI_MAXIMIZE_BUTTON
		Case $GUI_MINIMIZE_BUTTON
			GUISetState(@SW_MINIMIZE, $Form1)
		Case $GUI_RESTORE_BUTTON
			GUISetState(@SW_RESTORE, $Form1)
		Case $GUI_MENU_BUTTON
			GUICtrlSetState($lblMenu, 32)

			;Create an Array containing menu button names
			Local $MenuButtonsArray[12] = ["General", "Macros", "Hotkeys", "Ingame Keys", "Others", "", "Save & Exit", "Exit", "", "", "", "Reset settings"]
			; Open the metro Menu. See decleration of $MenuButtonsArray above.
			Local $MenuSelect = _Metro_MenuStart($Form1, 150, $MenuButtonsArray)
			Switch $MenuSelect ;Above function returns the index number of the selected button from the provided buttons array.
				Case "0"
					_HideAll()
					_ShowGeneral()
				Case "1"
					_HideAll()
					_ShowMacros()
				Case "2"
					_HideAll()
					_ShowHotkeys()
				Case "3"
					_HideAll()
					_ShowIngame()
				Case "4"
					_HideAll()
					_ShowOthers()
				Case "6"
					_SaveExit()
				Case "7"
					$noexit = _PrepareExit()
				Case "11"
					Local $doreset = MsgBox(52, "Reset settings", "Are you sure you want to reset all settings? This action can't be undone.")
					If $doreset = 6 Then
						_ResetSettings()
						_InitializeSettings()
					EndIf
			EndSwitch

			#Region GENERALactions
		Case $tgUseMacros
			If _Metro_ToggleIsChecked($tgUseMacros) Then
				_Metro_ToggleUnCheck($tgUseMacros)
			Else
				_Metro_ToggleCheck($tgUseMacros)
			EndIf

		Case $tgUseHotkeys
			If _Metro_ToggleIsChecked($tgUseHotkeys) Then
				_Metro_ToggleUnCheck($tgUseHotkeys)
			Else
				_Metro_ToggleCheck($tgUseHotkeys)
			EndIf

		Case $tgUseCustomCursor
			If _Metro_ToggleIsChecked($tgUseCustomCursor) Then
				_Metro_ToggleUnCheck($tgUseCustomCursor)
				_Metro_DisableButton($browseCustomCursorPath)
			Else
				_Metro_ToggleCheck($tgUseCustomCursor)
				_Metro_EnableButton($browseCustomCursorPath)
			EndIf
		Case $browseCustomCursorPath
			_GUIDisable($Form1, 0, 30)
			$r = FileOpenDialog("Choose cursor file", @ScriptDir & "\data\cursors", "Cursors (*.cur;*.ani) | All FIles (*.*)", 0, "", $Form1)
			If $r <> "" Then
				GUICtrlSetData($lblCustomCursorPath, $r)
			EndIf
			_GUIDisable($Form1, 0, 30)


		Case $tgForceFocus
			If _Metro_ToggleIsChecked($tgForceFocus) Then
				_Metro_ToggleUnCheck($tgForceFocus)
			Else
				_Metro_ToggleCheck($tgForceFocus)
			EndIf
			;MACROS
			;MACRO 1
		Case $tgMacro1
			If _Metro_ToggleIsChecked($tgMacro1) Then
				_Metro_ToggleUnCheck($tgMacro1)
				GUICtrlSetState($btnMacro1, 128)
				GUICtrlSetBkColor($btnMacro1, "0x123c54")
				GUICtrlSetState($inputMacro1, 128)
			Else
				_Metro_ToggleCheck($tgMacro1)
				GUICtrlSetState($btnMacro1, 64)
				GUICtrlSetBkColor($btnMacro1, "0x1E648C")
				GUICtrlSetState($inputMacro1, 64)
			EndIf
		Case $btnMacro1
			$tmp = GUICtrlRead($btnMacro1)
			GUICtrlSetData($btnMacro1, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnMacro1, $result[2])
			Else
				GUICtrlSetData($btnMacro1, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)






			;MACRO 2
		Case $tgMacro2
			If _Metro_ToggleIsChecked($tgMacro2) Then
				_Metro_ToggleUnCheck($tgMacro2)
				GUICtrlSetState($btnMacro2, 128)
				GUICtrlSetBkColor($btnMacro2, "0x123c54")
				GUICtrlSetState($inputMacro2, 128)
			Else
				_Metro_ToggleCheck($tgMacro2)
				GUICtrlSetState($btnMacro2, 64)
				GUICtrlSetBkColor($btnMacro2, "0x1E648C")
				GUICtrlSetState($inputMacro2, 64)
			EndIf
		Case $btnMacro2
			$tmp = GUICtrlRead($btnMacro2)
			GUICtrlSetData($btnMacro2, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnMacro2, $result[2])
			Else
				GUICtrlSetData($btnMacro2, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)

			;MACRO 3
		Case $tgMacro3
			If _Metro_ToggleIsChecked($tgMacro3) Then
				_Metro_ToggleUnCheck($tgMacro3)
				GUICtrlSetState($btnMacro3, 128)
				GUICtrlSetBkColor($btnMacro3, "0x123c54")
				GUICtrlSetState($inputMacro3, 128)
			Else
				_Metro_ToggleCheck($tgMacro3)
				GUICtrlSetState($btnMacro3, 64)
				GUICtrlSetBkColor($btnMacro3, "0x1E648C")
				GUICtrlSetState($inputMacro3, 64)
			EndIf
		Case $btnMacro3
			$tmp = GUICtrlRead($btnMacro3)
			GUICtrlSetData($btnMacro3, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnMacro3, $result[2])
			Else
				GUICtrlSetData($btnMacro3, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)

			;MACRO 4
		Case $tgMacro4
			If _Metro_ToggleIsChecked($tgMacro4) Then
				_Metro_ToggleUnCheck($tgMacro4)
				GUICtrlSetState($btnMacro4, 128)
				GUICtrlSetBkColor($btnMacro4, "0x123c54")
				GUICtrlSetState($inputMacro4, 128)
			Else
				_Metro_ToggleCheck($tgMacro4)
				GUICtrlSetState($btnMacro4, 64)
				GUICtrlSetBkColor($btnMacro4, "0x1E648C")
				GUICtrlSetState($inputMacro4, 64)
			EndIf
		Case $btnMacro4
			$tmp = GUICtrlRead($btnMacro4)
			GUICtrlSetData($btnMacro4, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnMacro4, $result[2])
			Else
				GUICtrlSetData($btnMacro4, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)
			;HOTKEYS

			;Hotkey 1
		Case $tgHotkey1
			If _Metro_ToggleIsChecked($tgHotkey1) Then
				_Metro_ToggleUnCheck($tgHotkey1)
				GUICtrlSetState($btnHotkey1, 128)
				GUICtrlSetBkColor($btnHotkey1, "0x123c54")
			Else
				_Metro_ToggleCheck($tgHotkey1)
				GUICtrlSetState($btnHotkey1, 64)
				GUICtrlSetBkColor($btnHotkey1, "0x1E648C")
			EndIf
		Case $btnHotkey1
			$tmp = GUICtrlRead($btnHotkey1)
			GUICtrlSetData($btnHotkey1, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnHotkey1, $result[2])
			Else
				GUICtrlSetData($btnHotkey1, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)

			;Hotkey 2
		Case $tgHotkey2
			If _Metro_ToggleIsChecked($tgHotkey2) Then
				_Metro_ToggleUnCheck($tgHotkey2)
				ConsoleWrite("Toggle $tgHotkey2 unchecked!" & @CRLF)
				GUICtrlSetState($btnHotkey2, 128)
				GUICtrlSetBkColor($btnHotkey2, "0x123c54")
			Else
				_Metro_ToggleCheck($tgHotkey2)
				ConsoleWrite("Toggle $tgHotkey2 checked!" & @CRLF)
				GUICtrlSetState($btnHotkey2, 64)
				GUICtrlSetBkColor($btnHotkey2, "0x1E648C")
			EndIf
		Case $btnHotkey2
			$tmp = GUICtrlRead($btnHotkey2)
			GUICtrlSetData($btnHotkey2, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnHotkey2, $result[2])
			Else
				GUICtrlSetData($btnHotkey2, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)


			;Hotkey 3
		Case $tgHotkey3
			If _Metro_ToggleIsChecked($tgHotkey3) Then
				_Metro_ToggleUnCheck($tgHotkey3)
				ConsoleWrite("Toggle $tgHotkey3 unchecked!" & @CRLF)
				GUICtrlSetState($btnHotkey3, 128)
				GUICtrlSetBkColor($btnHotkey3, "0x123c54")
				GUICtrlSetState($tgIncludeCursor, 128)
			Else
				_Metro_ToggleCheck($tgHotkey3)
				ConsoleWrite("Toggle $tgHotkey3 checked!" & @CRLF)
				GUICtrlSetState($btnHotkey3, 64)
				GUICtrlSetBkColor($btnHotkey3, "0x1E648C")
				GUICtrlSetState($tgIncludeCursor, 64)
			EndIf
		Case $btnHotkey3
			$tmp = GUICtrlRead($btnHotkey3)
			GUICtrlSetData($btnHotkey3, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnHotkey3, $result[2])
			Else
				GUICtrlSetData($btnHotkey3, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)
			;Hotkey3+
		Case $tgIncludeCursor
			If _Metro_ToggleIsChecked($tgIncludeCursor) Then
				_Metro_ToggleUnCheck($tgIncludeCursor)
				ConsoleWrite("Toggle $tgIncludeCursor unchecked!" & @CRLF)
			Else
				_Metro_ToggleCheck($tgIncludeCursor)
				ConsoleWrite("Toggle $tgIncludeCursor checked!" & @CRLF)
			EndIf

			;Hotkey4,5
		Case $tgEnableAnchor
			If _Metro_ToggleIsChecked($tgEnableAnchor) Then
				_Metro_ToggleUnCheck($tgEnableAnchor)
				ConsoleWrite("Toggle $tgEnableAnchor unchecked!" & @CRLF)
				GUICtrlSetState($btnHotkey4, 128)
				GUICtrlSetBkColor($btnHotkey4, "0x123c54")
				GUICtrlSetState($btnHotkey5, 128)
				GUICtrlSetBkColor($btnHotkey5, "0x123c54")
				GUICtrlSetState($inputDefaultAnchor, 128)
			Else
				_Metro_ToggleCheck($tgEnableAnchor)
				ConsoleWrite("Toggle $tgEnableAnchor checked!" & @CRLF)
				GUICtrlSetState($btnHotkey4, 64)
				GUICtrlSetBkColor($btnHotkey4, "0x1E648C")
				GUICtrlSetState($btnHotkey5, 64)
				GUICtrlSetBkColor($btnHotkey5, "0x1E648C")
				GUICtrlSetState($inputDefaultAnchor, 64)
			EndIf
		Case $btnHotkey4
			$tmp = GUICtrlRead($btnHotkey4)
			GUICtrlSetData($btnHotkey4, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnHotkey4, $result[2])
			Else
				GUICtrlSetData($btnHotkey4, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)

		Case $btnHotkey5
			$tmp = GUICtrlRead($btnHotkey5)
			GUICtrlSetData($btnHotkey5, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnHotkey5, $result[2])
			Else
				GUICtrlSetData($btnHotkey5, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)


			;Hotkey 6
		Case $tgHotkey6
			If _Metro_ToggleIsChecked($tgHotkey6) Then
				_Metro_ToggleUnCheck($tgHotkey6)
				ConsoleWrite("Toggle $tgHotkey6 unchecked!" & @CRLF)
				GUICtrlSetState($btnHotkey6, 128)
				GUICtrlSetBkColor($btnHotkey6, "0x123c54")
			Else
				_Metro_ToggleCheck($tgHotkey6)
				ConsoleWrite("Toggle $tgHotkey6 checked!" & @CRLF)
				GUICtrlSetState($btnHotkey6, 64)
				GUICtrlSetBkColor($btnHotkey6, "0x1E648C")
			EndIf
		Case $btnHotkey6
			$tmp = GUICtrlRead($btnHotkey6)
			GUICtrlSetData($btnHotkey6, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnHotkey6, $result[2])
			Else
				GUICtrlSetData($btnHotkey6, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)

			;Hotkey 7
		Case $tgHotkey7
			If _Metro_ToggleIsChecked($tgHotkey7) Then
				_Metro_ToggleUnCheck($tgHotkey7)
				ConsoleWrite("Toggle $tgHotkey7 unchecked!" & @CRLF)
				GUICtrlSetState($btnHotkey7, 128)
				GUICtrlSetBkColor($btnHotkey7, "0x123c54")
			Else
				_Metro_ToggleCheck($tgHotkey7)
				ConsoleWrite("Toggle $tgHotkey6 checked!" & @CRLF)
				GUICtrlSetState($btnHotkey7, 64)
				GUICtrlSetBkColor($btnHotkey7, "0x1E648C")
			EndIf
		Case $btnHotkey7
			$tmp = GUICtrlRead($btnHotkey7)
			GUICtrlSetData($btnHotkey7, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnHotkey7, $result[2])
			Else
				GUICtrlSetData($btnHotkey7, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)

			;Hotkey 8
		Case $tgHotkey8
			If _Metro_ToggleIsChecked($tgHotkey8) Then
				_Metro_ToggleUnCheck($tgHotkey8)
				ConsoleWrite("Toggle $tgHotkey8 unchecked!" & @CRLF)
				GUICtrlSetState($btnHotkey8, 128)
				GUICtrlSetBkColor($btnHotkey8, "0x123c54")
			Else
				_Metro_ToggleCheck($tgHotkey8)
				ConsoleWrite("Toggle $tgHotkey8 checked!" & @CRLF)
				GUICtrlSetState($btnHotkey8, 64)
				GUICtrlSetBkColor($btnHotkey8, "0x1E648C")
			EndIf
		Case $btnHotkey8
			$tmp = GUICtrlRead($btnHotkey8)
			GUICtrlSetData($btnHotkey8, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnHotkey8, $result[2])
			Else
				GUICtrlSetData($btnHotkey8, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)

			#EndRegion GENERALactions

			#Region Ingame
			;CHAT
		Case $btnIngame1
			$tmp = GUICtrlRead($btnIngame1)
			GUICtrlSetData($btnIngame1, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnIngame1, $result[2])
			Else
				GUICtrlSetData($btnIngame1, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)
			;ABILITY
		Case $btnIngame2
			$tmp = GUICtrlRead($btnIngame2)
			GUICtrlSetData($btnIngame2, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnIngame2, $result[2])
			Else
				GUICtrlSetData($btnIngame2, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)
			;TELL
		Case $btnIngame3
			$tmp = GUICtrlRead($btnIngame3)
			GUICtrlSetData($btnIngame3, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnIngame3, $result[2])
			Else
				GUICtrlSetData($btnIngame3, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)
			#EndRegion Ingame

			#Region Others
		Case $tgbKongregate
			If _Metro_ToggleIsChecked($tgbKongregate) Then
				_Metro_ToggleUnCheck($tgbKongregate)
				ConsoleWrite("Toggle $tgbKongregate unchecked!" & @CRLF)
				GUICtrlSetState($inputsKongregateParameters, 128)
			Else
				_Metro_ToggleCheck($tgbKongregate)
				ConsoleWrite("Toggle $tgbKongregate checked!" & @CRLF)
				GUICtrlSetState($inputsKongregateParameters, 64)
			EndIf

		Case $btnKongregateHelp
			ShellExecute("https://github.com/GerRudi/SimpleR-RotMG/wiki/FAQ#how-to-play-with-my-kongregate-account")

		Case $tgbAdditionalProgram
			If _Metro_ToggleIsChecked($tgbAdditionalProgram) Then
				_Metro_ToggleUnCheck($tgbAdditionalProgram)
				ConsoleWrite("Toggle $tgbAdditionalProgram unchecked!" & @CRLF)
				_Metro_DisableButton($browsesAdditionalProgramPath)
			Else
				_Metro_ToggleCheck($tgbAdditionalProgram)
				ConsoleWrite("Toggle $tgbAdditionalProgram checked!" & @CRLF)
				_Metro_EnableButton($browsesAdditionalProgramPath)
			EndIf
		Case $browsesAdditionalProgramPath
			_GUIDisable($Form1, 0, 30)
			$r = FileOpenDialog("Choose Program", @ScriptDir, "All FIles (*.*)", 0, "", $Form1)
			If $r <> "" Then
				GUICtrlSetData($lblsAdditionalProgramPath, $r)
			EndIf
			_GUIDisable($Form1, 0, 30)


		Case $browsesFlashFile
			_GUIDisable($Form1, 0, 30)
			$r = FileOpenDialog("Choose Flash Projector file", @ScriptDir & "\data\", "Executables (*.exe) | All FIles (*.*)", 0, "", $Form1)
			If $r <> "" Then
				GUICtrlSetData($lblsFlashFile, $r)
			EndIf
			_GUIDisable($Form1, 0, 30)


		Case $tgbTesting
			If _Metro_ToggleIsChecked($tgbTesting) Then
				_Metro_ToggleUnCheck($tgbTesting)
			Else
				_Metro_ToggleCheck($tgbTesting)
			EndIf


		Case $tgbAGCLoader
			If _Metro_ToggleIsChecked($tgbAGCLoader) Then
				_Metro_ToggleUnCheck($tgbAGCLoader)
			Else
				_Metro_ToggleCheck($tgbAGCLoader)
			EndIf
			#EndRegion Others

		;Redirect 1

			Case $tgRedirect1
			If _Metro_ToggleIsChecked($tgRedirect1) Then
				_Metro_ToggleUnCheck($tgRedirect1)
				GUICtrlSetState($btnRedirectHotkey1, 128)
				GUICtrlSetBkColor($btnRedirectHotkey1, "0x123c54")
				GUICtrlSetState($btnRedirectGamekey1, 128)
				GUICtrlSetBkColor($btnRedirectGamekey1, "0x123c54")
			Else
				_Metro_ToggleCheck($tgRedirect1)
				GUICtrlSetState($btnRedirectHotkey1, 64)
				GUICtrlSetBkColor($btnRedirectHotkey1, "0x1E648C")
				GUICtrlSetState($btnRedirectGamekey1, 64)
				GUICtrlSetBkColor($btnRedirectGamekey1, "0x1E648C")
			EndIf

		Case $btnRedirectHotkey1
			$tmp = GUICtrlRead($btnRedirectHotkey1)
			GUICtrlSetData($btnRedirectHotkey1, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnRedirectHotkey1, $result[2])
			Else
				GUICtrlSetData($btnRedirectHotkey1, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)

		Case $btnRedirectGamekey1
			$tmp = GUICtrlRead($btnRedirectGamekey1)
			GUICtrlSetData($btnRedirectGamekey1, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnRedirectGamekey1, $result[2])
			Else
				GUICtrlSetData($btnRedirectGamekey1, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)

		;Redirect 2
			Case $tgRedirect2
			If _Metro_ToggleIsChecked($tgRedirect2) Then
				_Metro_ToggleUnCheck($tgRedirect2)
				GUICtrlSetState($btnRedirectHotkey2, 128)
				GUICtrlSetBkColor($btnRedirectHotkey2, "0x123c54")
				GUICtrlSetState($btnRedirectGamekey2, 128)
				GUICtrlSetBkColor($btnRedirectGamekey2, "0x123c54")
			Else
				_Metro_ToggleCheck($tgRedirect2)
				GUICtrlSetState($btnRedirectHotkey2, 64)
				GUICtrlSetBkColor($btnRedirectHotkey2, "0x1E648C")
				GUICtrlSetState($btnRedirectGamekey2, 64)
				GUICtrlSetBkColor($btnRedirectGamekey2, "0x1E648C")
			EndIf

		Case $btnRedirectHotkey2
			$tmp = GUICtrlRead($btnRedirectHotkey2)
			GUICtrlSetData($btnRedirectHotkey2, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnRedirectHotkey2, $result[2])
			Else
				GUICtrlSetData($btnRedirectHotkey2, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)

		Case $btnRedirectGamekey2
			$tmp = GUICtrlRead($btnRedirectGamekey2)
			GUICtrlSetData($btnRedirectGamekey2, "PRESS KEY")
			_GUIDisable($Form1, 0, 30)
			$result = GetKeyInput()
			If Not @error Then
				GUICtrlSetData($btnRedirectGamekey2, $result[2])
			Else
				GUICtrlSetData($btnRedirectGamekey2, $tmp)
			EndIf
			_GUIDisable($Form1, 0, 30)

	EndSwitch
WEnd


Func _InitializeSettings()
	$savedGeneral = GetGeneral()
	$savedPaths = GetPaths()
	$savedMacros = GetMacros()
	$savedIngame = GetIngame()
	$savedHotkeys = GetHotkeys()
	$savedRedirects = GetRedirects()

	$newGeneral = $savedGeneral
	$newPaths = $savedPaths
	$newMacros = $savedMacros
	$newIngame = $savedIngame
	$newHotkeys = $savedHotkeys
	$newRedirects = $savedRedirects

	_SetGeneral()
	_SetOthers()
	_SetMacros()
	_SetIngame()
	_SetHotkeys()

	_HideAll()
	_ShowGeneral()
EndFunc   ;==>_InitializeSettings


Func _SetGeneral()

	;Use Macros
	If $savedGeneral[$bMacros][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgUseMacros)
	Else
		_Metro_ToggleUnCheck($tgUseMacros)
	EndIf

	;Use Hotkeys
	If $savedGeneral[$bHotkeys][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgUseHotkeys)
	Else
		_Metro_ToggleUnCheck($tgUseHotkeys)
	EndIf

	;Use Custom cursor
	If $savedGeneral[$bCustomCursor][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgUseCustomCursor)
		_Metro_EnableButton($browseCustomCursorPath)
	Else
		_Metro_ToggleUnCheck($tgUseCustomCursor)
		_Metro_DisableButton($browseCustomCursorPath)
	EndIf

	;Browse Cursor Path
	GUICtrlSetData($lblCustomCursorPath, $savedPaths[$sCustomCursorPath][$cAIcontent])

	;Force game focus
	If $savedGeneral[$bKeepWindowFocused][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgForceFocus)
	Else
		_Metro_ToggleUnCheck($tgForceFocus)
	EndIf

	;Game Window name
	GUICtrlSetData($inputGameName, $savedGeneral[$sWindowName][$cAIcontent])

EndFunc   ;==>_SetGeneral

Func _SetOthers()

	;Use Kongregate
	If $savedGeneral[$bKongregate][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgbKongregate)
		GUICtrlSetState($inputsKongregateParameters, 64)
	Else
		_Metro_ToggleUnCheck($tgbKongregate)
		GUICtrlSetState($inputsKongregateParameters, 128)
	EndIf
	GUICtrlSetData($inputsKongregateParameters, $savedGeneral[$sKongregateParameters][$cAIcontent])

	;Launch additional program
	If $savedGeneral[$bLaunchAdditionalProgram][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgbAdditionalProgram)
		GUICtrlSetState($browsesAdditionalProgramPath, 64)
	Else
		_Metro_ToggleUnCheck($tgbAdditionalProgram)
		GUICtrlSetState($browsesAdditionalProgramPath, 128)
	EndIf
	GUICtrlSetData($lblsAdditionalProgramPath, $savedGeneral[$sAdditionalProgramPath][$cAIcontent])
	GUICtrlSetData($lblsFlashFile, $savedPaths[$sFlashFile][$cAIcontent])

	;Testing, AGC
	If $savedGeneral[$bTesting][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgbTesting)
	Else
		_Metro_ToggleUnCheck($tgbTesting)
	EndIf

	If $savedGeneral[$bAGCLoader][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgbAGCLoader)
	Else
		_Metro_ToggleUnCheck($tgbAGCLoader)
	EndIf


	;Redirect 1
	If $savedRedirects[$credirect1][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgRedirect1)
		GUICtrlSetState($btnRedirectGamekey1, 64)
		GUICtrlSetBkColor($btnRedirectGamekey1, "0x1E648C")
		GUICtrlSetState($btnRedirectHotkey1, 64)
		GUICtrlSetBkColor($btnRedirectHotkey1, "0x1E648C")
	Else
		_Metro_ToggleUnCheck($tgRedirect1)
		GUICtrlSetState($btnRedirectGamekey1, 128)
		GUICtrlSetBkColor($btnRedirectGamekey1, "0x123c54")
		GUICtrlSetState($btnRedirectHotkey1, 128)
		GUICtrlSetBkColor($btnRedirectHotkey1, "0x123c54")
	EndIf
	GUICtrlSetData($btnRedirectGamekey1, $savedRedirects[$credirect1][$cAIRedirect])
	GUICtrlSetData($btnRedirectHotkey1, $savedRedirects[$credirect1][$cAIKey])

	;Redirect 2
	If $savedRedirects[$credirect2][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgRedirect2)
		GUICtrlSetState($btnRedirectGamekey2, 64)
		GUICtrlSetBkColor($btnRedirectGamekey2, "0x1E648C")
		GUICtrlSetState($btnRedirectHotkey2, 64)
		GUICtrlSetBkColor($btnRedirectHotkey2, "0x1E648C")
	Else
		_Metro_ToggleUnCheck($tgRedirect2)
		GUICtrlSetState($btnRedirectGamekey2, 128)
		GUICtrlSetBkColor($btnRedirectGamekey2, "0x123c54")
		GUICtrlSetState($btnRedirectHotkey2, 128)
		GUICtrlSetBkColor($btnRedirectHotkey2, "0x123c54")
	EndIf
	GUICtrlSetData($btnRedirectGamekey2, $savedRedirects[$credirect2][$cAIRedirect])
	GUICtrlSetData($btnRedirectHotkey2, $savedRedirects[$credirect2][$cAIKey])
EndFunc   ;==>_SetOthers




Func _SetMacros()

	;Macro 1
	If $savedMacros[$cmacro1][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgMacro1)
		GUICtrlSetState($btnMacro1, 64)
		GUICtrlSetBkColor($btnMacro1, "0x1E648C")
		GUICtrlSetState($inputMacro1, 64)
	Else
		_Metro_ToggleUnCheck($tgMacro1)
		GUICtrlSetState($btnMacro1, 128)
		GUICtrlSetBkColor($btnMacro1, "0x123c54")
		GUICtrlSetState($inputMacro1, 128)
	EndIf
	GUICtrlSetData($btnMacro1, $savedMacros[$cmacro1][$cAIKey])
	GUICtrlSetData($inputMacro1, $savedMacros[$cmacro1][$cAImacrotext])

	;Macro 2
	If $savedMacros[$cmacro2][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgMacro2)
		GUICtrlSetState($btnMacro2, 64)
		GUICtrlSetBkColor($btnMacro2, "0x1E648C")
		GUICtrlSetState($inputMacro2, 64)
	Else
		_Metro_ToggleUnCheck($tgMacro2)
		GUICtrlSetState($btnMacro2, 128)
		GUICtrlSetBkColor($btnMacro2, "0x123c54")
		GUICtrlSetState($inputMacro2, 128)
	EndIf
	GUICtrlSetData($btnMacro2, $savedMacros[$cmacro2][$cAIKey])
	GUICtrlSetData($inputMacro2, $savedMacros[$cmacro2][$cAImacrotext])

	;Macro 3
	If $savedMacros[$cmacro3][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgMacro3)
		GUICtrlSetState($btnMacro3, 64)
		GUICtrlSetBkColor($btnMacro3, "0x1E648C")
		GUICtrlSetState($inputMacro3, 64)
	Else
		_Metro_ToggleUnCheck($tgMacro3)
		GUICtrlSetState($btnMacro3, 128)
		GUICtrlSetBkColor($btnMacro3, "0x123c54")
		GUICtrlSetState($inputMacro3, 128)
	EndIf
	GUICtrlSetData($btnMacro3, $savedMacros[$cmacro3][$cAIKey])
	GUICtrlSetData($inputMacro3, $savedMacros[$cmacro3][$cAImacrotext])

	;Macro 4
	If $savedMacros[$cmacro4][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgMacro4)
		GUICtrlSetState($btnMacro4, 64)
		GUICtrlSetBkColor($btnMacro4, "0x1E648C")
		GUICtrlSetState($inputMacro4, 64)
	Else
		_Metro_ToggleUnCheck($tgMacro4)
		GUICtrlSetState($btnMacro4, 128)
		GUICtrlSetBkColor($btnMacro4, "0x123c54")
		GUICtrlSetState($inputMacro4, 128)
	EndIf
	GUICtrlSetData($btnMacro4, $savedMacros[$cmacro4][$cAIKey])
	GUICtrlSetData($inputMacro4, $savedMacros[$cmacro4][$cAImacrotext])

EndFunc   ;==>_SetMacros

Func _SetIngame()

	GUICtrlSetData($btnIngame1, $savedIngame[$igChat][$cAIKey])
	GUICtrlSetData($btnIngame2, $savedIngame[$igAbility][$cAIKey])
	GUICtrlSetData($btnIngame3, $savedIngame[$igTell][$cAIKey])
	GUICtrlSetData($inputCommandSymbol, $savedIngame[$igCommand][$cAIKey])

EndFunc   ;==>_SetIngame

Func _SetHotkeys()
	;Hotkeys 1
	If $savedHotkeys[$hkResetSize][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgHotkey1)
		GUICtrlSetState($btnHotkey1, 64)
		GUICtrlSetBkColor($btnHotkey1, "0x1E648C")
	Else
		_Metro_ToggleUnCheck($tgHotkey1)
		GUICtrlSetState($btnHotkey1, 128)
		GUICtrlSetBkColor($btnHotkey1, "0x123c54")
	EndIf
	GUICtrlSetData($btnHotkey1, $savedHotkeys[$hkResetSize][$cAIKey])

	;Hotkeys 2
	If $savedHotkeys[$hk43Maximize][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgHotkey2)
		GUICtrlSetState($btnHotkey2, 64)
		GUICtrlSetBkColor($btnHotkey2, "0x1E648C")
	Else
		_Metro_ToggleUnCheck($tgHotkey2)
		GUICtrlSetState($btnHotkey2, 128)
		GUICtrlSetBkColor($btnHotkey2, "0x123c54")
	EndIf
	GUICtrlSetData($btnHotkey2, $savedHotkeys[$hk43Maximize][$cAIKey])

	;Hotkeys 3
	If $savedHotkeys[$hkScreenshot][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgHotkey3)
		GUICtrlSetState($btnHotkey3, 64)
		GUICtrlSetBkColor($btnHotkey3, "0x1E648C")
		GUICtrlSetState($tgIncludeCursor, 64)
	Else
		_Metro_ToggleUnCheck($tgHotkey3)
		GUICtrlSetState($btnHotkey3, 128)
		GUICtrlSetBkColor($btnHotkey3, "0x123c54")
		GUICtrlSetState($tgIncludeCursor, 128)
	EndIf
	GUICtrlSetData($btnHotkey3, $savedHotkeys[$hkScreenshot][$cAIKey])

	;Hotkeys 3+
	If $savedGeneral[$bCursorOnScreenshot][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgIncludeCursor)
	Else
		_Metro_ToggleUnCheck($tgIncludeCursor)
	EndIf

	;Hotkeys 4,5
	If $savedGeneral[$bAnchor][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgEnableAnchor)
		GUICtrlSetState($btnHotkey4, 64)
		GUICtrlSetState($btnHotkey5, 64)
		GUICtrlSetState($inputDefaultAnchor, 64)
		GUICtrlSetBkColor($btnHotkey4, "0x1E648C")
		GUICtrlSetBkColor($btnHotkey5, "0x1E648C")
	Else
		_Metro_ToggleUnCheck($tgEnableAnchor)
		GUICtrlSetState($btnHotkey4, 128)
		GUICtrlSetState($btnHotkey5, 128)
		GUICtrlSetState($inputDefaultAnchor, 128)
		GUICtrlSetBkColor($btnHotkey4, "0x123c54")
		GUICtrlSetBkColor($btnHotkey5, "0x123c54")
	EndIf
	GUICtrlSetData($btnHotkey4, $savedHotkeys[$hkSetAnchor][$cAIKey])
	GUICtrlSetData($btnHotkey5, $savedHotkeys[$hkTPAnchor][$cAIKey])
	GUICtrlSetData($inputDefaultAnchor, $savedGeneral[$sDefaultAnchor][$cAIcontent])


	;Hotkeys 6
	If $savedHotkeys[$hkIgnorePM][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgHotkey6)
		GUICtrlSetState($btnHotkey6, 64)
		GUICtrlSetBkColor($btnHotkey6, "0x1E648C")
	Else
		_Metro_ToggleUnCheck($tgHotkey6)
		GUICtrlSetState($btnHotkey6, 128)
		GUICtrlSetBkColor($btnHotkey6, "0x123c54")
	EndIf
	GUICtrlSetData($btnHotkey6, $savedHotkeys[$hkIgnorePM][$cAIKey])

	;Hotkeys 7
	If $savedHotkeys[$hkToggleFocus][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgHotkey7)
		GUICtrlSetState($btnHotkey7, 64)
		GUICtrlSetBkColor($btnHotkey7, "0x1E648C")
	Else
		_Metro_ToggleUnCheck($tgHotkey7)
		GUICtrlSetState($btnHotkey7, 128)
		GUICtrlSetBkColor($btnHotkey7, "0x123c54")
	EndIf
	GUICtrlSetData($btnHotkey7, $savedHotkeys[$hkToggleFocus][$cAIKey])

	;Hotkeys 8
	If $savedHotkeys[$hkActualFullscreen][$cAIactive] = 1 Then
		_Metro_ToggleCheck($tgHotkey8)
		GUICtrlSetState($btnHotkey8, 64)
		GUICtrlSetBkColor($btnHotkey8, "0x1E648C")
	Else
		_Metro_ToggleUnCheck($tgHotkey8)
		GUICtrlSetState($btnHotkey8, 128)
		GUICtrlSetBkColor($btnHotkey8, "0x123c54")
	EndIf
	GUICtrlSetData($btnHotkey8, $savedHotkeys[$hkActualFullscreen][$cAIKey])

EndFunc   ;==>_SetHotkeys



Func _HideAll()
	GUICtrlSetState($tgUseMacros, 32)
	GUICtrlSetState($tgUseHotkeys, 32)
	GUICtrlSetState($tgUseCustomCursor, 32)
	GUICtrlSetState($lblCustomCursorPath, 32)
	GUICtrlSetState($browseCustomCursorPath, 32)
	GUICtrlSetState($tgForceFocus, 32)
	GUICtrlSetState($lblGameName, 32)
	GUICtrlSetState($inputGameName, 32)

	GUICtrlSetState($tgMacro1, 32)
	GUICtrlSetState($btnMacro1, 32)
	GUICtrlSetState($inputMacro1, 32)

	GUICtrlSetState($tgMacro2, 32)
	GUICtrlSetState($btnMacro2, 32)
	GUICtrlSetState($inputMacro2, 32)

	GUICtrlSetState($tgMacro3, 32)
	GUICtrlSetState($btnMacro3, 32)
	GUICtrlSetState($inputMacro3, 32)

	GUICtrlSetState($tgMacro4, 32)
	GUICtrlSetState($btnMacro4, 32)
	GUICtrlSetState($inputMacro4, 32)

	GUICtrlSetState($tgHotkey1, 32)
	GUICtrlSetState($btnHotkey1, 32)
	GUICtrlSetState($lblHotkey1, 32)

	GUICtrlSetState($tgHotkey2, 32)
	GUICtrlSetState($btnHotkey2, 32)
	GUICtrlSetState($lblHotkey2, 32)

	GUICtrlSetState($tgHotkey3, 32)
	GUICtrlSetState($btnHotkey3, 32)
	GUICtrlSetState($lblHotkey3, 32)

	GUICtrlSetState($tgIncludeCursor, 32)

	GUICtrlSetState($tgEnableAnchor, 32)
	GUICtrlSetState($btnHotkey4, 32)
	GUICtrlSetState($btnHotkey5, 32)
	GUICtrlSetState($inputDefaultAnchor, 32)
	GUICtrlSetState($lblDefaultAnchor, 32)
	GUICtrlSetState($lblHotkey4, 32)
	GUICtrlSetState($lblHotkey5, 32)

	GUICtrlSetState($tgHotkey6, 32)
	GUICtrlSetState($btnHotkey6, 32)
	GUICtrlSetState($lblHotkey6, 32)

	GUICtrlSetState($tgHotkey7, 32)
	GUICtrlSetState($btnHotkey7, 32)
	GUICtrlSetState($lblHotkey7, 32)

	GUICtrlSetState($tgHotkey8, 32)
	GUICtrlSetState($btnHotkey8, 32)
	GUICtrlSetState($lblHotkey8, 32)

	GUICtrlSetState($btnIngame1, 32)
	GUICtrlSetState($btnIngame2, 32)
	GUICtrlSetState($btnIngame3, 32)
	GUICtrlSetState($inputCommandSymbol, 32)
	GUICtrlSetState($lblIngame1, 32)
	GUICtrlSetState($lblIngame2, 32)
	GUICtrlSetState($lblIngame3, 32)
	GUICtrlSetState($lblIngame4, 32)






	GUICtrlSetState($tgbKongregate, 32)
	GUICtrlSetState($lblsKongregateParameters, 32)
	GUICtrlSetState($inputsKongregateParameters, 32)
	GUICtrlSetState($btnKongregateHelp, 32)
	GUICtrlSetState($tgbAdditionalProgram, 32)
	GUICtrlSetState($lblsAdditionalProgramPath, 32)
	GUICtrlSetState($browsesAdditionalProgramPath, 32)
	GUICtrlSetState($lblAdvancedWarning, 32)
	GUICtrlSetState($lblFlashProjectorInfo, 32)
	GUICtrlSetState($browsesFlashFile, 32)
	GUICtrlSetState($lblsFlashFile, 32)
	GUICtrlSetState($tgbTesting, 32)
	GUICtrlSetState($tgbAGCLoader, 32)

	GUICtrlSetState($lblKeyRedirect , 32)
	GUICtrlSetState($tgRedirect1  , 32)
	GUICtrlSetState($btnRedirectHotkey1  , 32)
	GUICtrlSetState($lblRedirect1  , 32)
	GUICtrlSetState($btnRedirectGamekey1  , 32)

	GUICtrlSetState($tgRedirect2  , 32)
	GUICtrlSetState($btnRedirectHotkey2  , 32)
	GUICtrlSetState($lblRedirect2  , 32)
	GUICtrlSetState($btnRedirectGamekey2  , 32)



	GUICtrlSetState($ESCinfo, 32)
EndFunc   ;==>_HideAll

Func _ShowGeneral()
	GUICtrlSetState($tgUseMacros, 16)
	GUICtrlSetState($tgUseHotkeys, 16)
	GUICtrlSetState($tgUseCustomCursor, 16)
	GUICtrlSetState($lblCustomCursorPath, 16)
	GUICtrlSetState($browseCustomCursorPath, 16)
	GUICtrlSetState($tgForceFocus, 16)
	GUICtrlSetState($lblGameName, 16)
	GUICtrlSetState($inputGameName, 16)
EndFunc   ;==>_ShowGeneral

Func _ShowMacros()
	GUICtrlSetState($tgMacro1, 16)
	GUICtrlSetState($btnMacro1, 16)
	GUICtrlSetState($inputMacro1, 16)

	GUICtrlSetState($tgMacro2, 16)
	GUICtrlSetState($btnMacro2, 16)
	GUICtrlSetState($inputMacro2, 16)

	GUICtrlSetState($tgMacro3, 16)
	GUICtrlSetState($btnMacro3, 16)
	GUICtrlSetState($inputMacro3, 16)

	GUICtrlSetState($tgMacro4, 16)
	GUICtrlSetState($btnMacro4, 16)
	GUICtrlSetState($inputMacro4, 16)

EndFunc   ;==>_ShowMacros

Func _ShowHotkeys()
	GUICtrlSetState($tgHotkey1, 16)
	GUICtrlSetState($btnHotkey1, 16)
	GUICtrlSetState($lblHotkey1, 16)

	GUICtrlSetState($tgHotkey2, 16)
	GUICtrlSetState($btnHotkey2, 16)
	GUICtrlSetState($lblHotkey2, 16)

	GUICtrlSetState($tgHotkey3, 16)
	GUICtrlSetState($btnHotkey3, 16)
	GUICtrlSetState($lblHotkey3, 16)

	GUICtrlSetState($tgIncludeCursor, 16)

	GUICtrlSetState($tgEnableAnchor, 16)
	GUICtrlSetState($btnHotkey4, 16)
	GUICtrlSetState($btnHotkey5, 16)
	GUICtrlSetState($inputDefaultAnchor, 16)
	GUICtrlSetState($lblDefaultAnchor, 16)
	GUICtrlSetState($lblHotkey4, 16)
	GUICtrlSetState($lblHotkey5, 16)

	GUICtrlSetState($tgHotkey6, 16)
	GUICtrlSetState($btnHotkey6, 16)
	GUICtrlSetState($lblHotkey6, 16)

	GUICtrlSetState($tgHotkey7, 16)
	GUICtrlSetState($btnHotkey7, 16)
	GUICtrlSetState($lblHotkey7, 16)

	GUICtrlSetState($tgHotkey8, 16)
	GUICtrlSetState($btnHotkey8, 16)
	GUICtrlSetState($lblHotkey8, 16)
EndFunc   ;==>_ShowHotkeys

Func _ShowIngame()

	GUICtrlSetState($btnIngame1, 16)
	GUICtrlSetState($btnIngame2, 16)
	GUICtrlSetState($btnIngame3, 16)
	GUICtrlSetState($inputCommandSymbol, 16)
	GUICtrlSetState($lblIngame1, 16)
	GUICtrlSetState($lblIngame2, 16)
	GUICtrlSetState($lblIngame3, 16)
	GUICtrlSetState($lblIngame4, 16)
EndFunc   ;==>_ShowIngame


Func _ShowOthers()
	GUICtrlSetState($tgbKongregate, 16)
	GUICtrlSetState($lblsKongregateParameters, 16)
	GUICtrlSetState($inputsKongregateParameters, 16)
	GUICtrlSetState($btnKongregateHelp, 16)
	GUICtrlSetState($tgbAdditionalProgram, 16)
	GUICtrlSetState($lblsAdditionalProgramPath, 16)
	GUICtrlSetState($browsesAdditionalProgramPath, 16)
	GUICtrlSetState($lblAdvancedWarning, 16)
	GUICtrlSetState($lblFlashProjectorInfo, 16)
	GUICtrlSetState($browsesFlashFile, 16)
	GUICtrlSetState($lblsFlashFile, 16)
	GUICtrlSetState($tgbTesting, 16)
	GUICtrlSetState($tgbAGCLoader, 16)
	GUICtrlSetState($lblKeyRedirect , 16)
	GUICtrlSetState($tgRedirect1  , 16)
	GUICtrlSetState($btnRedirectHotkey1  , 16)
	GUICtrlSetState($lblRedirect1  , 16)
	GUICtrlSetState($btnRedirectGamekey1  , 16)
	GUICtrlSetState($tgRedirect2  , 16)
	GUICtrlSetState($btnRedirectHotkey2  , 16)
	GUICtrlSetState($lblRedirect2  , 16)
	GUICtrlSetState($btnRedirectGamekey2  , 16)
EndFunc   ;==>_ShowOthers




Func _ReadGUI()
	#Region General
	If _Metro_ToggleIsChecked($tgUseMacros) Then
		$newGeneral[$bMacros][$cAIactive] = 1
	Else
		$newGeneral[$bMacros][$cAIactive] = 0
	EndIf

	If _Metro_ToggleIsChecked($tgUseHotkeys) Then
		$newGeneral[$bHotkeys][$cAIactive] = 1
	Else
		$newGeneral[$bHotkeys][$cAIactive] = 0
	EndIf

	If _Metro_ToggleIsChecked($tgUseCustomCursor) Then
		$newGeneral[$bCustomCursor][$cAIactive] = 1
	Else
		$newGeneral[$bCustomCursor][$cAIactive] = 0
	EndIf

	$newPaths[$sCustomCursorPath][$cAIcontent] = GUICtrlRead($lblCustomCursorPath)

	If _Metro_ToggleIsChecked($tgForceFocus) Then
		$newGeneral[$bKeepWindowFocused][$cAIactive] = 1
	Else
		$newGeneral[$bKeepWindowFocused][$cAIactive] = 0
	EndIf

	$newGeneral[$sWindowName][$cAIcontent] = GUICtrlRead($inputGameName)
	#EndRegion General

	#Region Macros
	;Macro 1
	If _Metro_ToggleIsChecked($tgMacro1) Then
		$newMacros[$cmacro1][$cAIactive] = 1
	Else
		$newMacros[$cmacro1][$cAIactive] = 0
	EndIf
	$newMacros[$cmacro1][$cAIKey] = GUICtrlRead($btnMacro1)
	$newMacros[$cmacro1][$cAImacrotext] = GUICtrlRead($inputMacro1)

	;Macro 2
	If _Metro_ToggleIsChecked($tgMacro2) Then
		$newMacros[$cmacro2][$cAIactive] = 1
	Else
		$newMacros[$cmacro2][$cAIactive] = 0
	EndIf
	$newMacros[$cmacro2][$cAIKey] = GUICtrlRead($btnMacro2)
	$newMacros[$cmacro2][$cAImacrotext] = GUICtrlRead($inputMacro2)

	;Macro 3
	If _Metro_ToggleIsChecked($tgMacro3) Then
		$newMacros[$cmacro3][$cAIactive] = 1
	Else
		$newMacros[$cmacro3][$cAIactive] = 0
	EndIf
	$newMacros[$cmacro3][$cAIKey] = GUICtrlRead($btnMacro3)
	$newMacros[$cmacro3][$cAImacrotext] = GUICtrlRead($inputMacro3)

	;Macro 4
	If _Metro_ToggleIsChecked($tgMacro4) Then
		$newMacros[$cmacro4][$cAIactive] = 1
	Else
		$newMacros[$cmacro4][$cAIactive] = 0
	EndIf
	$newMacros[$cmacro4][$cAIKey] = GUICtrlRead($btnMacro4)
	$newMacros[$cmacro4][$cAImacrotext] = GUICtrlRead($inputMacro4)
	#EndRegion Macros

	#Region Hotkeys
	;Hotkey 1
	If _Metro_ToggleIsChecked($tgHotkey1) Then
		$newHotkeys[$hkResetSize][$cAIactive] = 1
	Else
		$newHotkeys[$hkResetSize][$cAIactive] = 0
	EndIf
	$newHotkeys[$hkResetSize][$cAIKey] = GUICtrlRead($btnHotkey1)

	;Hotkey 2
	If _Metro_ToggleIsChecked($tgHotkey2) Then
		$newHotkeys[$hk43Maximize][$cAIactive] = 1
	Else
		$newHotkeys[$hk43Maximize][$cAIactive] = 0
	EndIf
	$newHotkeys[$hk43Maximize][$cAIKey] = GUICtrlRead($btnHotkey2)

	;Hotkey 3
	If _Metro_ToggleIsChecked($tgHotkey3) Then
		$newHotkeys[$hkScreenshot][$cAIactive] = 1
	Else
		$newHotkeys[$hkScreenshot][$cAIactive] = 0
	EndIf
	$newHotkeys[$hkScreenshot][$cAIKey] = GUICtrlRead($btnHotkey3)

	;Hotkey 3+
	If _Metro_ToggleIsChecked($tgIncludeCursor) Then
		$newGeneral[$bCursorOnScreenshot][$cAIactive] = 1
	Else
		$newGeneral[$bCursorOnScreenshot][$cAIactive] = 0
	EndIf

	;Hotkey 4,5
	If _Metro_ToggleIsChecked($tgEnableAnchor) Then
		$newGeneral[$bAnchor][$cAIactive] = 1
	Else
		$newGeneral[$bAnchor][$cAIactive] = 0
	EndIf
	$newHotkeys[$hkSetAnchor][$cAIKey] = GUICtrlRead($btnHotkey4)
	$newHotkeys[$hkTPAnchor][$cAIKey] = GUICtrlRead($btnHotkey5)
	$newGeneral[$sDefaultAnchor][$cAIcontent] = GUICtrlRead($inputDefaultAnchor)

	;Hotkey 6
	If _Metro_ToggleIsChecked($tgHotkey6) Then
		$newHotkeys[$hkIgnorePM][$cAIactive] = 1
	Else
		$newHotkeys[$hkIgnorePM][$cAIactive] = 0
	EndIf
	$newHotkeys[$hkIgnorePM][$cAIKey] = GUICtrlRead($btnHotkey6)

	;Hotkey 7
	If _Metro_ToggleIsChecked($tgHotkey7) Then
		$newHotkeys[$hkToggleFocus][$cAIactive] = 1
	Else
		$newHotkeys[$hkToggleFocus][$cAIactive] = 0
	EndIf
	$newHotkeys[$hkToggleFocus][$cAIKey] = GUICtrlRead($btnHotkey7)

	;Hotkey 8
	If _Metro_ToggleIsChecked($tgHotkey8) Then
		$newHotkeys[$hkActualFullscreen][$cAIactive] = 1
	Else
		$newHotkeys[$hkActualFullscreen][$cAIactive] = 0
	EndIf
	$newHotkeys[$hkActualFullscreen][$cAIKey] = GUICtrlRead($btnHotkey8)

	#EndRegion Hotkeys

	#Region Ingame
	$newIngame[$igChat][$cAIKey] = GUICtrlRead($btnIngame1)
	$newIngame[$igAbility][$cAIKey] = GUICtrlRead($btnIngame2)
	$newIngame[$igTell][$cAIKey] = GUICtrlRead($btnIngame3)
	$newIngame[$igCommand][$cAIKey] = GUICtrlRead($inputCommandSymbol)

	#EndRegion Ingame



	#Region Others
	If _Metro_ToggleIsChecked($tgbKongregate) Then
		$newGeneral[$bKongregate][$cAIactive] = 1
	Else
		$newGeneral[$bKongregate][$cAIactive] = 0
	EndIf


	$kgparams=GUICtrlRead($inputsKongregateParameters)
	If StringInStr($kgparams,"DO_NOT_SHARE_THIS_LINK") >0 Then
		Local $finalParameters="?"
		Local $requiredParameters[]=["kongregate_username", "kongregate_user_id", "kongregate_game_auth_token","kongregate_api_path"]
		Local $firstParameter = True
		Local $res=StringSplit($kgparams,"&")
		For $param in $res
			For $i =0 To UBound($requiredParameters)-1 Step 1
				IF StringInStr($param,$requiredParameters[$i])>0 Then
					IF Not $firstParameter Then
						$finalParameters=$finalParameters&"&" &$param
					Else
						$finalParameters=$finalParameters &$param
						$firstParameter = False
					Endif

				EndIf
			Next
		Next
		$newGeneral[$sKongregateParameters][$cAIcontent] = $finalParameters
	Else
		$newGeneral[$sKongregateParameters][$cAIcontent] = GUICtrlRead($inputsKongregateParameters)
	EndIf



	If _Metro_ToggleIsChecked($tgbAdditionalProgram) Then
		$newGeneral[$bLaunchAdditionalProgram][$cAIactive] = 1
	Else
		$newGeneral[$bLaunchAdditionalProgram][$cAIactive] = 0
	EndIf


	$newGeneral[$sAdditionalProgramPath][$cAIcontent] = GUICtrlRead($lblsAdditionalProgramPath)
	$newPaths[$sFlashFile][$cAIcontent] = GUICtrlRead($lblsFlashFile)

	If _Metro_ToggleIsChecked($tgbTesting) Then
		$newGeneral[$bTesting][$cAIactive] = 1
	Else
		$newGeneral[$bTesting][$cAIactive] = 0
	EndIf


	If _Metro_ToggleIsChecked($tgbAGCLoader) Then
		$newGeneral[$bAGCLoader][$cAIactive] = 1
	Else
		$newGeneral[$bAGCLoader][$cAIactive] = 0
	EndIf


	If _Metro_ToggleIsChecked($tgRedirect1) Then
		$newRedirects[$credirect1][$cAIactive] = 1
	Else
		$newRedirects[$credirect1][$cAIactive] = 0
	EndIf
	$newRedirects[$credirect1][$cAIKey] = GUICtrlRead($btnRedirectHotkey1)
	$newRedirects[$credirect1][$cAIRedirect] = GUICtrlRead($btnRedirectGamekey1)

	If _Metro_ToggleIsChecked($tgRedirect2) Then
		$newRedirects[$credirect2][$cAIactive] = 1
	Else
		$newRedirects[$credirect2][$cAIactive] = 0
	EndIf
	$newRedirects[$credirect2][$cAIKey] = GUICtrlRead($btnRedirectHotkey2)
	$newRedirects[$credirect2][$cAIRedirect] = GUICtrlRead($btnRedirectGamekey2)

	#EndRegion Others

	Local $differ = 0
	$differ += _Compare2DArrays($savedGeneral, $newGeneral)
	$differ += _Compare2DArrays($savedPaths, $newPaths)
	$differ += _Compare2DArrays($savedMacros, $newMacros)
	$differ += _Compare2DArrays($savedIngame, $newIngame)
	$differ += _Compare2DArrays($savedHotkeys, $newHotkeys)
	$differ += _Compare2DArrays($savedRedirects, $newRedirects)
	Return $differ
EndFunc   ;==>_ReadGUI

Func _CheckDuplicateKeys($macros, $hotkeys)
	Local $AllDuplicates = "Unable to save settings. One ore more Hotkeys/Macros use the SAME KEY. Please choose a different key or disable one of the features. " & @CRLF & @CRLF & "The following duplicates were found: " & @CRLF
	Local $iErrors = 0
	For $i = 0 To UBound($macros) - 1
		If $macros[$i][$cAIactive] = 1 Then
			For $j = 0 To UBound($hotkeys) - 1
				If $hotkeys[$j][$cAIactive] = 1 Then
					If $macros[$i][$cAIKey] = $hotkeys[$j][$cAIKey] Then
						$AllDuplicates = $AllDuplicates & "Macro " & $i & " and Hotkey '" & $hotkeys[$j][$cAIdescription] & "' both use '" & $macros[$i][$cAIKey] & "'" & @CRLF
						$iErrors += 1
					Else
					EndIf

				EndIf
			Next
		EndIf

	Next

	For $i = 0 To UBound($macros) - 1
		If $macros[$i][$cAIactive] = 1 Then
			For $j = 0 To UBound($macros) - 1
				If $macros[$j][$cAIactive] = 1 And $i <> $j Then
					If $macros[$i][$cAIKey] = $macros[$j][$cAIKey] Then
						$AllDuplicates = $AllDuplicates & "Macro '" & $i & "' and Macro '" & $j & "' both use '" & $macros[$i][$cAIKey] & "'" & @CRLF
						$iErrors += 1
					EndIf
				EndIf
			Next
		EndIf
	Next

	For $i = 0 To UBound($hotkeys) - 1
		If $hotkeys[$i][$cAIactive] = 1 Then
			For $j = 0 To UBound($hotkeys) - 1
				If $hotkeys[$j][$cAIactive] = 1 And $i <> $j Then
					If $hotkeys[$i][$cAIKey] = $hotkeys[$j][$cAIKey] Then
						$AllDuplicates = $AllDuplicates & "Hotkey '" & $hotkeys[$i][$cAIdescription] & "' and Hotkey '" & $hotkeys[$j][$cAIdescription] & "' both use '" & $hotkeys[$i][$cAIKey] & "'" & @CRLF
						$iErrors += 1
					EndIf
				EndIf
			Next
		EndIf
	Next
	$AllDuplicates = $iErrors & $AllDuplicates
	Return $AllDuplicates
EndFunc   ;==>_CheckDuplicateKeys


Func _PrepareExit()
	Local $changesMade = _ReadGUI()
	If $changesMade > 0 Then
		Local $descision = MsgBox(35, "Save configuration?", "Do you want to save your changes?")

		If $descision = 6 Then
			; Save to csv
			_SaveExit(1)
		ElseIf $descision = 2 Then
			Return 0
		Else
			_Metro_GUIDelete($Form1) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
			Exit
		EndIf
	Else
		_Metro_GUIDelete($Form1) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
		Exit
	EndIf
EndFunc   ;==>_PrepareExit



Func _SaveExit($skipCheck = 0)

	If Not $skipCheck = 1 Then
		Local $changesMade = _ReadGUI()
	EndIf

	Local $compared = _CheckDuplicateKeys($newMacros, $newHotkeys)

	$res = StringLeft($compared, 1)
	$compared = StringTrimLeft($compared, 1)

	If $res > 0 Then
		MsgBox(4096 + 16, "Unable to save settings", $compared)
		Return -1
	EndIf

	For $i = 0 To UBound($newPaths) - 1
		$newPaths[$i][$cAIcontent] = _ConvertPath($newPaths[$i][$cAIcontent])
	Next
	_SaveToCSV($pathGeneral, $newGeneral)
	_SaveToCSV($pathPaths, $newPaths)
	_SaveToCSV($pathMacros, $newMacros)
	_SaveToCSV($pathIngame, $newIngame)
	_SaveToCSV($pathHotkeys, $newHotkeys)
	_SaveToCSV($pathRedirects, $newRedirects)
	_Metro_GUIDelete($Form1) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
	Exit

EndFunc   ;==>_SaveExit


; Autor:        Faweyr
; Function:        GetKeyInput($sTime,$sBack)
; Parameter:    $sTime = Time to wait and check for pressed Keys
;                $sBack = the kind of Result
;                0 = Array[3] = ["_ispressed"-Code , "Send"-Code , Name of Key]
;                1 = "_ispressed"-Code
;                2 = "Send"-Code
;                3 = Name of Key
; Includes:        <Misc.au3>
Func GetKeyInput($sTime = 5000, $sBack = 0)
	$sTimer = TimerInit()
	$sDll = DllOpen("user32.dll")
	Local $sList[][3] = [[05, "none", "X1Mouse"], [06, "none", "X2Mouse"], [04, "none", "MiddleMouse"], [08, "{BACKSPACE}", "Backspace"], [09, "{TAB}", "Tab"], [0 & "D", "{ENTER}", "Enter"], _
			["A" & 0, "{LSHIFT}", "Left Shift"], ["A" & 1, "{RSHIFT}", "Right Shift"], _
			[13, "{Pause}", "Pause"], [14, "{CAPSLOCK}", "CAPSLOCK"], [20, "{SPACE}", "SPACE"], [21, "{PGUP}", "PGUP"], [22, "{PGDN}", "PGDN"], [23, "{End}", "End"], _
			[24, "{Home}", "Home"], [25, "{Left}", "Left"], [26, "{UP}", "UP"], [27, "{Right}", "Right"], [28, "{Down}", "Down"], [12, "{ALT}", "Alt"], [5 & "C", "{RWIN}", "RWIN"], _
			[2 & "C", "{PRINTSCREEN}", "PRINTSCREEN"], [2 & "D", "{INS}", "Ins"], [2 & "E", "{DELETE}", "DELETE"], [30, 0, "0"], [31, 1, "1"], [32, 2, "2"], _
			[33, 3, "3"], [34, 4, "4"], [35, 5, "5"], [36, 6, "6"], [37, 7, "7"], [38, 8, "8"], [39, 9, "9"], _
			[41, "a", "A"], [42, "b", "B"], [43, "c", "C"], [44, "d", "D"], [45, "e", "E"], [46, "f", "F"], [47, "g", "G"], _
			[48, "h", "H"], [49, "i", "I"], [4 & "A", "j", "J"], [4 & "B", "k", "K"], [4 & "C", "l", "L"], [4 & "D", "m", "M"], [4 & "E", "n", "N"], _
			[4 & "F", "o", "O"], [50, "p", "P"], [51, "q", "Q"], [52, "r", "R"], [53, "s", "S"], [54, "t", "T"], [55, "u", "U"], _
			[56, "v", "V"], [57, "w", "W"], [58, "x", "X"], [59, "y", "Y"], [5 & "A", "z", "Z"], [60, "{NUMPAD0}", "Numpad0"], [61, "{NUMPAD1}", "Numpad1"], _
			[62, "{NUMPAD2}", "Numpad2"], [63, "{NUMPAD3}", "Numpad3"], [64, "{NUMPAD4}", "Numpad4"], [65, "{NUMPAD5}", "Numpad5"], [66, "{NUMPAD6}", "Numpad6"], [67, "{NUMPAD7}", "Numpad7"], [68, "{NUMPAD8}", "Numpad8"], _
			[69, "{NUMPAD9}", "Numpad9"], [6 & "A", "{NUMPADMULT}", "NUMPADMULT"], [6 & "B", "{NUMPADADD}", "NUMPADADD"], [6 & "C", "{NUMPADENTER}", "NUMPADENTER"], [6 & "D", "{NUMPADSUB}", "NUMPADSUB"], [6 & "E", "{NUMPADDOT}", "NUMPADDOT"], [6 & "F", "{NUMPADDIV}", "NUMPADDIV"], _
			[70, "{F1}", "F1"], [71, "{F2}", "F2"], [72, "{F3}", "F3"], [73, "{F4}", "F4"], [74, "{F5}", "F5"], [75, "{F6}", "F6"], [76, "{F8}", "F7"], _
			[77, "{F8}", "F8"], [78, "{F9}", "F9"], [79, "{F10}", "F10"], [7 & "A", "{F11}", "F11"], [7 & "B", "{F12}", "F12"], [90, "{NUMLOCK}", "NUMLOCK"], [91, "{SCROLLLOCK}", "SCROLLLOCK"], _
			["A" & 2, "{LCTRL}", "LCTRL"], ["A" & 3, "{RCTRL}", "RCTRL"], ["A" & 4, "{LALT}", "LALT"], ["A" & 5, "{RALT}", "RALT"], [5 & "B", "{LWIN}", "LWIN"]]


	GUICtrlSetState($ESCinfo, 16)
	Do
		For $i = 0 To UBound($sList) - 1 Step 1
			If _IsPressed($sList[$i][0], $sDll) Then
				DllClose($sDll)
				If $sBack <> 0 Then
					Return $sList[$i][$sBack - 1]
				Else
					Local $sResult[3] = [$sList[$i][0], $sList[$i][1], $sList[$i][2]]
					GUICtrlSetState($ESCinfo, 32)
					Return $sResult
				EndIf
			EndIf
		Next
	Until _IsPressed("1B") = 1 Or $sTime <= TimerDiff($sTimer)
	GUICtrlSetState($ESCinfo, 32)
	DllClose($sDll)
	SetError(1)
EndFunc   ;==>GetKeyInput
