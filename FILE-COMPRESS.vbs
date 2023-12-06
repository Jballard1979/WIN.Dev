' **************************************************************************************************************:
' ********************************************** COMPRESS FOLDERS **********************************************:
' **************************************************************************************************************:
' Author: 	JBallard (JEB)																						:
' Date:		2018.12.03																							:
' Script:	FILE-COMPRESS.vbs																					:
' Purpose:	A VBScript that zips all files found within the current directory structure							:
' Usage: 	Place this script in the directory you wish to decompress & execute using WScript					: 
' Version:	1.0																									:
' **************************************************************************************************************:
' **************************************************************************************************************:
'
' **************************************************: 
' DEFINE PARAMETERS	& CONFIGURATION PATHS			:
' **************************************************:
OPTION EXPLICIT
'
DIM ObjFSO, WshShell, MaxAge, includeSubfolders
DIM oFSO : Set oFSO = CreateObject("Scripting.FileSystemObject")
DIM StrExtensionsToZip, StrFolder : StrFolder = oFSO.GetParentFolderName(WScript.ScriptFullName)
'
' DIRECTORY TO ZIP, INCLUDE SUB DIRECTORIES, & EXTENSIONS TO ZIP:
WScript.Echo "DIR= " & StrFolder
includeSubfolders = TRUE
StrExtensionsToZip = "txt,cmd,bat,vbs,jeb,doc,docx,reg,xls,xlsx,log,py,pl,xml,sql,sh,vsd,pdf"
' AGE OF FILE - ZIP FILES > THE MaxAge VARIABLE:
MaxAge = 0
'
Set ObjFSO = createobject("Scripting.FileSystemObject")
Set WshShell = WScript.CreateObject("WScript.Shell")
ZipFiles StrFolder, StrExtensionsToZip, MaxAge, includeSubfolders
'
WScript.Echo "" & date & ": " & time & " - " & "UNZIPPED ALL COMPRESSED FILES:"
Sub ZipFiles(byval StrDirectory,byval StrExtensionsToZip,byval MaxAge, includeSubfolders)
    DIM ObjFolder, ObjSubFolder, ObjFile
    DIM StrExt, OExec, StrCommand
    Set ObjFolder = ObjFSO.GetFolder(StrDirectory)
    For Each ObjFile In ObjFolder.Files
        For Each StrExt In SPLIT(UCASE(StrExtensionsToZip),",")
            IF RIGHT(UCASE(ObjFile.Path),LEN(StrExt)+1) = "." & StrExt THEN
                IF ObjFile.DateLastModified < (Now - MaxAge) THEN
                    WScript.Echo "Zipping: " & ObjFile.Path
					StrCommand = """C:\Program Files\7-Zip\7z.exe"" a -tzip """ & _
						ObjFSO.GetParentFolderName(ObjFile) & "\" & ObjFSO.GetBaseName(ObjFile) & ".7z"" """ & ObjFile.Path & """"
					WshShell.Run StrCommand,0,True
					WScript.Sleep 5000
                    ObjFile.Delete
                    Exit For
                End IF
            End IF
        Next
    Next
	' EXECUTE A RECURSIVE DELETE:
    IF includeSubfolders = True THEN
        For Each ObjSubFolder In ObjFolder.SubFolders
            ZipFiles ObjSubFolder.Path,StrExtensionsToZip,MaxAge, includeSubfolders
        Next
    End IF
End Sub
'
' **************************************************: 
' END OF SCRIPT										:
' **************************************************: