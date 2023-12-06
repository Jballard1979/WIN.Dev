#-!/usr/bin/env python3
#- -*- coding: Latin-1 -*-
#-
#- **************************************************************************************************************:
#- *********************************************** PURGE DIRECTORY **********************************************:
#- **************************************************************************************************************:
#- Author:  JBallard (JEB)                                                                                       :
#- Date:    2017.3.11                                                                                            :
#- Script:  WIN-PURGE.DIRS.py                                                                                    :
#- Purpose:	A python script that purges all files & folders in specified directory.                              :
#- Ver:     1.0                                                                                                  :
#- **************************************************************************************************************:
#- **************************************************************************************************************:
#-
#- *************************************************:
#- DEFINE PARAMETERS & CONFIGURATION PATHS          :
#- *************************************************:
import win32con
import win32api
import os
#-
def del_dir(self,path):
	for file in os.listdir(path):
		file_or_dir = os.path.join(path,file)
		if os.path.isdir(file_or_dir) and not os.path.islink(file_or_dir):
			del_dir(file_or_dir)
		else:
			try:
				os.remove(file_or_dir)
			except:
				win32api.SetFileAttributes(file_or_dir, win32con.FILE_ATTRIBUTE_NORMAL)
				os.remove(file_or_dir)
		os.rmdir(path)
#-
#- *************************************************:
#- END OF SCRIPT                                    :
#- *************************************************:
