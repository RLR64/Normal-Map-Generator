@echo off
echo Removing BMP files...
for /r %%f in (*.bmp) do (
    del "%%f"
    echo Deleted: %%f
)
echo.
echo All BMP files have been removed!
pause