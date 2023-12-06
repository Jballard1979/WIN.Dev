#-- ************************************************************************************************************:
#-- **************************************** UNINSTALLER MICROSOFT EDGE ****************************************:
#-- ************************************************************************************************************:
#-- Author:   JBallard (JEB)                                                                                    :
#-- Date:     2022.11.02                                                                                        :
#-- Script:   SYS-UNINSTALL.MS.EDGE.ps1                                                                         :
#-- Effort:   A script that uninstalls Microsoft Edge from our SCADA Systems.                                   :
#-- Ver:      1.0                                                                                               :
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ****************************************************:
#-- DEFINE PARAMETERS & CONFIGURATION PATHS             :
#-- ****************************************************:
#-- GET-APPXPACKAGE -Name "EDGE"
$MSEdgeVer = (GET-APPXPACKAGE "Microsoft.MicrosoftEdge.Stable" -ALLUSERS).Version
$MSEdgePath = ${env:ProgramFiles(x86)} + '\Microsoft\Edge\Application\' + $MSEdgeVer + '\Installer\SETUP.exe'
    & $MSEdgePath --UNINSTALL --SYSTEM-LEVEL --VERBOSE-LOGGING --FORCE-UNINSTALL
#--
#-- ****************************************************:
#-- END OF POWERSHELL SCRIPT                            :
#-- ****************************************************: