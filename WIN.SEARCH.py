#- *************************************************************************************************************:
#- ******************************************** WINDOWS FILE SEARCH ********************************************:
#- *************************************************************************************************************:
#- Author:  JBallard (JEB)                                                                                      :
#- Date:    2023.9.14                                                                                           :
#- Script:  WIN-SEARCH.py                                                                                       :
#- Purpose: A Python Script that searches for a specific Windows File.                                          :
#- Version: 1.0                                                                                                 :
#- *************************************************************************************************************:
#- *************************************************************************************************************:
#-
#- *************************************************:
#- DEFINE PARAMETERS & CONFIGURATION PATHS          :
#- *************************************************:
from pathlib import Path
import argparse
import os
#--
#-- SEARCH FOR TEXT WITHIN FILES:
def SRCHTXTINFile(FILEPath, SRCHText):
    try:
        with open(FILEPath, 'r', encoding='utf-8') as file:
            FILEContent = file.read()
            if SRCHText in FILEContent:
                return True
    except Exception as e:
        pass
    return False
#--
#-- ARG PARSER DESCRIPTION:
ARGParser = argparse.ArgumentParser(description="SEARCH FOR FILE(s):")
#--
#-- ADD FILE(s) ARG:
ARGParser.add_argument(
    "--FILEName", nargs="?", help="FILE NAME (WILDCARDS FUNCTIONS ENABLED):",
    default=None
)
#--
#-- ADD DIR(s) ARG:
ARGParser.add_argument(
    "--FLDir", help="FOLDER (DEFAULT: CURRENT)",
    default=None
)
#--
#-- TEXT STRING WITHIN FILE ARG:
ARGParser.add_argument(
    "--FILEText", help="SEARCH FOR TEXT STRING WITHIN FILE(s):", 
    default=None
)
#--
#-- FILE & FOLDER ARG:
ARG = ARGParser.parse_args()
#--
#-- VALIDATE TEXT STRING:
if ARG.FILEText is None:
    while True:
        SRCHText = input("TEXT STRING WITHIN FILE(s):")
        if SRCHText.strip() == "":
            print("ERROR - THE TEXT STRING WAS INVALID:")
            continue
        else:
            ARG.FILEText = SRCHText
            break
#--
#- VALIDATE FILE NAME(s):
if ARG.FILEName is None:
    while True:
        ARG.FILEName = input("FILENAME:")
        if ARG.FILEName == "":
            print("ERROR - FILE NAME INVALID")
            continue
        break
#--
#-- PROCESS FOLDER PATH(s):
if ARG.FLDir:
    FLDir = ARG.FLDir
else:
    FLDAnswer = input("FOLDER PATH(s):")
    if FLDAnswer:
        FLDir = FLDAnswer
    else:
        FLDir = "."
#--
#-- PRINT COMPLETE PATH & FILE NAME(s):
for path in Path(FLDir).rglob(ARG.FILEName):
    if ARG.FILEText:
        if SRCHTXTINFile(path, ARG.FILEText):
            print(path.absolute())
    else:
        print(path.absolute())
#-
#- *************************************************:
#- END OF PYTHON SCRIPT                             :
#- *************************************************: