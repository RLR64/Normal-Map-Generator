# Normal Map Generator

A Windows batch-based tool for generating normal maps from BMP textures with customizable color channel processing for game development workflows.

## Overview

This tool provides a step-by-step workflow for generating normal maps from BMP height/diffuse textures. The core Python script recursively processes all BMP files in the directory structure, generating normal maps with customizable parameters. The tool then provides batch files for color channel optimization and format conversion based on your target application's requirements.

**Key Features:**
- **Recursive Processing**: Automatically finds and processes BMP files in all subdirectories
- **Smart Naming**: Generates normal maps with `_n` suffix (e.g., `hat.bmp` → `hat_n.bmp`)
- **Skip Existing**: Won't reprocess files that already have `_n` suffix
- **Customizable Parameters**: Edit `main.py` to adjust scale, component inclusion, and flipping options

## Features

- **Recursive BMP Processing**: Automatically finds and processes all BMP files in directory tree
- **Intelligent File Handling**: Skips already-generated normal maps (files with `_n` suffix)
- **Customizable Generation**: Adjustable scale, component inclusion, and directional flipping
- **Color Channel Management**: Remove specific RGB channels for engine compatibility  
- **Format Conversion Pipeline**: Convert between BMP, TGA, and DDS formats
- **Step-by-Step Workflow**: Numbered batch files guide you through the optimization process
- **Preserves Directory Structure**: Generates normal maps in the same location as source files although you can use the Textures To Be Generated to place the bmp files that you want the normal maps to be generated.

## File Structure

```
Normal Map Generator/
├── [Your BMP files can be anywhere in subdirectories]
├── 0 - Generate Normal Maps.bat       # Main normal map generation (calls main.py)
├── 1 - Remove Blue Color Channel.bat  # Remove blue channel from generated maps
├── 1 - Remove Green Color Channel.bat # Remove green channel from generated maps
├── 1 - Remove Red Color Channel.bat   # Remove red channel from generated maps
├── 2 - bmp to tga.bat                 # Convert BMP to TGA format
├── 2 - convert tga to bmp no alpha.bat # Convert TGA to BMP (no alpha channel)
├── 2 - dds to tga.bat                 # Convert DDS to TGA format
├── 2 - tga to dds.bat                 # Convert TGA to DDS format
├── 3 - remove bmp files.bat           # Clean up BMP files
├── 3 - remove dds files.bat           # Clean up DDS files
├── 3 - remove tga files.bat           # Clean up TGA files
└── main.py                            # Core Python processing script (editable settings)
```

## Installation

### Prerequisites

- Windows Operating System
- Python 3.x installed and added to PATH
- **ImageMagick** installed and added to PATH (required for color channel removal and format conversion batch files)
- Required Python libraries (PIL/Pillow, NumPy, etc.)

### Setup

1. **Install ImageMagick**:
   - Download from [https://imagemagick.org/script/download.php#windows](https://imagemagick.org/script/download.php#windows)
   - During installation, ensure "Add application directory to your system path" is checked
   - Verify installation by running `magick --version` in Command Prompt

2. **Install Python Dependencies**:
```bash
pip install pillow numpy
```

3. **Download the Tool**:
```bash
git clone https://github.com/yourusername/normal-map-generator.git
```

4. Navigate to the Normal Map Generator folder and you're ready to use it!

## Usage

### Step-by-Step Workflow

### Step 1: Prepare Your Textures
1. Place your BMP texture files anywhere within the Normal Map Generator directory
2. The tool will recursively find all BMP files in subdirectories
3. Files can be organized in any folder structure you prefer

### Step 2: Generate Normal Maps
1. **(Optional)** Edit `main.py` to customize normal map generation settings:
   - `SCALE`: Intensity/strength of the normal map (default: 10.0)
   - `X_COMPONENT`: Include X component/Red channel (default: True)  
   - `Y_COMPONENT`: Include Y component/Green channel (default: True)
   - `FLIP_X`: Invert X direction (default: False)
   - `FLIP_Y`: Invert Y direction (default: False)
   - `FULL_Z_RANGE`: Use full Z range for enhanced contrast (default: False)

2. Double-click `0 - Generate Normal Maps.bat`
3. The script will process all BMP files recursively
4. Normal maps are saved with `_n` suffix (e.g., `texture.bmp` → `texture_n.bmp`)
5. Already processed files (with `_n` suffix) are automatically skipped

#### Step 3: Optimize for Your Game Engine

**Note**: Color channel removal batch files require ImageMagick to be installed and added to PATH.

**For engines that only process specific channels:**

- **Remove Blue Channel**: Run `1 - Remove Blue Color Channel.bat`
- **Remove Green Channel**: Run `1 - Remove Green Color Channel.bat`
- **Remove Red Channel**: Run `1 - Remove Red Color Channel.bat`

#### Step 4: Format Conversion (Optional)

**Note**: Format conversion batch files require ImageMagick to be installed and added to PATH.

Convert between different texture formats as needed:

- **BMP to TGA**: `2 - bmp to tga.bat` (converts with 32-bit depth and alpha support)
- **TGA to BMP (no alpha)**: `2 - convert tga to bmp no alpha.bat`
- **DDS to TGA**: `2 - dds to tga.bat`
- **TGA to DDS**: `2 - tga to dds.bat`

#### Step 5: Cleanup

Remove temporary files:
- **Clean BMP files**: `3 - remove bmp files.bat`
- **Clean DDS files**: `3 - remove dds files.bat`
- **Clean TGA files**: `3 - remove tga files.bat`

## Customizing Normal Map Generation

The `main.py` file contains editable settings at the top of the `process_all_bmps()` function:

```python
# ===== NORMAL MAP SETTINGS =====
SCALE = 10.0           # Scale/strength of the normal map (higher = stronger)
X_COMPONENT = True     # Include X component (Red channel)
Y_COMPONENT = True     # Include Y component (Green channel)
FLIP_X = False         # Flip X component direction
FLIP_Y = False         # Flip Y component direction
FULL_Z_RANGE = False   # Use full Z range for better contrast
```

### Parameter Explanations

- **SCALE**: Controls normal map intensity. Higher values create more pronounced surface details
- **X_COMPONENT/Y_COMPONENT**: Enable/disable specific gradient components
- **FLIP_X/FLIP_Y**: Invert gradient directions if your engine interprets normals differently
- **FULL_Z_RANGE**: Use full 0-255 range for Z component instead of standard mapping for enhanced contrast

### File Processing Behavior

- **Recursive**: Processes BMP files in all subdirectories automatically
- **Smart Naming**: Adds `_n` suffix to generated files (preserves original filenames)
- **Skip Protection**: Files ending with `_n.bmp` are automatically skipped to prevent reprocessing
- **In-Place Generation**: Normal maps are created in the same directory as source files

## Game Engine Compatibility
Some older or specialized game engines only read one color channel from normal maps:
- Use the appropriate `1 - Remove [Color] Channel.bat` script
- Keep only the channel your engine processes

### Dual Channel Engines
For engines that process two channels:
- Remove the unused channel using the relevant batch file
- Common configurations: RG (remove blue), RB (remove green), GB (remove red)

### Full RGB Engines
Modern engines typically use all three channels - no modification needed after step 2.

## Supported Formats

### Input
- **BMP**: Primary input format for texture processing

### Output/Conversion
- **BMP**: Standard bitmap format
- **TGA**: Targa format (supports alpha channel)
- **DDS**: DirectDraw Surface (compressed texture format)

## Tips for Best Results

1. **Use high-quality source textures**: Better input = better normal maps
2. **Know your target engine**: Check documentation for channel requirements
3. **Test in your application**: Always verify results in your target environment
4. **Keep backups**: Original textures should be preserved
5. **Batch process efficiently**: Process multiple textures at once for consistency

## Troubleshooting

### Common Issues

**"Python not recognized" error**
- Ensure Python is installed and added to system PATH
- Try running `python --version` in Command Prompt

**No output files generated**
- Check that BMP files are in the `Textures To Be Generated` folder
- Verify file permissions and folder access
- Ensure BMP files are valid and not corrupted

**"magick not recognized" error**
- Ensure ImageMagick is installed and added to system PATH
- Try running `magick --version` in Command Prompt to verify installation
- Restart Command Prompt/system after installing ImageMagick

**Color channel removal and format conversion not working**
- Verify ImageMagick installation with `magick --version`
- Check that the source files exist in the expected format
- Ensure sufficient disk space for processing output

**Poor normal map quality**
- Verify source texture resolution and quality
- Check that input textures have sufficient detail/contrast

## Contributing

Contributions are welcome! Areas for improvement:
- Additional format support
- GUI interface
- Advanced filtering options
- Batch configuration options

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built for game developers and modders working with various engine requirements
- Designed for Windows batch processing workflows
- Designed for those who just want a normal map generated in a pinch without spending loads of time creating the files

---

**Note**: This tool is designed for Windows environments. For cross-platform usage, individual Python scripts can be run directly with appropriate command-line arguments.