#-- ************************************************************************************************************:
#-- ******************************************** MOD REMOTE GATEWAYS *******************************************:
#-- ************************************************************************************************************:
#-- Author:		JBallard (JEB)											  										:
#-- Date:		2019.7.12											      										:
#-- Script:		SYSTEM-MOD.GATEWAYS.ps1																			:
#-- Purpose:	A script that modifies the gateways of all SCADA hosts remotely									:
#-- Usage:		Run the script from the LAN's domain controller using PS>.\SYSTEM-MOD.GATEWAYS.ps1				:
#-- Version:	1.0		  																						:
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ********************************************************:
#-- DEFINE PARAMETERS & CONFIGURATION PATHS					:
#-- ********************************************************:
$OLDGate = "10.165.3.254"
$NEWGate = "10.165.3.1"
#--
SET-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted
Enter-PSSession -ComputerName 10.165.3.21
Enable-PSRemoting -Force
CD C:\NETWORK
#--
$DOMAINHost = Get-ADComputer -Filter * -Properties CN | SELECT CN
foreach ($Item in $DOMAINHost)
{
    $NET | ForEach-Object { [PSCustomObject]@{
    Gateway = $NEWGate } }
    $NET = Get-WMIObject win32_NetworkAdapterConfiguration -computer $Item.CN -Filter "IPEnabled = True and DHCPEnabled = False" | 
		Where-Object {$_.defaultIPGateway -eq $OLDGate}
    $NET | ForEach-Object { [PSCustomObject]@{
		ComputerName = $Item.CN;
		IPAddress = $_.IPaddress;
		SubnetMask = $_.IPSubnet;
		Gateway = $_.defaultIPGateWay } }
    $NET.SetGateways($NEWGate)
    $NET | ForEach-Object { [PSCustomObject]@{
        Gateway = $NEWGate } }
}
#--
#-- ********************************************************:
# 	END OF SCRIPT											:
#-- ********************************************************: