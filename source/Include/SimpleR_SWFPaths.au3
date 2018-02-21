#include-once
#include <File.au3>
#include <Inet.au3>
#include <InetConstants.au3>

;===============================================================================
; Function Name: GetProductionSWF()
; Description: Returns the path to the production SWF file.
; Version: 1.0.0.0
; Requirement(s): AutoIt Beta > v3.3.14.2
; Return Value(s): On Success - The path for the current production swf file, @ERROR = 0
; On Failure - sets @error to non-zero.
; Author(s): vScherb
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
;             -1 - An unknown error occurred
;              1 - Error opening specified FileChangeDir
;              2 - Unable to split the FileChangeDir
;             10 - No bytes were received
;             11 - The size of the received version was bigger than 100 bytes (Assumed to be much less)
; Author(s): vScherb
;
;===============================================================================
Func GetKongregateSWF()
   Local $filepath = _TempFile()
   Local $lines[] = []
   Local $byteSize = InetGet("http://www.realmofthemadgod.com/version.txt", $filepath, $INET_FORCERELOAD, $INET_DOWNLOADWAIT)

   If $byteSize == 0 Then
	  FileDelete($filepath)
	  SetError(10, 0)
	  Return ""
   ElseIf $byteSize > 100 Then
	  FileDelete($filepath)
	  SetError(11, 0)
	  Return ""
   EndIf

   If _FileReadToArray($filepath, $lines) == 1 And $lines[0] >= 1 Then
	  SetError(0, 0)
	  Return "https://realmofthemadgodhrd.appspot.com/AGCLoader" & $lines[1] & ".swf"
   Else
	  FileDelete($filepath)

	  Switch @error
	  Case 1
		 ; Error opening specified FileChangeDir
		 SetError(1, 0)
	  Case 2
		 ; Unable to split the FileChangeDir
		 SetError(2, 0)
	  Case Else
		 ; Unknown error occurred
		 SetError(-1, 0)
	  EndSwitch

	  Return ""
   EndIf
EndFunc   ;==> GetKongregateSWF
