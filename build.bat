

@echo off

SET OSDKB="..\..\..\..\osdk\bin\"
SET ORICUTRON="..\..\..\..\oricutron\"




SET ORIGIN_PATH=%CD%

cd src

%OSDKB%\xa.exe -C -W  -e error.txt -l xa_labels.txt qvc.asm 

md5sums a.o65 

cd %ORIGIN_PATH%