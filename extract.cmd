@echo off
set numdisks=1000
set offset=1536

if "%1"=="" goto noparameter
if "%1"=="/?" goto noparameter
if "%1"=="-h" goto noparameter
if "%1"=="--help" goto noparameter
if NOT EXIST %1 goto nofile

REM Second argument optional
if "%2"=="" goto nodiskcount
if "%2"=="/?" goto noparameter
if "%2"=="-h" goto noparameter
if "%2"=="--help" goto noparameter

FOR /F "tokens=*" %%A IN ("%~2") DO SET Value=%%~A
SET valid=1
FOR /F "tokens=1 delims=0123456789" %%A IN ("%Value%") DO SET valid=0
IF %valid% EQU 1 (
  IF %Value% LSS 1 (goto nodiskcount)
  IF %Value% GTR 1000 (goto nodiskcount)
  set numdisks=%Value%
)

:nodiskcount
echo.
echo Any files named floppy[xxx].img in the 
echo current directory will be overwritten 
echo without warning! Proceed?
SET /P CHOICE=[Y or N]: 
if "%CHOICE%"=="Y" goto start
if "%CHOICE%"=="y" goto start
goto exit

:start
set /a numdisks=%numdisks%-1
setlocal enableDelayedExpansion
FOR /L %%G IN (0,1,%numdisks%) DO (
  set count=%%G
  set /a skipnum=%offset%*!count!
  set "s=!count!#"
  set "len=0"
  FOR %%P IN (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) DO (
    if "!s:~%%P,1!" NEQ "" ( 
      set /a "len+=%%P"
      set "s=!s:~%%P!"
    )
  )
  FOR /L %%I IN (!len!,1,2) DO (
    set "count=0!count!"
  )
  dd if="%1" of=floppy!count!.img bs=1k count=1440 skip=!skipnum!
)
endlocal
goto exit

:nofile
echo Image file not found.
goto exit

:noparameter
echo.
echo Extract floppy image files from a raw image 
echo taken from a Gotek emulator's USB stick.
echo This extracts 1000 images by default to 
echo floppy[xxx].img if no number is specified, 
echo overwriting any that already exist.
echo.
echo Usage: extract [input.img] [number]
echo.
:exit
set numdisks=
set offset=
