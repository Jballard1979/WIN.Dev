#-- ************************************************************************************************************:
#-- ************************************************ CREATE NEW VM *********************************************:
#-- ************************************************************************************************************:
#-- Author:		JBallard (JEB)											  										:
#-- Date:		2019.7.31											      										:
#-- Script:		SYSTEM-NEW.NIC.TEAM.ps1																			:
#-- Purpose:	A PowerShell script that enables the Network Adapters & configures them for NIC Teaming			:
#-- Version:	1.0		  																						:
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ************************************************:
#-- DEFINE PARAMETERS & CONFIGURATION PATHS			:
#-- ************************************************:
#-- FORCE EXECUTION POLICY:
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;
#-- IMPORT INTEL CMDLET MODULE:
Import-Module -Name "C:\Program Files\Intel\Wired Networking\IntelNetCmdlets\IntelNetCmdlets"
#--
#-- SLEEP 5 SECONDS:
Start-Sleep -s 5
#--
#-- ENABLE NETWORK ADAPTERS:
Enable-NetAdapter -Name "LAN A"
Enable-NetAdapter -Name "LAN B"
#--
#-- SLEEP 5 SECONDS:
Start-Sleep -s 5
#--
#-- SET NIC TEAM:
New-NetSwitchTeam -Name "SCADA_LAN" -TeamMembers "LAN A","LAN B"
#--
Get-IntelNetAdapter
#--
#-- ************************************************:
#-- END OF SCRIPT									:
#-- ************************************************: