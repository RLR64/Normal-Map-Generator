@echo off
echo Processing DDS files...

for /r %%f in (*.dds) do (
    magick "%%f" -depth 32 -type TrueColorAlpha -compress none "%%~dpnf.tga"
)
echo Conversion from 32-bit DDS to TGA completed!
pause
