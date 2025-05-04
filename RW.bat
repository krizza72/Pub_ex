@echo off
setlocal EnableDelayedExpansion

set CORRUPT_DIR=.\Files
set BACKUP_DIR=.\Backup

:: Function to display skull ASCII art
call :skull > skull.txt
set "SKULL_FILE=skull.txt"

:: Check command-line argument
if "%1"=="corrupt" (
    call :corrupt
    goto :eof
)
if "%1"=="restore" (
    call :restore
    goto :eof
)

:: Infer action based on backup directory state
set "BACKUP_FILES=0"
for %%F in (%BACKUP_DIR%\*) do (
    set /a BACKUP_FILES+=1
)
if !BACKUP_FILES! GTR 0 (
    call :restore
) else (
    call :corrupt
)

echo Exiting...
goto :eof

:skull
echo  _( )                 ( )_      _( )                 ( )_      _( )                 ( )_
echo (_, ^|      __ __      ^| ,_)    (_, ^|      __ __      ^| ,_)    (_, ^|      __ __      ^| ,_)
echo    \'^|    /  ^^^^  \    /'/          \'^|    /  ^^^^  \    /'/          \'^|    /  ^^^^  \    /'/
echo     '\'\,/\      \,/'/'            '\'\,/\      \,/'/'            '\'\,/\      \,/'/'
echo       '\^| []   [] ^|/'                '\^| []   [] ^|/'                '\^| []   [] ^|/'
echo         (_  /^^\  _)                    (_  /^^\  _)                    (_  /^^\  _)
echo           \  ~  /                        \  ~  /                        \  ~  /
echo           /LOLOL\                        /YOLOYOL\                      /LOLOLOL\
echo         /'/{^^^}\'\                    /'/{^^^}\'\                    /'/{^^^}\'\
echo     _,/'/'  ^^^^  '\'\,_            _,/'/'  ^^^^  '\'\,_            _,/'/'  ^^^^  '\'\,_
echo    (_, ^|           ^| ,_)          (_, ^|           ^| ,_)          (_, ^|           ^| ,_)
echo      (_)           (_)              (_)           (_)              (_)           (_)
goto :eof

:restore
echo Restoring all corrupted files
set "BACKUP_FILES=0"
for %%F in (%BACKUP_DIR%\*) do (
    set /a BACKUP_FILES+=1
)
if !BACKUP_FILES! EQU 0 (
    echo Backup dir is empty! Exiting!
    exit /b
)

:: Delete all files in CORRUPT_DIR
for %%F in (%CORRUPT_DIR%\*) do (
    del "%%F"
)

:: Move all files from BACKUP_DIR to CORRUPT_DIR
for %%F in (%BACKUP_DIR%\*) do (
    move "%%F" "%CORRUPT_DIR%\%%~nxF"
)
goto :eof

:corrupt
type %SKULL_FILE%
echo Encrypting all files in %CORRUPT_DIR%. Proceed? [y/n]
set /p RESPONSE=
if /i "!RESPONSE!"=="y" (
    :: Create BACKUP_DIR if it doesn't exist
    if not exist "%BACKUP_DIR%" (
        mkdir "%BACKUP_DIR%"
    )

    :: Check if BACKUP_DIR is not empty
    set "BACKUP_FILES=0"
    for %%F in (%BACKUP_DIR%\*) do (
        set /a BACKUP_FILES+=1
    )
    if !BACKUP_FILES! GTR 0 (
        echo Backup dir is not empty! Exiting!
        exit /b
    )

    :: Move files to BACKUP_DIR and create corrupted files
    set COUNTER=0
    for %%F in (%CORRUPT_DIR%\*) do (
        set /a COUNTER+=1
        move "%%F" "%BACKUP_DIR%\%%~nxF"
        echo !COUNTER! > "%CORRUPT_DIR%\!COUNTER!"
    )
)

type %SKULL_FILE%
echo All files have been encrypted!
echo Push any key to quit...
pause >nul
goto :eof
