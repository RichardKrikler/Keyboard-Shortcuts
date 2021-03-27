#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; ------------------
;		Reload Script
!^u::
	Reload
return

; ------------------
; General Commands

; Windows + R ->    Strg + UMSCHALT + Enter -> Admin Modus
; 

; ------------------
; File Explorer

; One Folder Up == {Alt}{Up}

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

; ------------------
; Browser

; Duplicate a window
^!d::
;					  Chrome							 Edge
	WinGetActiveTitle, currentTitle
	if (WinActive("ahk_exe chrome.exe") or WinActive("ahk_exe msedge.exe"))
		Send !d
		Send !`r
return

; ------------------
; Show all Macros for an open program (external)

^q::
	Run ShowMacrosForProgram.ahk
return

; ------------------
; Word

#IfWinActive ahk_exe WINWORD.EXE
	; Classic Yellow Marker
	^RShift::
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
	^!;::
		Send !r
		Send ge
		Send k
	return
	
	; PDF - Export
	^!p::
		Send !d
		Send r
		Send f
		Send h
	return

	; Ω-symbol
	#^!o::
		Send !i
		Send zs
		Send sy
		Send {Enter}
	return

#IfWinActive

; ------------------
; Excel

#IfWinActive ahk_exe EXCEL.EXE
	

#IfWinActive

; ------------------
; Numpad Functions
/*
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
*/


; ------------------
; Quick Access Apps

; Edge-Browser
+^1::
	IfWinNotExist, ahk_exe msedge.exe 			; if the window does not exist
		Run, msedge.exe							; then start the program
		GroupAdd, gEdge, ahk_exe msedge.exe 	; and add the new window to a group named "gEdge"
	if WinActive(ahk_exe msedge.exe)			; if there is an active window (hidden or open)
		GroupActivate, gEdge, r					; go to the next window in the "gEdge" group
	else										; if there is not an active window
		WinActivate ahk_exe msedge.exe			; activate (open) a window
return

; Chrome
^1::
	IfWinNotExist, ahk_exe chrome.exe 			; if the window does not exist
		Run, chrome.exe							; then start the program
		GroupAdd, gChrome, ahk_exe chrome.exe 	; and add the new window to a group named "gChrome"
	if WinActive(ahk_exe chrome.exe)			; if there is an active window (hidden or open)
		GroupActivate, gChrome, r				; go to the next window in the "gChrome" group
	else										; if there is not an active window
		WinActivate ahk_exe chrome.exe			; activate (open) a window
return

; Explorer
^2::
	IfWinNotExist, ahk_class CabinetWClass
		Run, explorer.exe
		GroupAdd, gExplorers, ahk_class CabinetWClass
	if WinActive(ahk_exe explorer.exe)
		GroupActivate, gExplorers, r
	else
		WinActivate ahk_class CabinetWClass
return

; Notepad
^3::
	IfWinNotExist, ahk_exe notepad++.exe
		Run, notepad++.exe
	if WinActive(ahk_exe notepad++.exe)
		Send ^{PgDn}
	else
		WinActivate ahk_exe notepad++.exe
return

#If WinActive("ahk_exe notepad++.exe") 
or WinActive("ahk_exe Code.exe") 
or WinActive("ahk_exe PacketTracer7.exe") 
or WinActive("ahk_exe idea64.exe") 
or WinActive("ahk_exe datagrip64.exe") 
or WinActive("ahk_exe soffice.bin") 
or WinActive("ahk_exe WINWORD.EXE")
	; dividing topics
	^!-::
		Send ------------------
	return
	
#IfWinActive

#If WinActive("ahk_exe PacketTracer7.exe")
	; marking network address
	^!.::
		Send |------------------|
	return
	
#IfWinActive


^4::	; Word
	IfWinNotExist, ahk_exe WINWORD.EXE
		Run, WINWORD.EXE
	GroupAdd, gWord, ahk_exe WINWORD.EXE
	if WinActive(ahk_exe WINWORD.EXE)
		GroupActivate, gWord, r
	else
		WinActivate ahk_exe WINWORD.EXE
return

; Change Tab, for multiple programs
#If WinActive("ahk_exe Code.exe") or WinActive("ahk_exe notepad++.exe") or WinActive("ahk_exe chrome.exe") or WinActive("ahk_exe msedge.exe")
	^!RShift::
		Send ^{PgUp}
	return
	^RShift::
		Send ^{PgDn}
	return
#IfWinActive


; Start Calculator
Insert::
	Run, calc.exe
return

; Hide the current active window
^0::
	WinGetClass, app ,A
	WinMinimize, ahk_class %app%
return


; ------------------
; Relocate a program in a new virtual desktop

/*
^5::
	Send ^#d		; create new desktop
	Send ^#{Left} 	; go back
	Send #{Tab} 	; see open program

return
*/

; ------------------
; Fast App Switching (external)

^F4::
	Run appSwitcher.ahk
return

; ------------------
; IntelliJ

#IfWinActive ahk_exe idea64.exe
	; change Tabs
	^!RShift::
		Send !{Left}
	return
	^RShift::
		Send !{Right}
	return
	
	; Create Javadoc
	Numpad2::
		Send, /**{Enter}
	return
	
#IfWinActive

; ------------------
; Volume via scroll wheel

; !WheelDown::
; 	Send {Volume_Down}
; return

; !WheelUp::
; 	Send {Volume_Up}
; return

; Mute with the middle mouse button (and alt)
!MButton::
	Send {Volume_Mute}
return

; ------------------
; Dictionary input ("leo.org")

!PgDn::
	InputBox, UserInput, Dictionary, Enter a word to search at leo.org
	if ErrorLevel
    	Exit
	Run https://dict.leo.org/englisch-deutsch/%UserInput%
return

; ------------------
; Maximize Active Window

#y::
	WinMaximize, A
Return

; ------------------
; Snap window to the left
#s::
	Send #{Left}
return

; Snap window to the right
#c::
	Send #{Right}
return

; ------------------
; FoxitReader.exe

#IfWinActive ahk_exe FoxitReader.exe
	; change Tabs
	^!RShift::
		; Strg + Shift + Page Up
		Send ^+{PgUp}
	return
	^RShift::
		Send ^+{PgDn}
	return

	; Strg+Z -- step backward
	F1::
		Send ^z
	return
	; Strg+Shift+Z -- step forward
	F3::
		Send ^+z
	return
#IfWinActive

; ------------------
; Open File via File Explorer with full Path from Clipboard
; Shortcut: Win + ?

#?::
	Send #r
	Sleep 100
	Send ^v
	Sleep 100
	Send {Enter}
return


; ------------------
; Abbreviations

::RKA::Richard Krikler


; ------------------
; usages.ahk - CPU & RAM

#^!c::
Run usages.ahk
return

#^!e::
Run usagesExtended.ahk
return






