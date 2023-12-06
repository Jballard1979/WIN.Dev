#-- ************************************************************************************************************:
#-- ********************************************* SYSTEM DISK SPACE ********************************************:
#-- ************************************************************************************************************:
#-- Author:		JBallard (JEB)											  										:
#-- Date:		2017.3.07											      										:
#-- Script:		SYS-DISC.SPACE.ps1																			    :
#-- Purpose:	A script that checks the Drive space of our SCADA System & writes the data to a jeb file		:
#-- Location:	\\10.65.5.25\SCADAsupport\JEB\0_SCRIPTS.Dev\01_DISC.SPACE.Dev\SYSTEM-DISC.SPACE.ps1				:
#-- Version:	1.0		  																						:
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#-- 
CLS
#--
#-- ********************************************************:
#-- DEFINE PARAMETERS & CONFIGURATION PATHS					:
#-- ********************************************************:
$Global:Servers    = Get-Content "SYS-SCADA.jeb"
$Global:ReportPath = "SYS-DISC.SPACE.log"
#--
$scriptblock = 
{
	param($SVR)
	#-- ****************************************************:
	#-- CUBE ( 1024 ) = 1073741824							:
	#-- ****************************************************:
	$CON2GB     = (1024 * 1024 * 1024)
	$PINGServer = Test-Connection -count 1 -ErrorAction SilentlyContinue $SVR | SELECT IPV4Address
	$DSK        = Get-WmiObject Win32_LogicalDisk -ComputerName $SVR -Filter "DeviceID='C:'" | SELECT-Object Size, FreeSpace
	$VAL        = @()
	if($Error)
	{
		if( $Error -like "*Access Denied*")
		{
			return ($SVR+",,AccessDenied")
		}
		$Error.Clear()
		return ($SVR+",,")
	}
	$VAL += ($SVR + ",		" + ($DSK.Size / $CON2GB) + ",		" + ($DSK.FreeSpace / $CON2GB) )  
	return $VAL
}
#--
#-- ****************************************************:
#-- RETRIEVE CONTENT & OUTPUT RESULTS					:
#-- ****************************************************:
function GETData
{
	$jobs = Get-Job | ? { $_.State -eq "Completed" }
	foreach( $job in $jobs)
	{
		$results = Receive-Job $job
		Add-Content $ReportPath $results
		Remove-Job $job
	}   
}
#--
Add-Content $ReportPath "--------------------------------------------------------"
Add-Content $ReportPath "SERVER:		    TOTAL:				    FREE:"
Add-Content $ReportPath "--------------------------------------------------------"
foreach($SVR in $SVRs)
{         
	while( (Get-Job).count -ge 12 )
	{
		sleep -Seconds 1
		GETData
	}
	Start-Job -ScriptBlock $scriptblock -ArgumentList $SVR
}
#--
while( (get-job).count -ne 12 )
{
	sleep -Seconds 5
	GETData
}
#--
#-- ********************************************************:
# 	END OF SCRIPT											:
#-- ********************************************************: