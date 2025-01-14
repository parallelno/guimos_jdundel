🎮 guimos_jdundel

📝 Description

[Add your project description here]

🔨 Build
Prerequisites:

🛠️ Install Retroassembler from https://enginedesigns.net/
📥 Clone https://github.com/parallelno/fddutil_python.git into \scripts folder
▶️ F5 or Ctrl+F5 to build

Debug Mode
To enable debug mode, uncomment the line v6_debug_mode == DEBUG_ON in the v6_debug.asm

📁 Folder Structure
Copy.vscode/
    └── [configuration files]
assets/
    ├── basefdd/    # Contains FDD images with bootable OS used to store game assets
    │               # rds308.fdd is the most preferable
    ├── fdd_files/  # Required files
    └── [other assets]

❗ Troubleshooting
F5 Not Building Project After Retroassembler Installation
Solution:

Open VS Code Keyboard Shortcuts (Ctrl+K, Ctrl+S)
Search for "Start Debugging"
Delete Retroassembler F5 bindings

📚 Naming Conventions
Prefixes:

ADDR - Address
BUF - Buffer
INT - Interruption
SCR - Screen buffer
MEM - Memory
LEN - Length
SEC - Second
SEG - Segment (half of a 64K bank of the ram-disk)
RES - Result
PTR - Pointer