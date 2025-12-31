import json
import os
import export.export_config as export_config
from export import export_back, export_decal, export_font, export_level_data, export_level_gfx, export_music, export_palette, export_sprite, export_text, export_tiled_img_data, export_tiled_img_gfx
import utils.build as build
import utils.common as common
import argparse

"""
Generate the asset projects and dependent asm files for every asset in the config JSON file.
"""

# args parsing
parser = argparse.ArgumentParser(description="Process arguments.")
parser.add_argument("-clear", action="store_true", help="Deletes the build subfolder provided by -build_subfolder_name", default=False)
parser.add_argument("-clear_all", action="store_true", help="Deletes the build folder", default=False)
args = parser.parse_args()

build.set_build_subfolder(args.build_name)

if args.clear_all:
	common.DeleteDir(build.BUILD_PATH)
elif args.clear:
	common.DeleteDir(build.build_subfolder)
