#--
#-- ************************************************************************************************************:
#-- ****************************************** SEARCH DUPLICATE FILES ******************************************:
#-- ************************************************************************************************************:
#-- Author:   JBALLARD (JEB)                                                                                    :
#-- Date:     2023.3.07                                                                                         :
#-- Script:   WIN-PURGE.DUPS.py                                                                                 :
#-- Purpose:  A python script that scans a SCANDir & moves all the duplicate files.                             :
#-- Version:  1.0                                                                                               :
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ************************************************:
#-- IMPORT MODULES & CLASSES                        :
#-- ************************************************:
import os
import hashlib
import shutil
#--

#-- DEFINE SCAN & BACKUP DIRECTORIES:
SCANDir = "E:\FILE.MGT.Src\DUPS"
BAKDir = "E:\FILE.MGT.Src\DUPBACKUP"
#--
#-- GENERATE A NEW SCANDir FOR STORING DUPLICATE FILES:
hashes = {}
#--
#-- LOOP THROUGH ALL FILES IN SUB-SCANDir:
for filename in os.listdir(SCANDir):
    #--
    #-- RETRIEVE FULL PATH TO FILE:
    file_path = os.path.join(SCANDir, filename)
    if os.path.isfile(file_path):
        #--
        #-- CALCULATE MD5 HASH OF THE FILES CONTENT:
        with open(file_path, "rb") as f:
            file_hash = hashlib.md5(f.read()).hexdigest()
            #--
            #-- CHECK DICTIONARY FOR FILE HASH:
            if file_hash in hashes:
                #--
                #--  MOVE FILE TO BACKUP SCANDir:
                print(f"Moving {file_path} to {BAKDir}")
                shutil.move(file_path, BAKDir)
            else:
                #-- ADD ENTRY INTO DICTIONARY:
                hashes[file_hash] = file_path
#--
#-- ************************************************:
#-- END OF SCRIPT                                   :
#-- ************************************************: