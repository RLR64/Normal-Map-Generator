@echo off
echo Removing DDS files...
for /r %%f in (*.dds) do (
    del "%%f"
    echo Deleted: %%f
)
echo.
echo All DDS files have been removed!
pause