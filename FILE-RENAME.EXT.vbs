' **************************************************************************************************************:
' ******************************************** RENAME FILE EXTENSIONS ******************************************:
' **************************************************************************************************************:
' Author:	JBallard (JEB)																						                      :
' Date:		2021.1.25																							                      :
' Script:	FILE-RENAME.EXT.vbs																					                   :
' Purpose:	A script to rename all file extensions within a directory											          :
' Version:	1.0																									                      :
' **************************************************************************************************************:
' **************************************************************************************************************:
'
' **************************************************: 
' DEFINE PARAMETERS	& CONFIGURATION PATHS			 :
' **************************************************:
sVBSPath = Left(WScript.ScriptFullName,(Len(WScript.ScriptFullName) _
	- (Len(WScript.ScriptName) + 1)))
WITH createobject("wscript.shell")
   .currentdirectory = sVBSPath
   .run "%comspec% /c ren *.bat *.cmd", 0, TRUE
END WITH
'
' **************************************************:
' END OF SCRIPT										       :
' **************************************************: