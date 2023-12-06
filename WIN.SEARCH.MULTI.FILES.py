#--
#-- ************************************************************************************************************:
#-- ****************************************** SEARCH MULTIPLE FILES *******************************************:
#-- ************************************************************************************************************:
#-- Author:   JBALLARD (JEB)                                                                                    :
#-- Date:     2023.3.29                                                                                         :
#-- Script:   WIN-SEARCH.MULTI.FILES.py                                                                         :
#-- Purpose:  A python script that String Searches from Multiple Files.                                         :
#-- Version:  1.0                                                                                               :
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- *************************************************:
#-- DEFINE PARAMS, CONFIG PATHS, IMPORT CLASSES      :
#-- *************************************************:
import os
text = input("PLEASE INPUT TEXT :")
path = input("PATH : ")
#--
#-- os.chdir(path)
def getfiles(path):
    f = 0
    os.chdir(path)
    files = os.listdir()
    #--
    #-- print(files)
    for file_name in files:
        abs_path = os.path.abspath(file_name)
        #--
        if os.path.isdir(abs_path):
            getfiles(abs_path)
        #--
        if os.path.isfile(abs_path):
            f = open(file_name, "r")
            #--
            if text in f.read():
                f = 1
                #--
                print(text + " FOUND:")
                #--
                final_path = os.path.abspath(file_name)
                #--
                print(final_path)
                return True
#--
    if f == 1:
        print(text + " NOT FOUND:")
        return False

getfiles(path
#--
#-- *************************************************:
#-- END OF SCRIPT                                    :
#-- *************************************************:
