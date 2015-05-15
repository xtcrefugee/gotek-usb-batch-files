@echo off
set offset=1536

if "%1"=="" goto noparameter
if "%1"=="/?" goto noparameter
if "%1"=="-h" goto noparameter
if "%1"=="--help" goto noparameter
if NOT EXIST %1 goto nofile

echo.
echo Any files named floppy[xxx].img in the 
echo current directory will be written in  
echo order to the output file without 
echo warning! Proceed?
SET /P CHOICE=[Y or N]: 
if "%CHOICE%"=="Y" goto start
if "%CHOICE%"=="y" goto start
goto exit

:start
set count=0
setlocal enableDelayedExpansion
FOR %%G IN (floppy???.img) DO (
  if NOT EXIST %%G goto nofile
  set /a skipnum=%offset%*!count!
  dd if=%%G of="%1" bs=1k count=1440 seek=!skipnum!
  set /a count+=1
)
endlocal
goto exit

:nofile
echo Image file not found.
goto exit

:noparameter
echo.
echo Write floppy image files in the current  
echo directory to an existing image file 
echo taken from a Gotek emulator's USB stick.
echo This copies all floppy[xxx].img contents 
echo in alphanumeric order, overwriting the 
echo existing file contents.
echo.
echo Usage: update [output.img]
echo.
:exit
set offset=
