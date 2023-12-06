' **************************************************************************************************************:
' **************************************************************************************************************:
' Author: 	JBallard (JEB)																						:
' Script:	SYSTEM-WIN.10.PRIVACY.vbs																			:
' Date:		2017.10.20																							:
' Purpose:	A script that modifies the privacy settings in Windows 10											:
' Version:	1.0																									:
' **************************************************************************************************************:
' **************************************************************************************************************:
'
' **************************************************: 
' DEFINE PARAMETERS	& CONFIGURATION PATHS			:
' **************************************************:
Set WSHShell = CreateObject("WScript.Shell")

On Error Resume Next

' **************************************************: 
' PARSE OUT UNWANTED REGISTRY ENTRIES				:
' **************************************************:

'#delete key disable using your machine for sending windows updates to others

WSHShell.RegDelete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config\DownloadMode"

'#delete disable sending settings to cloud

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync\DisableSettingSync"

'#delete disable syncronizing files to cloud

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync\DisableSettingSyncUserOverride"

'#delete disable ad customization

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo\DisabledByGroupPolicy"

'#delete disable data collection and sending to MS

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection\AllowTelemetry"

'#delete disable sending files to encrypted drives

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices\TCGSecurityActivationDisabled"

'#delete disable sync files to one drive

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC"

'#delete disable certificate revocation check

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\codeidentifiers\authenticodeenabled"

'#delete disable send additional info with error reports

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting\DontSendAdditionalData"

'#delete disable cortana in windows search

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowCortana"

'#delete disable web search in search bar

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\DisableWebSearch"

'#delete disable seach web when searching pc

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\ConnectedSearchUseWeb"

'#delete disable search indexing

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowIndexingEncryptedStoresOrItems"

'#delete disable location based info in searches

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowSearchToUseLocation"

'#delete disable language detection

WSHShell.RegDelete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AlwaysUseAutoLangDetection"

' **************************************************: 
' WRITE NEW REGISTRY ENTRIES						:
' **************************************************:

'#write disable using your machine for sending windows updates to others

WSHShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config\DownloadMode", 0,"REG_DWORD"

'#write disable sending settings to cloud

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync\DisableSettingSync", 2,"REG_DWORD"

'#write disable syncronizing files to cloud

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync\DisableSettingSyncUserOverride", 1,"REG_DWORD"

'#write disable ad customization

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo\DisabledByGroupPolicy", 1,"REG_DWORD"

'#write disable data collection and sending to MS

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection", 0,"REG_DWORD"

'#write disable sending files to encrypted drives

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices\TCGSecurityActivationDisabled", 0,"REG_DWORD"

'#write disable sync files to one drive

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 1,"REG_DWORD"

'#write disable certificate revocation check

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\codeidentifiers\authenticodeenabled", 0,"REG_DWORD"

'#write disable send additional info with error reports

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting\DontSendAdditionalData", 1,"REG_DWORD"

'#write disable cortana in windows search

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowCortana", 0,"REG_DWORD"

'#write disable web search in search bar

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\DisableWebSearch", 1,"REG_DWORD"

'#write disable seach web when searching pc

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\ConnectedSearchUseWeb", 0,"REG_DWORD"

'#write disable search indexing

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowIndexingEncryptedStoresOrItems", 0,"REG_DWORD"

'#write disable location based info in searches

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowSearchToUseLocation", 0,"REG_DWORD"

'#write disable language detection

WSHShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AlwaysUseAutoLangDetection", 0,"REG_DWORD"

Set WSHShell = Nothing﻿
' **********************************:
' END OF SCRIPT						:
' **********************************: