#--
#-- ************************************************************************************************************:
#-- ******************************************** GRAMMER CORRECTION ********************************************:
#-- ************************************************************************************************************:
#-- Author:   JBALLARD (JEB)                                                                                    :
#-- Date:     2023.3.07                                                                                         :
#-- Script:   TXT-GRAMMER.CORRECTION.py                                                                         :
#-- Purpose:  A python script that Proofreads a text file & fixes spelling errors.                              :
#-- Version:  1.0                                                                                               :
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- *************************************************:
#-- DEFINE PARAMS, CONFIG PATHS, IMPORT CLASSES      :
#-- *************************************************:
# PIP INSTALL TEXTBLOB
from textblob import *
# FIX PARAGRAPH SPELLING:
def fix_paragraph_words(paragraph):
    sentence = TextBlob(paragraph)
    correction = sentence.correct()
    print(correction)
# FIX SPELLING MISTAKES:
def fix_word_spell(word):
    word = Word(word)
    correction = word.correct()
    print(correction)
fix_paragraph_words("NOTE - SAMPLE TEXT:")
fix_word_spell("maangoo")
#--
#-- ************************************************:
#-- END OF SCRIPT                                   :
#-- ************************************************: