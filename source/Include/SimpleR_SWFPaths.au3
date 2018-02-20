#include-once

#include <Inet.au3>

;===============================================================================
;
; Function Name: GetProductionSWF()
; Description: Returns the path to the production SWF file.
; Version: 1.0.0.0
; Requirement(s): AutoIt Beta > v3.3.14.2
; Return Value(s): On Success - The path for the current production swf file, @ERROR = 0
; On Failure - sets @error to non-zero.
; Author(s): vScherb
;
;===============================================================================

Func GetProductionSWF()
   ; Introduced in patch X.22.0 https://www.reddit.com/r/RotMG/comments/7ui6v3/patch_x220_gday_oryx/
   ; Pragraph Update #1
   Return "https://realmofthemadgodhrd.appspot.com/client"
EndFunc   ;==> GetProductionSWF

;===============================================================================
;
; Function Name: GetTestingSWF()
; Description: Returns the path to the testing SWF file.
; Version: 1.0.0.0
; Requirement(s): AutoIt Beta > v3.3.14.2
; Return Value(s): On Success - The path for the current testing swf file, @ERROR = 0
; On Failure - sets @error to non-zero.
; Author(s): vScherb
;
;===============================================================================

Func GetTestingSWF()
   ; Introduced after the announcemnt of patch X.22.0 https://www.reddit.com/r/RotMG/comments/7yy1qj/public_testing_is_coming/
   ; This url can be used to grab the current testing swf. This is the url in case of the language error, which will be assumed.
   Return "https://rotmgtesting.appspot.com/client"
EndFunc   ;==> GetTestingSWF

;===============================================================================
;
; Function Name: GetKongregateSWF()
; Description: Returns the path to the Kongregate SWF file. If more than 100 bytes of data for the version are returned an error is assumed.
; Version: 1.0.0.0
; Requirement(s): AutoIt Beta > v3.3.14.2
; Return Value(s): On Success - The path for the current Kongregate swf file, @ERROR = 0
; On Failure - returns empty string and sets @error to non-zero.
;              1 - An error with the request was caught
;              2 - The size of the received version was bigger than 100 bytes (Assumed to be much less)
; Author(s): vScherb
;
;===============================================================================

Func GetKongregateSWF()
   Local $currentProductionVersion = _INetGetSource("http://www.realmofthemadgod.com/version.txt")

   If @error <> 0 Then
	  SetError(1, 0)
	  Return
   EndIf

   If @extended > 100 Then
	  SetError(2, 0)
	  Return ""
   EndIf

   Return "https://realmofthemadgodhrd.appspot.com/AGCLoader" & $currentProductionVersion & ".swf"
EndFunc   ;==> GetKongregateSWF
