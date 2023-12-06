#-- ************************************************************************************************************:
#-- ****************************************** DUPLICATE FILE PARSER *******************************************:
#-- ************************************************************************************************************:
#-- Author:		JBallard (JEB)											  										:
#-- Date:		2018.11.09											      										:
#-- Script:		SYS.PARSER.ps1																		            :
#-- Purpose:	A script to search & parse a given directory of all duplicate files & folders					:
#-- Version:	1.0		  																						:
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ****************************************************:
#-- DEFINE PARAMETERS & CONFIGURATION PATHS				:
#-- ****************************************************:
Function Get-FolderName
{
	Add-Type -AssemblyName System.Windows.Forms
	$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
	[void]$FolderBrowser.ShowDialog()
	$FolderBrowser.SelectedPath
}
#--
$mypath = 'C:\0_SVN\3_PDCFILSVR1\SCADA'
#-- PARSE UNIQUE RECORDS BY SIZE [DIFFERENT SIZE = DIFFERENT HASH]:
$RUBySize = Get-ChildItem -path $mypath -Recurse -Include "*.*" | ? {( ! $_.ISPScontainer)} | Group Length | ? {$_.Count -gt 1} | Select -Expand Group | Select FullName, Length 
#--
#-- PARSE UNIQUE RECORDS BY HASH [GENERATES SHA-1 HASH & REMOVES UNIQUE RECORDS]:
$RUByHash = foreach ($i in $RUBySize)
{
	Get-FileHash -Path $i.Fullname -Algorithm SHA1
}
#--
#-- FILTER EMPTY DIRECTORIES & OUTPUT:
If ($RUByHash.count -eq 0)
{
	[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
	[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

	$objForm = New-Object System.Windows.Forms.Form
	$objForm.Text = "0 DUPLICATE FILES DISCOVERED:"
	$objForm.Size = New-Object System.Drawing.Size(300,100)
	$objForm.StartPosition = "CenterScreen"
	$objForm.KeyPreview = $True
	$objForm.Add_KeyDown({if ($_.KeyCode -eq "ENTER")
		{$x=$objTextBox.Text;$objForm.Close()}})
	$objForm.Add_KeyDown({if ($_.KeyCode -eq "ESCAPE")
		{$objForm.Close()}})
	$OKButton = New-Object System.Windows.Forms.Button
	$OKButton.Location = New-Object System.Drawing.Size(120,10)
	$OKButton.Size = New-Object System.Drawing.Size(40,30)
	$OKButton.Text = "OK"
	$OKButton.Add_Click({$x=$objTextBox.Text;$objForm.Close()})
	$objForm.Controls.Add($OKButton)
	$objForm.Topmost = $True
	$objForm.Add_Shown({$objForm.Activate()})
	[void] $objForm.ShowDialog()
}
#-- 
#-- MANAGE DUPLICATE FILES:
If ($RUByHash.count -gt 0)
{
	#-- RETRIEVE FILE STATUS:
	$Title1= $RUByHash.count| Out-String
	$Savings = ($RUBySize |select -Skip 1 | Measure-Object -property length -sum).Sum
	#-- DISPLAY OUTPUT USING A GRIDVIEW:
	$RUByHash|Out-GridView  -Title "$Title1 DUPLICATE FILES ARE CONSUMING - $Savings bytes" -PassThru
	#-- DECISION TO PARSE DUPLICATE FILES:
	$RUByHash|select -Skip 1|Remove-Item -Confirm
}
#--
#-- ****************************************************:
#-- END OF SCRIPT										:
#-- ****************************************************: