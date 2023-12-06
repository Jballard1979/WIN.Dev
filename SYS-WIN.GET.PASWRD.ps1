#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#-- Author:		JBallard (JEB)											  										:
#-- Date:		2017.12.01												      									:
#-- Script:		SYSTEM-WIN.GET.PASWRD.ps1																		:
#-- Purpose:	A Script to extrapolate the credentials from Windows Credential Manager							:
#-- Version:	1.0		  																						:
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ****************************************************:
#-- DEFINE PARAMETERS & CONFIGURATION PATHS				:
#-- ****************************************************:
[void]
#--
[Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]
$vault = New-Object Windows.Security.Credentials.PasswordVault 
$vault.RetrieveAll() | % { $_.RetrievePassword();$_ | SELECT Resource, UserName, Password | Sort-Object Resource | ft -AutoSize }
PAUSE
#--
#-- ****************************************************:
#-- END OF SCRIPT										:
#-- ****************************************************: