import os
from glob import glob
from PIL import Image
import numpy as np

def generate_normal_map(grayscale_img, scale=10.0, x_component=True, y_component=True, flip_x=False, flip_y=False, full_z_range=False):
    # Convert image to normalized float array
    arr = np.array(grayscale_img).astype('float32') / 255.0
    
    # Calculate height gradients (slopes) in X and Y directions
    dx = np.gradient(arr, axis=1) * scale if x_component else np.zeros_like(arr)
    dy = np.gradient(arr, axis=0) * scale if y_component else np.zeros_like(arr)
    
    # Apply flipping if requested
    if flip_x:
        dx = -dx
    if flip_y:
        dy = -dy
    
    dz = np.ones_like(arr)  # Z component (surface normal strength)
    
    # Normalize the gradient vectors
    length = np.sqrt(dx**2 + dy**2 + dz**2)
    
    # Convert normalized vectors to RGB color space
    if full_z_range:
        # Full Z Range: use full 0-255 range for better contrast
        nx = ((dx / length) + 1.0) * 127.5
        ny = ((dy / length) + 1.0) * 127.5
        nz = (dz / length) * 255.0  # Use full range for Z
    else:
        # Standard mapping: -1 to 1 maps to 0-255
        nx = ((dx / length) + 1.0) * 127.5
        ny = ((dy / length) + 1.0) * 127.5
        nz = ((dz / length) + 1.0) * 127.5
    
    # Stack RGB channels and return as image
    normal = np.stack([nx, ny, nz], axis=-1).clip(0, 255).astype('uint8')
    return Image.fromarray(normal)

def process_all_bmps():
    # ===== NORMAL MAP SETTINGS =====
    SCALE = 10.0           # Scale/strength of the normal map (higher = stronger)
    X_COMPONENT = True     # Include X component (Red channel)
    Y_COMPONENT = True     # Include Y component (Green channel)
    FLIP_X = False         # Flip X component direction
    FLIP_Y = False         # Flip Y component direction
    FULL_Z_RANGE = False   # Use full Z range for better contrast
    
    # Get current directory (where the script is located)
    current_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Walk through all directories and subdirectories
    for root, dirs, files in os.walk(current_dir):
        # Find all BMP files in current directory
        bmp_files = [f for f in files if f.lower().endswith('.bmp')]
        
        for bmp_file in bmp_files:
            if bmp_file.lower().endswith("_n.bmp"):
                continue  # Skip already generated normal maps
            
            # Full path to the BMP file
            bmp_path = os.path.join(root, bmp_file)
            
            # Generate output filename in the same directory
            base_name = os.path.splitext(bmp_file)[0]
            out_name = f"{base_name}_n.bmp"
            out_path = os.path.join(root, out_name)
            
            # Show relative path for cleaner output
            rel_dir = os.path.relpath(root, current_dir)
            if rel_dir == ".":
                print(f"Processing {bmp_file} -> {out_name}")
            else:
                print(f"Processing {rel_dir}/{bmp_file} -> {rel_dir}/{out_name}")
            
            print(f"  Scale: {SCALE}, X: {X_COMPONENT}, Y: {Y_COMPONENT}, FlipX: {FLIP_X}, FlipY: {FLIP_Y}, FullZ: {FULL_Z_RANGE}")
            
            # Load as grayscale and generate normal map
            img = Image.open(bmp_path).convert("L")
            normal_map = generate_normal_map(
                img, 
                scale=SCALE,
                x_component=X_COMPONENT,
                y_component=Y_COMPONENT,
                flip_x=FLIP_X,
                flip_y=FLIP_Y,
                full_z_range=FULL_Z_RANGE
            )
            normal_map.save(out_path)

if __name__ == "__main__":
    process_all_bmps()