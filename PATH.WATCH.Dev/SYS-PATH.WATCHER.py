#--!/usr/bin/env python3
#-- -*- coding: Latin-1 -*-
#--
#-- **************************************************************************************************************:
#-- ************************************************* PATH WATCHER ***********************************************:
#-- **************************************************************************************************************:
#-- Author:  JBallard (JEB)                                                                                       :
#-- Date:    2017.3.11                                                                                            :
#-- Script:  SYS.PATH.WATCHER.py                                                                                  :
#-- Purpose: A python script that watches local & or network paths in Windows 10.                                 :
#-- Usage:   python C:\TEMP\SYS-PATH.WATCHER.py                                                                   :
#-- Ver:     1.0                                                                                                  :
#-- **************************************************************************************************************:
#-- **************************************************************************************************************:
#--
#-- *************************************************:
#-- DEFINE PARAMS, CONFIG PATHS, IMPORT CLASSES      :
#-- *************************************************:
import os
import sys
import win32file
import win32con
#--
ACTIONS = {
    1: "CREATED:",
    2: "DELETED",
    3: "UPDATED",
    4: "RENAMED FROM *:",
    5: "RENAMED TO *:"
}
#--
FILE_LIST_DIRECTORY = 0x0001
DIRWatch = r'C:\0_SVN'
#--
print('MONITORING CHANGES IN -->', DIRWatch)
#--
CREATEDir = win32file.CreateFile(
    DIRWatch,
    FILE_LIST_DIRECTORY,
    win32con.FILE_SHARE_READ | win32con.FILE_SHARE_WRITE | win32con.FILE_SHARE_DELETE,
    None,
    win32con.OPEN_EXISTING,
    win32con.FILE_FLAG_BACKUP_SEMANTICS,
    None
)
#--
while True:
    results = {}
    results['FName_Change'] = win32file.ReadDirectoryChangesW(
        CREATEDir,
        1024,
        True,
        win32con.FILE_NOTIFY_CHANGE_FILE_NAME,
        None,
        None
    )
    results['DName_Change'] = win32file.ReadDirectoryChangesW(
        CREATEDir,
        1024,
        True,
        win32con.FILE_NOTIFY_CHANGE_DIR_NAME,
        None,
        None
    )
    results['Attributes_Change'] = win32file.ReadDirectoryChangesW(
        CREATEDir,
        1024,
        True,
        win32con.FILE_NOTIFY_CHANGE_ATTRIBUTES,
        None,
        None
    )
    for action, file in results['FName_Change']:
        full_filename = os.path.join(DIRWatch, file)
        print(full_filename, ACTIONS.get(action, "Unknown"))
    #--
    for action, file in results['DName_Change']:
        full_filename = os.path.join(DIRWatch, file)
        print(full_filename, ACTIONS.get(action, "Unknown"))
    #--
    for action, file in results['Attributes_Change']:
        full_filename = os.path.join(DIRWatch, file)
        print(full_filename, ACTIONS.get(action, "Unknown"))
    break
#--
#-- *************************************************:
# END OF SCRIPT										:
#-- *************************************************:
