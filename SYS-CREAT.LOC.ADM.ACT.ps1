#-- ************************************************************************************************************:
#-- *************************************** CREATE LOCAL ADMIN ACCOUNTS ****************************************:
#-- ************************************************************************************************************:
#-- Author:  JBallard (JEB)                                                                                     :
#-- Date:    2023.6.15												      									    :
#-- Script:	 SYS-CREAT.LOC.ADM.ACT.ps1                                                                          :
#-- Purpose: A PS1 script that remotely creates Local Admin Accounts on all the I&C Systems.                    :
#-- Version: 1.0		  																						:
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ****************************************************:
#-- DEFINE PARAMS, CONFIG PATHS, IMPORT CLASSES         :
#-- ****************************************************:
$scriptPath  = SPLIT-PATH -PARENT $MyInvocation.MyCommand.Path
$systemsFile = JOIN-PATH $scriptPath "SYS-I&C.jeb"
$systems     = GET-CONTENT $systemsFile | CONVERTFROM-JSON
#--
#-- LOOP THROUGH & CREATE ACCOUNT ON THE NEXT SYSTEM:
foreach ($system in $systems)
{
    $session = NEW-PSSESSION -COMPUTERNAME $system.HOSTNAME -CREDENTIAL (GET-CREDENTIAL -USERNAME $system.Username -PASSWORD $system.Password)
    $scriptBlock = {
        param($NewUsername, $NewPassword)
        $userExists = GET-WMIOBJECT -CLASS Win32_UserAccount -FILTER "Name = '$NewUsername' AND LocalAccount = 'True'"
		#--
        if ($userExists -eq $null)
		{
            $user = ([adsi]"WinNT://./$NewUsername")
            $user.SetPassword($NewPassword)
            $user.SetInfo()
            WRITE-HOST "SUCCESSFULLY CREATED A LOCAL ADMIN ACCOUNT $NewUsername ON $env:COMPUTERNAME:"
        }
		else
		{
            WRITE-HOST "ERROR - FAILED TO CREATE LOCAL ADMIN ACCOUNT ON $env:COMPUTERNAME:"
        }
    }
    INVOKE-COMMAND -SESSION $session -SCRIPTBLOCK $scriptBlock -ARGUMENTLIST  $system.NewUsername, $system.NewPassword
    REMOVE-PSSESSION -SESSION $session
}
#--
#-- ****************************************************:
#-- END OF SCRIPT                                       :
#-- ****************************************************: