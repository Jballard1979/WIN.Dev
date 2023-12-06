#--
#-- ************************************************************************************************************:
#-- ********************************************** TRUNCATE FILES **********************************************:
#-- ************************************************************************************************************:
#-- Author:   JBALLARD (JEB)                                                                                    :
#-- Date:     2023.9.12                                                                                         :
#-- Script:   DNA-TRUNCATION.py                                                                                 :
#-- Purpose:  A python script that scans Directory Paths for files/folders older than x days & purges them.     :
#-- Version:  1.0                                                                                               :
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- *************************************************:
#-- DEFINE PARAMS, CONFIG PATHS, IMPORT CLASSES      :
#-- *************************************************:
import os
import shutil
import datetime
#--
#-- SET TRUNCATE DIRECTORIES:
DIRPaths = [
    'C:/WINDOWS/TEMP/',
    'C:/WINDOWS/Prefetch/',
    'C:/WINDOWS/SoftwareDistribution/DOWNLOAD/',
    'C:/Users/jballard-admin/AppData/Local/TEMP/',
    'C:/Users/jballard-admin/AppData/Local/Downloaded Installations/',
    'C:/Users/jballard/AppData/Local/Downloaded Installations/',
    'C:/Users/jballard/AppData/Local/TEMP/',
    'C:/Users/jballard-admin/Pictures/',
    'C:/Users/jballard-admin/Videos/',
    'C:/Users/jballard/Pictures/',
    'C:/Users/jballard/Videos/',
    ]
#--
#-- AGE OF FILES/FOLDERS TO TRUNCATE:
MAXAgeDays = 0
#--
#-- CALCULATE CUTOFF DATE & ITERATE THROUGH FILES WITHIN DIRECTORY::
CUTOFFDate = datetime.datetime.now() - datetime.timedelta(days=MAXAgeDays)
#-- ITERATE THROUGH EACH DIRECTORY PATH:
for DIRPath in DIRPaths:
    #--
    #-- VERIFY DIR EXISTS:
    if os.path.exists(DIRPath):
        #-- ITERATE THROUGH ITEMS IN DIR:
        for item in os.listdir(DIRPath):
            ITEMPath = os.path.join(DIRPath, item)
            #--
            #-- VERIFY ITEM IS A DIR:
            if os.path.isdir(ITEMPath):
                #-- RETRIEVE LAST MOD TIME OF DIR:
                DIRMTime = datetime.datetime.fromtimestamp(os.path.getmtime(ITEMPath))
                #--
                #-- COMPARE MOD TIME WITH CUTOFF DATE:
                if DIRMTime < CUTOFFDate:
                    try:
                        #-- ATTEMPT TO PURGE DIR & ALL CONTENTS:
                        shutil.rmtree(ITEMPath)
                        print(f"SUCCESS - TRUNCATED DIRECTORY - {item} (LAST MODIFIED - {DIRMTime})")
                    except Exception as e:
                        print(f"FAILURE - TRUNCATING DIRECTORY - {item}: {e}")
            #--
            #-- VERIFY ITEM IS A FILE:
            elif os.path.isfile(ITEMPath):
                #-- RETRIEVE LAST MOD TIME OF FILE:
                FILEMTime = datetime.datetime.fromtimestamp(os.path.getmtime(ITEMPath))
                #--
                #-- COMPARE MOD TIME WITH CUTOFF DATE:
                if FILEMTime < CUTOFFDate:
                    try:
                        #-- TRUNCATE FILE:
                        os.remove(ITEMPath)
                        print(f"SUCCESS - TRUNCATED FILE - {item} (LAST MODIFIED - {FILEMTime})")
                    except Exception as e:
                        print(f"FAILURE - TRUNCATING FILE - {item}: {e}")
    else:
        print(f"NOTE - DIRECTORY NOT FOUND: {DIRPath}")
#-- *************************************************:
#-- END OF SCRIPT                                    :
#-- *************************************************: