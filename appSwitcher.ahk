#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; Fast Switching
; Select two Programs to switch through

; Press Strg(+)F4 to start this script via Hotkeys.ahk
; Open the second window
; then click back to the AHK GUI

second_pid := 0

WinGetActiveTitle, currentTitle
WinGet, first_pid, PID, %currentTitle%

Gui, Add, Text, x10 y10, Fast Switching
Gui, Add, Text, x10 y25, First Program = %first_pid%
Gui, +AlwaysOnTop +Owner -Caption
Gui, Show, y0 h170 w170 x0, Fast Switching

WinGetActiveTitle, currentTitle
WinGet, gui_pid, PID, %currentTitle%
WinGet, second_pid, PID, %currentTitle%


currentClass := "Shell_TrayWnd"
While (gui_pid = second_pid || second_pid = first_pid || currentClass = "Shell_TrayWnd" || second_pid = "")  ; Or currentClass == "Shell_TrayWnd")
{
	WinGetActiveTitle, currentTitle
	WinGet, second_pid, PID, %currentTitle%
	WinGetClass, currentClass, A
	Sleep, 50
}

While (currentPid != gui_pid)
{
	WinGetActiveTitle, currentTitle
	WinGet, currentPid, PID, %currentTitle%
	Sleep, 50
}
Gui, Destroy


^F4::
	Gui, Destroy
	ExitApp
return


F4::
	WinGetActiveTitle, currentTitle
	WinGet, currentPid, PID, %currentTitle%

	If (currentPid == second_pid)
	{
		WinActivate ahk_pid %first_pid%
	}
	Else
	{
		WinActivate ahk_pid %second_pid%
	}
return