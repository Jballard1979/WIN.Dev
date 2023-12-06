#- *************************************************************************************************************:
#- **************************************** RETRIEVE SPECIFIC FILE TYPES ***************************************:
#- *************************************************************************************************************:
#- Author:  JBallard (JEB)                                                                                      :
#- Date:    2019.3.16                                                                                           :
#- Script:  WIN-GET.FILE.TYPE.py                                                                                :
#- Purpose: A Python Script that searches for a specific file type.                                             :
#- Usage:   File Types - JPEG; PNG; TIFF; GIF; PDF; JEB; XML; DOCX; XLS; XLSX; XLSM; VSD; M4A; MP3; WAV         :
#- Version: 1.0                                                                                                 :
#- *************************************************************************************************************:
#- *************************************************************************************************************:
#-
#- *************************************************:
#- DEFINE PARAMETERS & CONFIGURATION PATHS          :
#- *************************************************:
import fnmatch
import os
#-
SRCHPath = 'C:/0_SVN/'
EXT = '*.jpg'
#-
for root, dirs, files in os.walk(SRCHPath):
    for filename in fnmatch.filter(files, EXT):
        print( os.path.join(root, filename) )
#-
#- *************************************************:
#- END OF PYTHON SCRIPT                             :
#- *************************************************: