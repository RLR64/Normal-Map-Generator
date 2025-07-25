@echo off
setlocal enabledelayedexpansion
echo Removing .bmp files that do not contain "_n" in the filename from current directory and all subdirectories...

rem First pass - delete unwanted bmp files
for /r %%F in (*.bmp) do (
    set "filename=%%F"
    if not "!filename:_n=!"=="%%F" (
        echo Keeping: %%F
    ) else (
        echo Deleting: %%F
        del "%%F"
    )
)

echo.
echo Removing empty folders...

rem Second pass - remove empty folders (need to do this multiple times for nested empty folders)
:cleanup_loop
set "folders_removed=0"
for /f "delims=" %%D in ('dir /ad /b /s 2^>nul') do (
    set "folder=%%D"
    rem Check if folder is empty (no files or subdirectories)
    dir /b "!folder!" 2>nul | findstr /r "^" >nul
    if errorlevel 1 (
        echo Removing empty folder: !folder!
        rmdir "!folder!" 2>nul
        if not errorlevel 1 set /a folders_removed+=1
    )
)
rem If we removed folders, there might be newly empty parent folders, so loop again
if !folders_removed! gtr 0 goto cleanup_loop

echo.
echo Done.
pause