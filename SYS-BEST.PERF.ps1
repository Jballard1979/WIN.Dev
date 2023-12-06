#-- ************************************************************************************************************:
#-- ********************************************* BEST PERFORMANCE *********************************************:
#-- ************************************************************************************************************:
#-- Author:     JBallard (JEB)                                                                                  :
#-- Date:       2020.3.11                                                                                       :
#-- Script:     SYSTEM-BEST.PERF.ps1                                                                            :
#-- Purpose:    A PowerShell script to configure Windows to Adjust setting to Best Performance.                 :
#-- Version:    1.0                                                                                             :
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ****************************************************:
#-- DEFINE PARAMETERS                                   :
#-- ****************************************************:
$REGPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects'
try
{
    $GETItem = (GET-ItemProperty -ErrorAction STOP -NAME visualfxsetting -PATH $REGPath).VisualFXSetting 
    if ($GETItem -ne 2)
	{
		SET-ItemProperty -PATH $REGPath -NAME 'VisualFXSetting' -VALUE 2
		SET-Service -Name "THEMES" -STATUS STOPPED -STARTUPTYPE DISABLED
    }
}
catch
{
	NEW-ItemProperty -PATH $REGPath -NAME 'VisualFXSetting' -VALUE 2 -PropertyType 'DWORD'
}
#--
#-- ****************************************************:
#--	END OF SCRIPT                                       :
#-- ****************************************************: