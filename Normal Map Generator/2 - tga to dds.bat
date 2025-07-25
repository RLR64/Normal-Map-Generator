@echo off
echo Processing TGA files...
for /r %%f in (*.tga) do (
    magick "%%f" -depth 32 -type TrueColorAlpha -compress none "%%~dpnf.dds"
)

echo.
echo Conversion from TGA to 32-bit DDS completed!
pause