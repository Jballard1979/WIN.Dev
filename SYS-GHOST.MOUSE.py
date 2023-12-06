#--
#-- ************************************************************************************************************:
#-- *********************************************** GHOST MOUSE ************************************************:
#-- ************************************************************************************************************:
#-- Author:   JBALLARD (JEB)                                                                                    :
#-- Date:     2023.3.23                                                                                         :
#-- Script:   SYS-GHOST.MOUSE.py                                                                                :
#-- Purpose:  A python script that moves, clicks, writes commands to the windows mouse.                         :
#-- Version:  1.0                                                                                               :
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ****************************************************:
#-- DEFINE PARAMES, CONFIGS, IMPORT MODULES & CLASSES   :
#-- ****************************************************:
#-- python -m pip install -U pyautogui
import pyautogui
#--
#-- MOVE MOUSE CURSOR TO SPECIFIC CORD:
pyautogui.moveTo(100, 100)
#--
#-- CLICK LEFT BUTTON ON MOUSE:
pyautogui.click()
#--
#-- TYPE TEXT:
pyautogui.typewrite("HELLO, I'VE BEEN WATCHING YOU. YOU LOOK LIKE YOU MIGHT NEED A FRIEND.?")
#--
#-- PRESS THE ENTER KEY:
pyautogui.press("ENTER")
#--
#-- ****************************************************:
#-- END OF PYTHON SCRIPT                                :
#-- ****************************************************: