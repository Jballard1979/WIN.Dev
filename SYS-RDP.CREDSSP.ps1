#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#-- Author:   JBallard (JEB)                                                                                    :
#-- Date:     2019.3.16                                                                                         :
#-- Script:   SYSTEM-RDP.CREDSSP.ps1                                                                            :
#-- Purpose:  A script that bypasses the Credential Security Support Provider Protocol (CredSSP) Authorization  :
#-- Version:  1.0                                                                                               :
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ****************************************************:
#-- DEFINE PARAMETERS & CONFIGURATION PATHS             :
#-- ****************************************************:
$RegRootPath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\'
#--
#-- VERIFY TEST PATH:
if (!(test-path -path $RegRootPath)) 
{
	New-Item -Path $RegRootPath | out-null
}
#--
#-- VERIFY CREDSSP INJECTION IN TEST PATH:
if (!(test-path -path ($RegRootPath + "\CredSSP"))) 
{
	New-Item -Path ($RegRootPath + "\CredSSP") | out-null
}
#--
#-- SET FINAL PATH WHERE REGISTRY ITEM WILL BE INJECTED:
$RegFinalPath = ($RegRootPath + "\CredSSP\Parameters")
if (!(test-path -path $RegFinalPath))
{
	New-Item -Path $RegFinalPath | out-null
}
#--
#-- DISABLE NOTIFICATIONS & REBOOT REQUEST:
if (get-itemproperty -path $RegFinalPath -name "AllowEncryptionOracle" -ErrorAction SilentlyContinue)
{
	#-- IMPLEMENT CREDSSP VULNERABILITY:
	Set-ItemProperty -Path $RegFinalPath -name "AllowEncryptionOracle" -Value 2 | out-null
}
else
{
	#-- ADD VULNERABILITY TO WINDOWS REGISTRY TABLE:
	New-ItemProperty -Path $RegFinalPath -name "AllowEncryptionOracle" -PropertyType Dword -Value 2 | out-null
}
#--
#-- ****************************************************:
#-- END OF SCRIPT                                       :
#-- ****************************************************: