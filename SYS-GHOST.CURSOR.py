#--
#-- ************************************************************************************************************:
#-- *********************************************** GHOST CURSOR ***********************************************:
#-- ************************************************************************************************************:
#-- Author:   JBALLARD (JEB)                                                                                    :
#-- Date:     2016.12.03                                                                                        :
#-- Script:   SYS-GHOST.CURSOR.py                                                                               :
#-- Purpose:  A python script that moves the windows mouse to random locations on the display.                  :
#-- Version:  1.0                                                                                               :
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ****************************************************:
#-- DEFINE PARAMES, CONFIGS, IMPORT MODULES & CLASSES   :
#-- ****************************************************:
#-- python -m pip install -U pyautogui
import pyautogui
import random
import time
#--
#-- A LOOP THAT MOVES THE CURSOR TO RANDOM LOCATIONS:
for i in range(10):
    x = random.randint(0, 1920)
    y = random.randint(0, 1080)
    pyautogui.moveTo(x, y)
    #--
    #-- SLEEP BEFORE RESTARTING LOOP:    
    time.sleep(1)
#--
#-- ****************************************************:
#-- END OF PYTHON SCRIPT                                :
#-- ****************************************************: