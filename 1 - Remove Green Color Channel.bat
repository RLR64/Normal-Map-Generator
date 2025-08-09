@echo off
setlocal enabledelayedexpansion
echo This script will remove the green color channel from all .bmp files in the current directory (%~dp0) and all subdirectories.
set /p confirm=Are you sure you want to proceed? (Y/N): 
if /i not "!confirm!"=="Y" (
    echo Operation cancelled.
    pause
    exit /b
)
echo Removing green channel from .bmp files...
set "error_occurred=0"
for /r "%~dp0" %%F in (*.bmp) do (
    echo Processing: %%F
    magick mogrify -channel Green -evaluate set 0 "%%F" || (
        echo Error: Failed to process %%F
        set "error_occurred=1"
    )
)
if !error_occurred!==1 (
    echo Some files could not be processed. Please check if ImageMagick is installed, file permissions, or if files are in use.
) else (
    echo All operations completed successfully.
)
echo Done.
pause