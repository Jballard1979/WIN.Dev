#-- ************************************************************************************************************:
#-- ********************************************* GEN LOCAL CREDS **********************************************:
#-- ************************************************************************************************************:
#-- Author:   JBallard (JEB)                                                                                    :
#-- Date:     2022.11.04                                                                                        :
#-- Script:   SYS-USR.CREDS.ps1                                                                                 :
#-- Purpose:  A PowerShell script that generates a new Local Admin suer & password.                             :
#-- Version:  1.0                                                                                               :
#-- Ranom PW: $GETRanPW = -JOIN([char[]](33..122) | GET-RANDOM -COUNT 10)                                       :
#-- Ranom PW: $JEBPass = ConvertTo-SecureString ($GETRanPW) -ASPLAINTEXT -FORCE                                 :
#-- Ranom PW: $GETRanPW = "Choo@Choo@1411"                                                                      :
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ********************************************************:
#-- DEFINE PARAMETERS & CONFIGURATION PATHS                 :
#-- ********************************************************:
$JEBPass = "PPPPP"
$JEBUsrName = 'Change_Before_FAT'
#--
#-- CREATE NEW LOCAL ACCOUNT & PW:
NEW-LOCALUSER -NAME $JEBUsrName -DESCRIPTION "LOCAL ADMINISTRATORS" -PASSWORD $JEBPass -ACCOUNTNEVEREXPIRES
ADD-LOCALGROUPMEMBER -GROUP 'Administrators' -MEMBER ($JEBUsrName) –VERBOSE
#--
#-- MODIFY WIN REGISTRY:
SET-ITEMPROPERTY -PATH "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -NAME "AutoAdminLogon" -VALUE 1
SET-ITEMPROPERTY -PATH "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -NAME "DefaultUsername" -VALUE $JEBUsrName -TYPE String
SET-ITEMPROPERTY -PATH "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -NAME "DefaultPassword" -VALUE $JEBPass -TYPE String
#--
#-- RESTART SYSTEM:
RESTART-COMPUTER -FORCE
#--
#-- ********************************************************:
#-- END OF POWERSHELL SCRIPT                                :
#-- ********************************************************: