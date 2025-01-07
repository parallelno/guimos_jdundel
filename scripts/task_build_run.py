import export.export_data as export_data
import utils.build as build
import export.export_fdd as export_fdd

game_name = "guimos_jdundel_eng"
data_path = "source\\data\\data.json"

build.set_assembler_path(f'..\\..\\retroassembler\\retroassembler.exe -C=8080 -c ')
build.set_assembler_labels_cmd(" -x")
build.set_packer(build.PACKER_ZX0_SALVADORE)
build.set_emulator_path("..\\..\\Emu80\\Emu80qt.exe")

build.printc(";===========================================================================", build.TextColor.MAGENTA)
build.printc(";", build.TextColor.MAGENTA)
build.printc(f"; ram-disk data export: {data_path}", build.TextColor.MAGENTA)
build.printc(";", build.TextColor.MAGENTA)
build.printc(";===========================================================================", build.TextColor.MAGENTA)
print("\n")
# export_data.export(data_path)

export_fdd.export(input_files=[f"bin\\{game_name}.com"], output_fdd = f"bin\\{game_name}.fdd")
'''
export_fdd.export(
    input_files=["bin\\README.md", "bin\\ot.com"], 
    output_fdd = f"bin\\{game_name}.fdd")
'''

