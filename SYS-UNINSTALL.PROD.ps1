#-- ************************************************************************************************************:
#-- ****************************************** RETRIEVE PRODUCT CODES ******************************************:
#-- ************************************************************************************************************:
#-- Author:		JBallard (JEB)											  										:
#-- Date:		2018.12.19												      									:
#-- Script:		SYSTEM-UNINSTALL.PROD.ps1																		:
#-- Effort:		A script that uninstalls the desired software from Windows using the product codes				:
#-- Example:	MSIExec /x "{20888FA1-8127-42E3-969F-9BF93245AC83}"												:
#-- Ver:		1.0		  																						:
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ****************************************************:
#-- DEFINE PARAMETERS & CONFIGURATION PATHS				:
#-- ****************************************************:
$DevDir = "C:\0_SVN\4_LOGS\UNINSTALLER"
$Systems = "LOCALHOST"
#--
#-- ENTER THE DESIRED SOFTWARE PACKAGE:
$Uninstall = "Microsoft SQL Server"
#--
#-- ********************************************:
#-- REMOVE WINDOWS SOFTWARE COMPONENTS			:
#-- ********************************************:
ForEach ($Computer in $Systems)
{
    IF ($Computer -like '*')
    {
        Write-host "COLLECTING INSTALLED SOFTWARE PACKAGES:"
		$a = .$DevDir\msiinv -s | SELECT-STRING $Uninstall -CONTEXT 1, 1;
		$a = $a -REPLACE ">", "REM";
		$a = $a -REPLACE "\t", "";
		$a = $a -REPLACE "}","}"" /quiet";
		$a = $a -REPLACE "  Product code:{","MSIExec /x ""{";
		$a | OUT-FILE $DevDir\SYSTEM.UNINSTALL.cmd -ENCODING ascii;
        #--
		#-- POPULATE UNINSTALL COMMAND STRINGS:
		WRITE-HOST "EXECUTING 1ST PASS:"
		START-PROCESS -FILEPATH $DevDir\SYSTEM.UNINSTALL.cmd -VERB runas
		WRITE-HOST "EXECUTING 2ND PASS:"
		START-PROCESS -FILEPATH $DevDir\SYSTEM.UNINSTALL.cmd -VERB runas
	}
}
#--
#-- ****************************************************:
#-- END OF SCRIPT										:
#-- ****************************************************: