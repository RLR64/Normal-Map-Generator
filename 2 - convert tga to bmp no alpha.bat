@echo off
setlocal enabledelayedexpansion

echo This script will convert all .tga files to .bmp (without alpha channel) in the current directory (%~dp0) and all subdirectories.
set /p confirm=Are you sure you want to proceed? (Y/N): 
if /i not "!confirm!"=="Y" (
    echo Operation cancelled.
    pause
    exit /b
)

echo Converting .tga files to .bmp without alpha channel...

set "error_occurred=0"
for /r "%~dp0" %%F in (*.tga) do (
    set "output_file=%%~dpnF.bmp"
    echo Converting: %%F to !output_file!
    magick "%%F" -alpha off "!output_file!" || (
        echo Error: Failed to convert %%F
        set "error_occurred=1"
    )
)

if !error_occurred!==1 (
    echo Some files could not be converted. Please check if ImageMagick is installed, file permissions, or if files are in use.
) else (
    echo All operations completed successfully.
)

echo Done.
pause