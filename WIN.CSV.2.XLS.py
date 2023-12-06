#!python3
# -*- coding: utf-8 -*-
#- *************************************************************************************************************:
#- ******************************************** CONVERT .CSV TO .XLS *******************************************:
#- *************************************************************************************************************:
#- Author:  JBallard (JEB)                                                                                      :
#- Date:    2015.9.09                                                                                           :
#- Script:  WIN-CSV.2.XLS.py                                                                                    :
#- Purpose: A Python Script that converts a .csv file to an Excel file.                                         :
#- Version: 1.0                                                                                                 :
#- *************************************************************************************************************:
#- *************************************************************************************************************:
#-
#- *************************************************:
#- DEFINE PARAMETERS & CONFIGURATION PATHS          :
#- *************************************************:
import openpyxl
import sys
#-
#- INPUTS:
PRINT("NOTE - WRITES CONTENTS WITHIN CSV OR DATA FILE TO AN EXCEL FILE:")
PRINT("NOTE - PLACE INPUT & OUTPUT FILES WITHIN SAME DIR AS SCRIPT:")
#--
csv_name = input("CSV FILE NAME: ")
sep = input("SEPARATOR OF CSV FILE TO BE REMOVED LATER: ")
#--
excel_name = input("USER INPUT - NAME OF FILE: ")
sheet_name = input("USER INPUT - NAME OF EXCEL SHEET: ")
#-
#- OPEN FILES:
try:
    wb = openpyxl.load_workbook(excel_name)
    sheet = wb.get_sheet_by_name(sheet_name)
    file = open(csv_name,"r",encoding = "utf-8")
except:
    print("File Error!")
    sys.exit()
#-
#- ROWS & COLUMS:
row = 1
column = 1
#-
#- LOOP THROUGH EACH CSV LINE:
for line in file:
    #- PURGE THE SEPARTOR:
    line = line[:-1]
    line = line.split(sep)
    for data in line:
        #- WRITE CSV/DATA TO CELL:
        sheet.cell(row,column).value = data
        #- INCREASE COLUMN # BY 1:
        column += 1
    #- SET COLUMN # TO 1 & INCREASE ROW # BY 1:
    column = 1
    row += 1
#- SAVE NEW EXCEL PHONE:
wb.save(excel_name)
file.close()
#-
#- *************************************************:
#- END OF PYTHON SCRIPT                             :
#- *************************************************: