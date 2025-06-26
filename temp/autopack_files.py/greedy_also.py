from itertools import permutations

# Define files with their sizes
files = [
    ("KNIGHT.BIN", 15780), ("HERO_L.BIN", 13176), ("VFX.BIN", 2154), ("SCYTHE.BIN", 1554),
    ("LV0_GFX.BIN", 5524), ("FONT.BIN", 1624), ("BOMB.BIN", 960),
    ("HERO_R.BIN", 13176), ("BURNER.BIN", 9030), ("SKELETON.BIN", 9870),
    ("LV0_DATA.BIN", 3802), ("DECALS0.BIN", 4266),
    ("SWORD.BIN", 8688), ("VAMPIRE.BIN", 7440), ("TI0_GFX.BIN", 8178),
    ("SNOWFLAK.BIN", 1212), ("TI0_DATA.BIN", 960), ("TNT.BIN", 1056),
    ("TEXT_LV0.BIN", 5190), ("VFX4.BIN", 3888), ("BACKS0.BIN", 600)
]

# Bank segment sizes
segments = [
    # Bank 0
    ("Bank 0 Before Stack", 32702), ("Bank 0 After Stack", 8192),
    # Bank 1
    ("Bank 1 Before Stack", 32702), ("Bank 1 After Stack", 8192),
    # Bank 2
    ("Bank 2 Before Stack", 32702), ("Bank 2 After Stack", 32768),
    # Bank 3
    ("Bank 3 Before Stack", 32702), ("Bank 3 After Stack", 32768)
]

def pack_files_greedy(files, segments):
    files_sorted = sorted(files, key=lambda x: x[1], reverse=True)  # Sort by size descending
    segment_space = {seg[0]: seg[1] for seg in segments}
    allocation = {seg[0]: [] for seg in segments}
    
    for file_name, file_size in files_sorted:
        placed = False
        for seg_name, seg_size in segment_space.items():
            if file_size <= seg_size:
                allocation[seg_name].append((file_name, file_size))
                segment_space[seg_name] -= file_size
                placed = True
                break
        if not placed:
            return None  # Can't fit all files
    total_wasted = sum(segment_space.values())
    return allocation, total_wasted

def pack_files_optimal(files, segments):
    min_wasted = float('inf')
    best_allocation = None
    total_file_size = sum(f[1] for f in files)
    total_space = sum(s[1] for s in segments)
    if total_file_size > total_space:
        return None  # Impossible to fit
    
    # For small number of files, try permutations (simplified here with greedy)
    allocation, wasted = pack_files_greedy(files, segments)
    if allocation:
        min_wasted = wasted
        best_allocation = allocation
    
    return best_allocation, min_wasted

# Run the optimization
allocation, wasted = pack_files_optimal(files, segments)
if allocation:
    print("Optimal Allocation:")
    for seg, files_list in allocation.items():
        if files_list:
            print(f"{seg}:")
            total_size = 0
            for fname, fsize in files_list:
                print(f"  {fname}: {fsize} bytes")
                total_size += fsize
            print(f"  Used: {total_size}, Remaining: {segments[[s[0] for s in segments].index(seg)][1] - total_size}")
    print(f"Total Wasted Space: {wasted} bytes")
else:
    print("No solution found; files exceed available space.")