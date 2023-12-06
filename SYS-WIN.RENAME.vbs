' **************************************************************************************************************:
' **************************************************************************************************************:
' Author: 	JBallard (JEB)																						:
' Script:	SYSTEM-WIN.RENAME.vbs																				:
' Date:		2017.9.01																							:
' Purpose:	A script to remove a PC from the Domain; Rename it, & Rejoin It requires WIN Support Tools			:
' Version:	1.0																									:
' **************************************************************************************************************:
' **************************************************************************************************************:
'
' **************************************************: 
' DEFINE PARAMETERS	& CONFIGURATION PATHS			:
' **************************************************:
Option Explicit

Dim oFileSystem 'Scripting Dictionary object
Dim oWshShell 'Windows Script Host Shell object
Dim sCurrentName 'holds computername environment variable
Dim oWshEnvironment 'Windows Script Host environment object
Dim sTempDir 'temporary directory of computer on which comprename.vbs is run
Dim sPHASE 'holds number indicating PHASE in rename operation
Dim sProgram 'name of this script
Dim sProgramDir 'Path to this script

Set oFileSystem = CreateObject("Scripting.FileSystemObject")
Set oWshShell = CreateObject("WScript.Shell")
Set oWshEnvironment = oWshShell.Environment("Process")

sCurrentName = oWshEnvironment("COMPUTERNAME")
sTempDir = oWshEnvironment("TEMP")
sProgram = "SYSTEM-WIN.RENAME.vbs"
sProgramDir = oFileSystem.GetAbsolutePathName(".")

On Error Resume Next

sPHASE = oWshShell.RegRead("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Phase")
Select Case  sPHASE
	Case ""
		Call REMOVE 'Subroutine
	Case "1"
		Call REJOIN 'Subroutine
End Select

' **************************************************: 
' RESTART SYSTEM									:
' **************************************************:
Dim OpSysSet, OpSys
Set OpSysSet = GetObject("winmgmts:{(Shutdown)}//./root/cimv2").ExecQuery("select * from Win32_OperatingSystem where Primary=true")

For Each OpSys In OpSysSet
OpSys.Reboot()
Next
WScript.Quit

' **************************************************: 
' CREATE DIRECTORY [Name; Item; New Name] & Load	:
' **************************************************:
Sub REMOVE

	Dim oCompName, oTextStream, sArray, sLine, sNewName
	Dim oDictionary

	Set oDictionary = CreateObject("Scripting.Dictionary")
	Set oCompName = oFileSystem.GetFile(sProgramDir & "\" & "SYSTEM_NAME.txt")
	Set oTextStream = oCompName.OpenAsTextStream(1)

	Do While Not oTextStream.AtEndOfStream
		sLine = oTextStream.ReadLine
		sArray = Split(sLine, " = ", -1, 1)
		oDictionary.Add sArray(0), sArray(1)
		Loop
   		oTextStream.Close
	' ABORT IF SYSTEM LIST:
	If oDictionary.Exists(sCurrentName) = FALSE Then
		MsgBox("Error")
		WScript.Quit
	End If

	' RETRIEVE NEW SYSTEM NAME & PASS TO VARIABLE sNewName:
	sNewName = oDictionary.Item(sCurrentName)
	' COPY FILES TO LOCAL SYSTEM:
	oFileSystem.CopyFile sProgramDir & "\" & sProgram, sTempDir & "\" & sProgram
	oFileSystem.CopyFile sProgramDir & "\" & "NETDOM.EXE", sTempDir & "\" & "NETDOM.EXE"
	
	' BACKUP PREVIOUSE SYSTEM LOGON NAME:
	Dim sUserName
	
	sUserName = oWshShell.RegRead("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultUserName")
	oWshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\PreviousUser", sUserName

	' INCREMENT PHASE VALUE:
	oWshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Phase", 1
	' PLACE REFERENCE TO PROGRAM IN RUNONCE KEY:
	oWshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\RUN_RENAME", sTempDir & "\" & sProgram
	' ENABLE AUTO ADMIN LOGON:
	oWshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoAdminLogon", 1
	oWshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultUserName", "XXX"
	oWshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultPassword", "XXX"
	oWshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName", sNewName
	' EXECUTE NETDOM REMOVE
	oWshShell.Run sTempDir & "\" & "NETDOM.EXE REMOVE " & sCurrentName & " /D:XXX /Ud:XXX /Pd:XXX", 1, TRUE
	' RENAME SYSTEM:
	oWshShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName\ComputerName", sNewName
	oWshShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\NV Hostname", sNewName
	
End Sub

' **************************************************: 
' REJOIN SUB- REJOIN SYSTEM TO DOMAIN & CLEAN		:
' **************************************************:
Sub REJOIN

	' RESTORE PREVIOUS SYSTEM USER LOGON NAME:
	Dim sUserName
	sUserName = oWshShell.RegRead("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\PreviousUser")
	oWshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultUserName", sUserName
	' PARSE PHASE VALUE:
	oWshShell.RegDelete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Phase"
	' DISABLE AUTO ADMIN LOGON:
	oWshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoAdminLogon", 0
	oWshShell.RegDelete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultPassword"
	oWshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName", "XXX"
	' PASS CLEANUP ROUTINE KEY TO RUN ONCE KEY:
	Dim sCMD
	sCMD = "c:\winnt\system32\"
	oWshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\RUN_CLEANUP", sCMD & "CMD.EXE /c DEL " & sTempDir & "\" & sProgram
	' EXECUTE NETDOM JOIN:
	oWshShell.Run sTempDir & "\" & "NETDOM.EXE JOIN " & sCurrentName & " /D:XXX /Ud:XXX /Pd:XXX", 1, TRUE
	
End Sub
' **********************************:
' END OF SCRIPT						:
' **********************************: