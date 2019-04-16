@echo off
ECHO Transformujem %1 do PDF podla %2...
ECHO Saxon...
java -jar "D:\Users\MatusPilnan\Desktop\Skola\6.semester\dalsieWpub\prezentacia\Saxon\saxon9he.jar" -o:fo.xml -s:%1 -xsl:%2 -ext:on
echo XEP: Generujem PDF

call C:\docbook\xep\xep.bat -fo fo.xml -pdf output/output.pdf
del fo.xml
ECHO Hotovo.