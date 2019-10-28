;====================================================================================================
;		Reload Script
!^u::
	Reload
return

;====================================================================================================
;		General Commands

; Windows + R ->    Strg + UMSCHALT + Enter -> Admin Modus
; 

;====================================================================================================
;		File Explorer

;One Folder Up == {Alt}{Up}

#IfWinActive ahk_class CabinetWClass
	;Create Folder
	^.::
		Send !2
	return

	;create .txt file
	^-::
		Send !r
		Send w
		Send {Up}{Up}{Up}
		Send {Enter}
	return
#IfWinActive

;====================================================================================================
;		Browser

;Duplicate a window
^!d::
;					  Chrome							 Edge
WinGetActiveTitle, currentTitle
if (WinActive("ahk_exe chrome.exe") or SubStr(currentTitle, -13) == "Microsoft Edge")
	Send !d
	Send !`r
return

;Open link in new Tab
#IfWinActive ahk_exe chrome.exe
	^!t::
		Send {Click, right}
		Sleep, 150
		Send {Down}{Enter}
	return
#IfWinActive


;====================================================================================================
;		Show all Macros for an open program

^q::
	Run ShowMacrosForProgram.ahk
return

;====================================================================================================
;		Word

#IfWinActive ahk_exe WINWORD.EXE
	; Classic Yellow Marker
	RShift::
		Send !r
		Send ge
		Send {Enter}
		Send {Esc}
	return
	
	; Light Marker
	^!#::
		Send !r
		Send nc
		Send {Down}
		Send {Right}{Right}{Right}{Right}
		Send {Right}{Right}{Right}{Enter}
	return
	
	; Remove yellow Marker
	^!-::
		Send !r
		Send ge
		Send k
	return
	
	; PDF - Export
	^!p::
		Send !d
		Send r
		Send h
	return
#IfWinActive

;====================================================================================================
;		Excel

#IfWinActive ahk_exe EXCEL.EXE
	

#IfWinActive

;====================================================================================================
;		Numpad Functions

NumpadDiv::
	WinGetClass, app ,A
	WinMove, ahk_class %app%, , 50, 50, 800, 900
return

NumpadMult::
	WinGetClass, app ,A
	WinMinimize, ahk_class %app%
return

NumpadSub::
	WinGetClass, app ,A
	WinClose, ahk_class %app%
return

NumpadAdd::
	WinGetClass, app ,A
	WinMaximize, ahk_class %app%
return

;====================================================================================================
;		Quick Access Apps

^1::	; Chrome
	IfWinNotExist, ahk_exe chrome.exe
		Run, chrome.exe
		GroupAdd, gChrome, ahk_exe chrome.exe
	if WinActive(ahk_exe chrome.exe)
		GroupActivate, gChrome, r
	else
		WinActivate ahk_exe chrome.exe
return
#IfWinActive ahk_exe chrome.exe
	^RShift::
		Send ^{PgUp}
	return
	RShift::
		Send ^{PgDn}
	return
#IfWinActive


^2::	; Explorer
	IfWinNotExist, ahk_class CabinetWClass
		Run, explorer.exe
		GroupAdd, gExplorers, ahk_class CabinetWClass
	if WinActive(ahk_exe explorer.exe)
		GroupActivate, gExplorers, r
	else
		WinActivate ahk_class CabinetWClass
return

^3::	; Notepad
	IfWinNotExist, ahk_exe notepad++.exe
		Run, notepad++.exe
	if WinActive(ahk_exe notepad++.exe)
		Send ^{PgDn}
	else
		WinActivate ahk_exe notepad++.exe
return

^4::	; Word
	IfWinNotExist, ahk_exe WINWORD.EXE
		Run, WINWORD.EXE
	GroupAdd, gWord, ahk_exe WINWORD.EXE
	if WinActive(ahk_exe WINWORD.EXE)
		GroupActivate, gWord, r
	else
		WinActivate ahk_exe WINWORD.EXE
return


;====================================================================================================
;		Relocate a program in a new virtual desktop

^5::
	Send ^#d		; create new desktop
	Send ^#{Left} 	; go back
	Send #{Tab} 	; see open program

return


;====================================================================================================
;		Microsoft To-Do

;	shortcut for adding a task in a gui input
;^!,::
;	Run AddToDoTask.ahk
;return


