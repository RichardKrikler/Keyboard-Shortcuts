;Fast Switching
;Select two Programs to switch through


; Ctrl+F4 -> start/stop appSwitcher
; F4 -> switching between the selected programs

; currently the second program can only be one of the "Quick Access Apps" (Hotkays.ahk)



first_pid = 00000
second_pid = 00000
gui_pid = 00000
stat = 0

WinGetActiveTitle, currentTitle
WinGet, first_pid, PID, %currentTitle%

Gui, Add, Text, x10 y10, Fast Switching
Gui, Add, Text, x10 y25, First Program = %first_pid%
Gui, +AlwaysOnTop +Owner -Caption
Gui, Show, Center h170 w170 x0, Fast Switching


WinGetActiveTitle, currentTitle
WinGet, gui_pid, PID, %currentTitle%
WinGet, second_pid, PID, %currentTitle%

If (stat == 0)
{
	While (currentPid == gui_pid)
	{
	WinGetActiveTitle, currentTitle
	WinGet, currentPid, PID, %currentTitle%
	Sleep, 50
	}
	stat = 1
}

currentClass = ""
While (gui_pid == second_pid Or second_pid == first_pid) ; Or currentClass == "Shell_TrayWnd")
{
	WinGetActiveTitle, currentTitle
	WinGet, second_pid, PID, %currentTitle%
	WinGetClass, currentClass, A
	Sleep, 50
}


If (stat == 1)
{
	While (currentPid != gui_pid)
	{
	WinGetActiveTitle, currentTitle
	WinGet, currentPid, PID, %currentTitle%
	Sleep, 50
	}
	Gui, Destroy
	stat = 0
	
}
return


GuiClose:
	ExitApp

^F4::
	Gui, Destroy
	ExitApp
return


F4::
	WinGetActiveTitle, currentTitle
	WinGet, currentPid, PID, %currentTitle%

	Sleep, 50
	If (currentPid == second_pid)
	{
		WinActivate ahk_pid %first_pid%
		Sleep, 50
	}
	Else
	{
		WinActivate ahk_pid %second_pid%
		Sleep, 50
	}
return

return