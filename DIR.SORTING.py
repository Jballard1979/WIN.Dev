#--
#-- ************************************************************************************************************:
#-- ********************************************* SORT DIRECTORY ***********************************************:
#-- ************************************************************************************************************:
#-- Author:   JBALLARD (JEB)                                                                                    :
#-- Date:     2023.3.07                                                                                         :
#-- Script:   DIR-SORTING.py                                                                                    :
#-- Purpose:  A python script that sorts files in a directory.                                                  :
#-- Version:  1.0                                                                                               :
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- *************************************************:
#-- DEFINE PARAMS, CONFIG PATHS, IMPORT CLASSES      :
#-- *************************************************:
#-- PYTHON -m PIP INSTALL os
import os
from shutil import move
def sort_files(directory_path):
for filename in os.listdir(directory_path):
if os.path.isfile(os.path.join(directory_path, filename)):
file_extension = filename.split('.')[-1]
destination_directory = os.path.join(directory_path, file_extension)
if not os.path.exists(destination_directory):
os.makedirs(destination_directory)
move(os.path.join(directory_path, filename), os.path.join(destination_directory, filename))
#--
#-- ************************************************:
#-- END OF SCRIPT                                   :
#-- ************************************************: