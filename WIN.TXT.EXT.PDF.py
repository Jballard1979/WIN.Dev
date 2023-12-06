#- *************************************************************************************************************:
#- ******************************************** EXTRACT TXT FROM PDF *******************************************:
#- *************************************************************************************************************:
#- Author:  JBallard (JEB)                                                                                      :
#- Date:    2017.3.11                                                                                           :
#- Script:  WIN-TXT.EXT.PDF.py                                                                                  :
#- Purpose: A Python Script that extracts all the Text from a PDF file.                                         :
#- Version: 1.0                                                                                                 :
#- *************************************************************************************************************:
#- *************************************************************************************************************:
#-
#- *************************************************:
#- DEFINE PARAMETERS & CONFIGURATION PATHS          :
#- *************************************************:
import PyPDF2
#-
pdf1File = open('example.pdf', 'rb')
pdf2File = open('example2.pdf', 'rb')
#- READ PDF FILES:
pdf1Reader = PyPDF2.PdfFileReader(pdf1File)
pdf2Reader = PyPDF2.PdfFileReader(pdf2File)
#- WRITE TO NEW PDF FILE:
pdfWriter = PyPDF2.PdfFileWriter()
for pageNum in range(pdf1Reader.numPages):
    pageObj = pdf1Reader.getPage(pageNum)
    pdfWriter.addPage(pageObj)
for pageNum in range(pdf2Reader.numPages):
    pageObj = pdf2Reader.getPage(pageNum)
    pdfWriter.addPage(pageObj)
#- POPULATE NEW PDF FILE:
pdfOutputFile = open('example3.pdf', 'wb')
pdfWriter.write(pdfOutputFile)
pdfOutputFile.close()
pdf1File.close()
pdf2File.close()
#-
#- *************************************************:
#- END OF PYTHON SCRIPT                             :
#- *************************************************: