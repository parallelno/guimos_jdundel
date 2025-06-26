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
    ("Bank 0 Before Stack", 32702), ("Bank 0 After Stack", 8192),
    ("Bank 1 Before Stack", 32702), ("Bank 1 After Stack", 8192),
    ("Bank 2 Before Stack", 32702), ("Bank 2 After Stack", 32768),
    ("Bank 3 Before Stack", 32702), ("Bank 3 After Stack", 32768)
]

# Special files that must go after stack
special_files = {"LV0_DATA.BIN", "SWORD.BIN"}

def pack_files_greedy_with_constraints(files, segments):
    # Split files into special (after stack only) and regular
    special = [f for f in files if f[0] in special_files]
    regular = [f for f in files if f[0] not in special_files]
    
    # Sort by size descending
    special = sorted(special, key=lambda x: x[1], reverse=True)
    regular = sorted(regular, key=lambda x: x[1], reverse=True)
    
    # Segment space and allocation
    segment_space = {seg[0]: seg[1] for seg in segments}
    allocation = {seg[0]: [] for seg in segments}
    after_stack_segs = [s[0] for s in segments if "After Stack" in s[0]]
    
    # Step 1: Place special files in after-stack segments
    for file_name, file_size in special:
        placed = False
        # Prefer larger segments (Bank 2 or 3 After Stack)
        for seg_name in sorted(after_stack_segs, key=lambda x: segment_space[x], reverse=True):
            if file_size <= segment_space[seg_name]:
                allocation[seg_name].append((file_name, file_size))
                segment_space[seg_name] -= file_size
                placed = True
                break
        if not placed:
            return None  # Can't fit special files
    
    # Step 2: Place regular files in any segment
    for file_name, file_size in regular:
        placed = False
        # Try all segments, preferring fullest fit
        for seg_name in sorted(segment_space.keys(), key=lambda x: segment_space[x]):
            if file_size <= segment_space[seg_name]:
                allocation[seg_name].append((file_name, file_size))
                segment_space[seg_name] -= file_size
                placed = True
                break
        if not placed:
            return None  # Can't fit all files
    
    total_wasted = sum(segment_space.values())
    return allocation, total_wasted




# Run the optimization
allocation, wasted = pack_files_greedy_with_constraints(files, segments)
if allocation:
    print("Optimal Allocation with Constraints:")
    for seg, files_list in allocation.items():
        if files_list:
            print(f"{seg}:")
            total_size = 0
            for fname, fsize in files_list:
                print(f"  {fname}: {fsize} bytes")
                total_size += fsize
            # Find the capacity of this segment
            seg_capacity = segments[[s[0] for s in segments].index(seg)][1]
            print(f"  Used: {total_size}, Remaining: {seg_capacity - total_size}")
    print(f"Total Wasted Space: {wasted} bytes")
else:
    print("No solution found; files exceed available space or constraints can't be met.")