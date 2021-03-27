#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Show all Macros for an open program

boxW = 400
boxH = 220
boxXpos := A_ScreenWidth-(boxW*1.5)
boxYpos := A_ScreenHeight-(boxH*2)
Gui, +AlwaysOnTop +Owner -Caption
Gui, Font, s10

; Font Color
colorX := boxXpos+(boxW/2)
colorY := boxYpos+(boxH/2)
PixelGetColor, backColor, %colorX%, %boxYpos%, RGB
	If backColor < 0x474747
	{
		Gui, Font, cWhite
		GuiControl, Font, DisColor
	}
	else
	{
		Gui, Font, cBlack
		GuiControl, Font, DisColor
	}
	Gui, Color, %backColor%
	GuiControl,, DisColor, %backColor%


; Transperency
;Gui, Color, EEAA99
Gui +LastFound  ; Make the GUI window the last found window for use by the line below.
WinSet, TransColor, %backColor%

Gui, Show, x%boxXpos% y%boxYpos% h%boxH% w%boxW% NA, Macros for specific Program

; Get Information about Active Program
WinGetActiveTitle, currentTitle
WinGetClass, currentClass, A
WinGet, currentPid, PID, %currentTitle%
WinGet, currentExe, ProcessName, %currentTitle%

writeToGui(text) {
	Gui, Add, Text, +Right w365, %text%
}


; Microsoft File Explorer
if (currentClass == "CabinetWClass") {
	writeToGui("Open/Switch: Ctrl(+)2")
	writeToGui("One folder UP: Alt(+)Up")
	writeToGui("Create Folder: Ctrl(+).")
	writeToGui("Create .txt file: Ctrl(+)-")
	writeToGui("See properties for a file/folder: Alt(+)1")
	writeToGui("Select several items: Strg")
}

; Google Chrome
if (currentExe == "chrome.exe") {
	writeToGui("Open: Ctrl(+)1")
	writeToGui("Switch: RShift")
	writeToGui("Duplicate Tab: Ctrl(+)Alt(+)D")
	writeToGui("Reload CSS & JS: Ctrl(+)Shift(+)R")
	writeToGui("Delete Chrome Data: Ctrl(+)Shift(+)Del")
	writeToGui("Open RescueTime: Alt(+)T")
}

; Microsoft Word
if (currentExe == "WINWORD.EXE") {
	writeToGui("Mark selected text (classic): RShift")
	writeToGui("Mark selected text (light): Ctrl(+)Alt(+)#")
	writeToGui("Remove marker: Ctrl(+)Alt(+)-")
	writeToGui("Create PDF: Ctrl(+)Alt(+)P")
	writeToGui("Select several words/lines: Strg")
	writeToGui("Paste unformatted Text: Strg(+)Alt(+)V")
}

; Notepad++
if (currentExe == "notepad++.exe") {
	writeToGui("Open/Switch: Ctrl(+)3")
	writeToGui("Make to comment: Ctrl(+)K")
	writeToGui("Delete a line: Ctrl(+)Shift(+)L")
}

; Microsoft To Do
if (currentTitle == "Microsoft To Do") {
	writeToGui("Open: Win(+)2")
	writeToGui("Add new Task: Ctrl(+)N")
	writeToGui("Add new Task to My Day: Ctrl(+)T")
	writeToGui("Complete Task: Ctrl(+)D")
	writeToGui("Search: Ctrl(+)F")
	writeToGui("Sync: Ctrl(+)R")
}

; Todoist
if (currentTitle == "Todoist – To Do Liste & Taskmanager") {
	writeToGui("Add new Task: Q")
	writeToGui("Sort by Date: D")
	writeToGui("Sort by Priority: P")

}

; VSC (Visual Studio Code)
if (currentExe == "Code.exe") {
	writeToGui("Make to comment: Ctrl(+)#")
	writeToGui("Open Settings: Ctrl(+),")
	writeToGui("Show SVG: Alt(+)Shift(+)S O")
	writeToGui("Show side menu: Strg(+)b")
}

; Microsoft Edge Browser
if (currentExe == "msedge.exe") {
	writeToGui("Duplicate Tab: Ctrl(+)Alt(+)D")
}

; YouTube on Google Chrome
if (SubStr(currentTitle, -22) == "YouTube - Google Chrome") {
	writeToGui("Youtube: 10s back: J")
	writeToGui("Youtube: 10s forward: L")
}

; GnuSim8085
if (currentExe == "gnusim8085.exe") {
	writeToGui("Listing anzeigen: Ctrl(+)L")
	writeToGui("Reset Register, Flags, Speicher: Ctrl(+)R")
	writeToGui("Go through line by line: F5")
	writeToGui("Assemble: F8")
}

; JetBrains: IntelliJ
if (currentExe == "idea64.exe") {
	writeToGui("Settings: Ctrl(+)Alt(+)S")
	writeToGui("Project Settings: Ctrl(+)Shift(+)Alt(+)S")
	writeToGui("Select Methods to override: Ctrl(+)O")
	writeToGui("Format the whole file: Ctrl(+)Alt(+)L")
	writeToGui("Create Line Comment: Strg(+)Num/")
	writeToGui("Create Block Comment: Strg(+)Shift(+)Num/")
	writeToGui("Create new Class: Num1")
	writeToGui("Create JavaDoc: Num2")
}

; JetBrains: PyCharm
if (currentExe == "pycharm64.exe") {
	writeToGui("Settings: Ctrl(+)Alt(+)S")
	writeToGui("Format the whole file: Ctrl(+)Alt(+)L")
	writeToGui("Create Line Comment: Strg(+)Num/")
	writeToGui("Create new Python File: Num1")
}


; VMware
if (currentExe == "vmware.exe") {
	writeToGui("Get out of VM: Ctrl(+)Alt")
	writeToGui("View Library: F9")
}

; Audacity
if (currentExe == "audacity.exe") {
	writeToGui("Cut on the current position: Ctrl(+)I")
	writeToGui("Play: Space")
	writeToGui("Pause: P")
}

; Discord
if (currentExe == "Discord.exe") {
	writeToGui("Mute: Ctrl(+)Alt(+)m")
	writeToGui("Mute temporarily: Alt(+)m")
	writeToGui("Deafen: Ctrl(+)Alt(+)n")
}

; Windows Terminal App
if (currentExe == "WindowsTerminal.exe") {
	writeToGui("New PowerShell: Strg(+)Shift(+)1")
	writeToGui("New CMD: Strg(+)Shift(+)2")
	writeToGui("New Ubuntu: Strg(+)Shift(+)3")
	writeToGui("Switch Terminals: Strg(+)Tab")
}



Sleep, 9000
ExitApp
Return


GuiClose:
	ExitApp

^q::
	Gui, Destroy
	ExitApp
return