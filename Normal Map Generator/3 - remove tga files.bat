@echo off
echo Removing TGA files...
for /r %%f in (*.tga) do (
    del "%%f"
    echo Deleted: %%f
)
echo.
echo All TGA files have been removed!
pause