#--
#-- ************************************************************************************************************:
#-- ********************************************* PURGE TEMP DIR ***********************************************:
#-- ************************************************************************************************************:
#-- Author:   JBALLARD (JEB)                                                                                    :
#-- Date:     2023.3.23                                                                                         :
#-- Script:   SYS-PURGE.TMP.py                                                                                  :
#-- Purpose:  A python script that purges the contents with the Windows Temp Directory.                         :
#-- Version:  1.0                                                                                               :
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ****************************************************:
#-- DEFINE PARAMES, CONFIGS, IMPORT MODULES & CLASSES   :
#-- ****************************************************:
import shutil
import os
#--
#-- RETRIEVE PATH TO TEMP DIR:
temp_dir = os.environ["temp"]
#--
#-- PURGE CONTENTS WITHIN TEMP DIR:
for file in os.listdir(temp_dir):
    file_path = os.path.join(temp_dir, file)
    try:
        if os.path.isfile(file_path):
            os.unlink(file_path)
        elif os.path.isdir(file_path):
            shutil.rmtree(file_path)
    except Exception as e:
        print(e)
#--
#-- ****************************************************:
#-- END OF PYTHON SCRIPT                                :
#-- ****************************************************: