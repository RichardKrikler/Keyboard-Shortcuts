#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; ------------------

; powershell.exe
; $cpuPercentage = (Get-WmiObject Win32_Processor).LoadPercentage
; Write-Host $cpuPercentage
; $ramPercentage =  [math]::Round(((Get-Process | Measure-Object -Sum ws).sum / 1GB)/((Get-WMIObject -class Win32_PhysicalMemory).capacity / 1GB)*100)
; Write-Host $ram

; run Powershell command without promt
; https://www.reddit.com/r/AutoHotkey/comments/ey3pmb/get_hidden_cmdpowershell_output/
JEE_RunGetStdOut(vTarget, vSize:="")
{
	DetectHiddenWindows, On
	vComSpec := A_ComSpec ? A_ComSpec : ComSpec
	Run, % vComSpec,, Hide, vPID
	WinWait, % "ahk_pid " vPID
	DllCall("kernel32\AttachConsole", "UInt",vPID)
	oShell := ComObjCreate("WScript.Shell")
	oExec := oShell.Exec(vTarget)
	vStdOut := ""
	if !(vSize = "")
		VarSetCapacity(vStdOut, vSize)
	while !oExec.StdOut.AtEndOfStream
		vStdOut := oExec.StdOut.ReadAll()
	DllCall("kernel32\FreeConsole")
	Process, Close, % vPID
	return vStdOut
}

CPULoad()
{
  return % JEE_RunGetStdOut("PowerShell.exe (Get-WmiObject Win32_Processor).LoadPercentage")
}

MemoryLoad()
{
	return % JEE_RunGetStdOut("PowerShell.exe [math]::Round(((gps *chrome* | measure-object ws -sum).sum /1GB)/((Get-WMIObject -class Win32_PhysicalMemory).capacity / 1GB)*100)")
}

Gui, Add, Text, x10 y5 vCpuText, % "CPU:" CPULoad()
Gui, Add, Text, x55 y5 vMemoryText, % "RAM:" MemoryLoad()
Gui, Add, Text, x105 y5 vProgramName, "Program Name"
; +E0x20  -->  click through
Gui, +AlwaysOnTop +Owner -Caption +LastFound +E0x20
Gui +LastFound
WinSet, Transparent, 180
Gui, Show, y0 h22 w230 x1510, Usages


Loop {
	WinGetActiveTitle, currentTitle
	WinGetClass, currentClass, A
	WinGet, currentPid, PID, %currentTitle%
	WinGet, currentExe, ProcessName, %currentTitle%
  	
	if (currentExe != "ApplicationFrameHost.exe") {
		programNameV := currentExe
	} else if (currentExe == "ApplicationFrameHost.exe") {
		programNameV := currentTitle
	}

	GuiControl, Text, CpuText , % "CPU:" CPULoad()
  	GuiControl, Text, MemoryText , % "RAM:" MemoryLoad()
	GuiControl, Text, ProgramName, % programNameV

  	Sleep 1000
}


GuiClose:
	ExitApp

#^!e::
	Gui, Destroy
	ExitApp
return