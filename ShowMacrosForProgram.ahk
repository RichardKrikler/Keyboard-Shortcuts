; Show all Macros for an open program
; Start with Ctrl+Q via Hotkays.ahk

; This script shows the Hotkeys, which are manually set to appear, for a specific active program


boxW = 400
boxH = 200
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


state := 0 ; Acer
if (A_ComputerName == "DESKTOP-5S07O77") {
	state := 1 ; Surface
}
;						   Acer	   Surface
; todo := ((state == 0) ? (888) : (13424))



explorer = CabinetWClass
if (currentClass == explorer)
{
	writeToGui("Open/Switch: Ctrl(+)2")
	writeToGui("One folder UP: Alt(+)Up")
	writeToGui("Create Folder: Ctrl(+).")
	writeToGui("Create .txt file: Ctrl(+)-")
	writeToGui("See properties for a file/folder: Alt(+)1")
	writeToGui("Select several items: Strg")
}

chrome = chrome.exe
if (currentExe == chrome)
{
	writeToGui("Open: Ctrl(+)1")
	writeToGui("Switch: RShift")
	writeToGui("Duplicate Tab: Ctrl(+)Alt(+)D")
	writeToGui("Open Link: Ctrl(+)Alt(+)T")
	writeToGui("Reload CSS & JS: Ctrl(+)Shift(+)R")
	writeToGui("Delete Chrome Data: Ctrl(+)Shift(+)Del")
}

word = WINWORD.EXE
if (currentExe == word)
{
	writeToGui("Mark selected text (classic): RShift")
	writeToGui("Mark selected text (light): Ctrl(+)Alt(+)#")
	writeToGui("Remove marker: Ctrl(+)Alt(+)-")
	writeToGui("Create PDF: Ctrl(+)Alt(+)P")
	writeToGui("Select several words/lines: Strg")
}

notepad = notepad++.exe
if (currentExe == notepad)
{
	writeToGui("Open/Switch: Ctrl(+)3")
	writeToGui("Make to comment: Ctrl(+)K")
}

if (currentTitle == "Microsoft To Do")
{
	writeToGui("Open: Win(+)2")
	writeToGui("Add new Task: Ctrl(+)N")
	writeToGui("Add new Task to My Day: Ctrl(+)T")
	writeToGui("Complete Task: Ctrl(+)D")
	writeToGui("Search: Ctrl(+)F")
	writeToGui("Sync: Ctrl(+)R")
}

; out of order
desktop := ((state == 0) ? (8108) : (9844))
if (currentPid == desktop)
{
	writeToGui("Open/Switch Chrome: Ctrl(+)1")
	writeToGui("Open/Switch Explorer: Ctrl(+)2")
	writeToGui("Open/Switch Notepad: Ctrl(+)3")
}

visualStudioCode = Code.exe
if (currentExe == visualStudioCode)
{
	writeToGui("Make to comment: Ctrl(+)#")
	writeToGui("Open Settings: Ctrl(+),")
}

if (SubStr(currentTitle, -13) == "Microsoft Edge") {
	writeToGui("Duplicate Tab: Ctrl(+)Alt(+)D")
}

if (SubStr(currentTitle, -22) == "YouTube - Google Chrome") {
	writeToGui("Youtube: 10s back: J")
	writeToGui("Youtube: 10s forward: L")
}

gnu = gnusim8085.exe
if (currentExe == gnu)
{
	writeToGui("Listing anzeigen: Ctrl(+)L")
	writeToGui("Reset Register, Flags, Speicher: Ctrl(+)R")
	writeToGui("Go through line by line: F5")
	writeToGui("Assemble: F8")
}

intelliJ = idea64.exe
if (currentExe == intelliJ)
{
	writeToGui("Settings: Ctrl(+)Alt(+)S")
	writeToGui("Project Settings: Ctrl(+)Shift(+)Alt(+)S")
	writeToGui("Select Methods to override: Ctrl(+)O")
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