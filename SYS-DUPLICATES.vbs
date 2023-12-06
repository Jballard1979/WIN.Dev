' **************************************************************************************************************:
' ********************************************** SEARCH DUPLICATES *********************************************:
' **************************************************************************************************************:
' Author: 	JBallard (JEB)																						:
' Date:		2018.11.09																							:
' Script:	SYS-DUPLICATES.vbs																				    :
' Purpose:	A script to search a given directory for all duplicate file & folders								:
' Version:	1.0																									:
' **************************************************************************************************************:
' **************************************************************************************************************:
'
' **************************************************: 
' DEFINE PARAMETERS	& CONFIGURATION PATHS			:
' **************************************************:
SET OBJDir = CreateObject("Scripting.Dictionary")
SET OBJFileSysObj = CreateObject("Scripting.FileSystemObject")
SET OutPutFile = OBJFileSysObj.OpenTextFile("C:\0_SVN\4_LOGS\DUPLICATE.RESULTS.jeb")
'
STRStartFolder = "C:\0_SVN\3_PDCFILSVR1\SCADA"
'
Wscript.Echo "*** CLICK (OK) TO SEARCH FOR DUPLICATE FILESET OBJECTS! ***"
'
SET OBJFolder = OBJFileSysObj.GetFolder(STRStartFolder)
SET COLFiles = OBJFolder.Files
'
For Each OBJFile in COLFiles
    STRName = OBJFile.Name
    STRPath = OBJFile.Path
    If Not OBJDir.Exists(STRName) Then
        OBJDir.Add STRName, STRPath  
    Else
        OBJDir.Item(STRName) = OBJDir.Item(STRName) & ";" & STRPath
    End If
Next
'
ShowSubfolders OBJFileSysObj.GetFolder(STRStartFolder)
For Each strKey in OBJDir.Keys
    STRFileName = strKey
    If InStr(OBJDir.Item(STRFileName), ";") Then
        arrPaths = Split(OBJDir.Item(STRFileName), ";")
		Wscript.OutPutFile.WriteLine STRFileName
        For Each STRFilePath in arrPaths
			Wscript.OutPutFile.WriteLine strFilePath
        Next
		OutPutFile.Close
    End If
Next
'
Sub ShowSubFolders(Folder)
    For Each Subfolder in Folder.SubFolders
        Set OBJFolder = OBJFileSysObj.GetFolder(Subfolder.Path)
        Set COLFiles = OBJFolder.Files
		For Each OBJFile in COLFiles
			STRName = OBJFile.Name
			STRPath = OBJFile.Path
			STRName = OBJFile.Name & OBJFile.Size
			If Not OBJDir.Exists(STRName) Then
				OBJDir.Add STRName, STRPath  
			Else
				OBJDir.Item(STRName) = OBJDir.Item(STRName) & ";" & STRPath
			End If
		Next
			ShowSubFolders Subfolder
    Next
End Sub
'
objShell.run "notepad++.exe " & "C:\0_SVN\4_LOGS\DUPLICATE.RESULTS.jeb"
'
Wscript.Echo "SUCCESSFULLY SEARCHED FOR DUPLICATE FILESET OBJECTS:"
'
' CLEAN UP OBJECTS & EXIT APPLICATION:
Set objShell = Nothing
Set OBJFileSysObj = Nothing
'
' **********************************:
' END OF SCRIPT						:
' **********************************: