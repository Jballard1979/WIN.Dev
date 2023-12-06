' **************************************************************************************************************:
' **************************************************************************************************************:
' Author: 	JBallard (JEB)																						:
' Script:	SYSTEM-WIN.PROD.ID.vbs																				:
' Date:		2017.10.19																							:
' Purpose:	A VBScript that populates the Windows Product Key via Message Box									:
' Version:	1.0																									:
' **************************************************************************************************************:
' **************************************************************************************************************:
'
' **************************************************: 
' DEFINE PARAMETERS	& CONFIGURATION PATHS			:
' **************************************************:
Set WshShell = CreateObject("WScript.Shell")
MsgBox ConvertToKey(WshShell.RegRead("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DigitalProductId"))

Function ConvertToKey(Key)
'
	Const KeyOffset = 52
	'
	i = 28
	Chars = "BCDFGHJKMPQRTVWXY2346789"
	Do
		Cur = 0
		x = 14
	Do
	Cur = Cur * 256
	Cur = Key(x + KeyOffset) + Cur
	Key(x + KeyOffset) = (Cur \ 24) And 255
	Cur = Cur Mod 24
	x = x -1
	Loop While x >= 0
		i = i -1
		KeyOutput = Mid(Chars, Cur + 1, 1) & KeyOutput
		If (((29 - i) Mod 6) = 0) And (i <> -1) Then
			i = i -1
			KeyOutput = "-" & KeyOutput
		End If
	Loop While i >= 0
		ConvertToKey = KeyOutput
'
End Function
'
' **********************************:
' END OF SCRIPT						:
' **********************************: