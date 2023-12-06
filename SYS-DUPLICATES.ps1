#-- ************************************************************************************************************:
#-- *************************************** PDCFILESVR1 DUPLICATE PARSER ***************************************:
#-- ************************************************************************************************************:
#-- Author:		JBallard (JEB)											  										:
#-- Date:		2018.11.09											      										:
#-- Script:		SYS-DUPLICATES.ps1																			    :
#-- Purpose:	A script to search & parse a given directory of all duplicate file & folders					:
#-- Version:	1.0		  																						:
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:

#-- ****************************************************:
#-- DEFINE PARAMETERS & CONFIGURATION PATHS				:
#-- ****************************************************:
$Path = 'C:\0_SVN\3_PDCFILSVR1\SCADA'
#--
$Files = gci -File -Recurse -path $Path | Select-Object -property FullName,Length
$Count = 1
$TotalFiles=$Files.Count
$MatchedSourceFiles=@()
#--
#-- LOOP THROUGH SOURCE FILES:
ForEach ($SourceFile in $Files)
{
	Write-Progress -Activity "PROCESSING FILES" -status "PROCESSING FILE $Count / $TotalFiles" -PercentComplete ($Count / $TotalFiles * 100)
	$MatchingFiles = @()
	$MatchingFiles = $Files |Where-Object {$_.Length -eq $SourceFile.Length}
	#-- LOOP THROUGH TARGET FILES:
	Foreach ($TargetFile in $MatchingFiles)
	{
		if (($SourceFile.FullName -ne $TargetFile.FullName) -and !(($MatchedSourceFiles |
			Select-Object -ExpandProperty File) -contains $TargetFile.FullName))
		{
			Write-Verbose "MATCHING $($SourceFile.FullName) & $($TargetFile.FullName)"
			Write-Verbose "DISCOVERED SIZE MATCH:"
			if ((fc.exe /A $SourceFile.FullName $TargetFile.FullName) -contains "FC: 0 MATCHES DISCOVERED:")
			{
				Write-Verbose "DISCOVERED MATCH:"
				$MatchingFiles+=$TargetFile.FullName
			}
		}
	}
	if ($MatchingFiles.Count -gt 0)
	{
		$NewObject=[pscustomobject][ordered]@{
			File=$SourceFile.FullName
			MatchingFiles=$MatchingFiles
	}
		$MatchedSourceFiles+=$NewObject
	}
	$Count+=1
}
$MatchedSourceFiles
#--
Read-Host -Prompt "PRESS THE ENTER KEY TO CONTINUE1:"
Write-Host "PRESS THE ENTER KEY TO CONTINUE2:"
[void][System.Console]::ReadKey($true)
#--
#-- ****************************************************:
#-- END OF SCRIPT										:
#-- ****************************************************: