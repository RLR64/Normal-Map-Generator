@echo off
echo Processing BMP files...
for /r %%f in (*.bmp) do (
    magick "%%f" -depth 32 -type TrueColorAlpha -compress none "%%~dpnf.tga"
)
echo Conversion from BMP to TGA completed!
pause