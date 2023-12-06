#-- ************************************************************************************************************:
#-- ******************************************** SYSTEM DOMAIN TRUST *******************************************:
#-- ************************************************************************************************************:
#-- Author:		JBallard (JEB)											  										:
#-- Date:		2019.3.15											      										:
#-- Script:		SYSTEM-DOMAIN.TRUST.ps1																			:
#-- Purpose:	A script that resets the trust between the workstation account & the Domain controller			:
#-- Location:	\\10.65.5.25\SCADAsupport\JEB\0_SCRIPTS.Dev\10_SYSTEM.Dev\SYSTEM-DOMAIN.TRUST.ps1				:
#-- Version:	1.0		  																						:
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ****************************************************:
#-- DEFINE PARAMETERS & CONFIGURATION PATHS				:
#-- ****************************************************:
CLS
#-- TEST THE SECURE CHANNEL ON THE SYSTEM = TRUE:
Test-ComputerSecureChannel
#--
#-- RESET THE SECURE CHANNEL ON THE SYSTEM:
Test-ComputerSecureChannel -credential DEV\EXPAdmin -repair
#-- 
$credential = Get-Credential – (enter domain admin account when prompted)
#--
Reset-ComputerMachinePassword -Server PDCTSTDC1
#--
Invoke-Command -ComputerName PDCTSTDC1 -ScriptBlock { Test-ComputerSecure Channel }
	-Credential (Get-Credential -UserName 'administrator' -Message 'User')
1
Invoke-Command -ComputerName PDCTSTDC1 -ScriptBlock { Test-ComputerSecure Channel }
	-Credential (Get-Credential -UserName 'administrator' -Message 'User')
#--
$localCredential = Get-Credential
@(Get-AdComputer -Filter *).foreach({
    $output = @{ ComputerName = $_.Name }
    if (-not (Test-Connection -ComputerName $_.Name -Quiet -Count 1))
	{
		$output.Status = 'Offline'
    }
	else
	{
        $trustStatus = Invoke-Command -ComputerName $_.Name -ScriptBlock { Test-ComputerSecureChannel }
			-Credential $localCredential
        $output.Status = $trustStatus
    }
    [pscustomobject]$output
})
#-- ****************************************************:
#-- END OF SCRIPT										:
#-- ****************************************************: