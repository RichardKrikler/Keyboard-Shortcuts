#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; ------------------

MemoryLoad()
{
    static MEMORYSTATUSEX, init := NumPut(VarSetCapacity(MEMORYSTATUSEX, 64, 0), MEMORYSTATUSEX, "uint")
    if !(DllCall("GlobalMemoryStatusEx", "ptr", &MEMORYSTATUSEX))
        throw Exception("Call to GlobalMemoryStatusEx failed: " A_LastError, -1)
    return NumGet(MEMORYSTATUSEX, 4, "UInt")
}

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

Gui, Add, Text, x10 y5 vCpuText, % "CPU:" CPULoad()
Gui, Add, Text, x55 y5 vMemoryText, % "RAM:" MemoryLoad()
; +E0x20  -->  click through
Gui, +AlwaysOnTop +Owner -Caption +LastFound +E0x20
Gui +LastFound
WinSet, Transparent, 180
Gui, Show, y0 h22 w105 x1400, Usages


Loop {
  GuiControl, Text, CpuText , % "CPU:" CPULoad()
  GuiControl, Text, MemoryText , % "RAM:" MemoryLoad()
  Sleep 1000
}


GuiClose:
	ExitApp

#^!c::
	Gui, Destroy
	ExitApp
return