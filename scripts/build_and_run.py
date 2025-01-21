import json
import os
import export.export_config as export_config
import utils.build as build
import utils.common as common
import argparse

# args parsing
parser = argparse.ArgumentParser(description="Process arguments.")
parser.add_argument("-config_path", help="The config path")
parser.add_argument("-build_name", help="Defines the name of the build subfolder", default="release")
parser.add_argument("-script_debug", action="store_true", help="This flag is to python script debugging purposes", default=False)
parser.add_argument("-clear", action="store_true", help="Deletes the build subfolder provided by -build_subfolder_name", default=False)
parser.add_argument("-clear_all", action="store_true", help="Deletes the build folder", default=False)
args = parser.parse_args()

build.set_debug(args.script_debug)
build.set_build_subfolder(args.build_name)

if args.clear_all:
	common.DeleteDir(build.BUILD_PATH)
elif args.clear:
	common.DeleteDir(build.build_subfolder)


# config exporting
if (args.config_path):
	fdd_path = export_config.export(args.config_path)

	print("\n")
	build.printc(f"; start the game: {fdd_path}", build.TextColor.GREEN)
	print("\n")

	common.run_command(f"{build.emulator_path.replace("/", "\\")} -path {fdd_path}", "", fdd_path)

