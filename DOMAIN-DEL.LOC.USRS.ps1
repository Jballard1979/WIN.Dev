#--
#-- ************************************************************************************************************:
#-- **************************************** DELETE LOCAL USER ACCOUNTS ****************************************:
#-- ************************************************************************************************************:
#-- Author:  JBallard (JEB)                                                                                     :
#-- Date:    2022.4.14                                                                                          :
#-- Script:  DOMAIN-DEL.LOC.USRS.ps1                                                                            :
#-- Purpose: A PowerShell script deletes local user accounts on Domain Systems.                                 :
#-- Version:    1.0                                                                                             :
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ****************************************************:
#-- DEFINE PARAMETERS & ASSIGN VARS                     :
#-- ****************************************************:
IMPORT-MODULE ACTIVEDIRECTORY
#--
#-- LOOP THROUGH SYSTEMS:
foreach ($computer in $computers)
{
    $ADUSERS = GET-WMIOBJECT -CLASS WIN32_USERACCOUNT -COMPUTERNAME $computer
}
#--
#-- FILTER:
$ADACTS2DEL = $ADUSERS | WHERE-OBJECT { $_.LocalAccount -eq $TRUE -AND $_.Name -LIKE "user*" }
#--
#-- LOOP THROUGH & DELETE ALL LOCAL USER ACCOUNTS:
foreach ($user in $ADACTS2DEL)
{
    REMOVE-WMIOBJECT -INPUTOBJECT $user
}
#-- ****************************************************:
#-- END OF POWERSHELL SCRIPT                            :
#-- ****************************************************: