import export.export_data as export_data
import utils.build as build
import utils.common as common
import export.export_fdd as export_fdd

game_name = "gjdundele"
data_path = "source\\data\\data.json"

build.set_assembler_path(f'tools\\retroassembler\\retroassembler.exe -C=8080 -c ')
build.set_assembler_labels_cmd(" -x")
build.set_packer(build.PACKER_ZX0_SALVADORE)
build.set_emulator_path("..\\devector\\bin\\devector.exe")

build.printc(";===========================================================================", build.TextColor.MAGENTA)
build.printc(";", build.TextColor.MAGENTA)
build.printc(f"; ram-disk data export: {data_path}", build.TextColor.MAGENTA)
build.printc(";", build.TextColor.MAGENTA)
build.printc(";===========================================================================", build.TextColor.MAGENTA)
print("\n")

# export_data.export(data_path)

#///////////////////////////////////////////////////////////////////////////////
output_fdd = f"bin\\{game_name}" + build.EXT_FDD

temp_name = "data60k"
temp_asm_path = "src\\" + temp_name + build.EXT_ASM
temp_bin_path = "build\\bin\\" + temp_name + build.EXT_BIN

build.compile_asm(temp_asm_path, temp_bin_path)

#///////////////////////////////////////////////////////////////////////////////
exe_name = "main"
exe_asm_path = "src\\" + exe_name + build.EXT_ASM
exe_bin_path = "build\\bin\\" + exe_name + build.EXT_BIN
exe_com_path = "build\\bin\\" + exe_name + build.EXT_COM

build.compile_asm(exe_asm_path, exe_bin_path)

common.rename_file(exe_bin_path, exe_com_path, True)

#///////////////////////////////////////////////////////////////////////////////
export_fdd.export(
    input_files=[
        exe_com_path, 
        # temp_bin_path
        ],
    basefdd_path = "assets\\basefdd\\os-t34.fdd",
    output_fdd = output_fdd)

#///////////////////////////////////////////////////////////////////////////////

print("\n")
build.printc(f"; start the game: {output_fdd}", build.TextColor.GREEN)
print("\n")

common.run_command(f"{build.emulator_path} -path {output_fdd}", "", output_fdd)


build.printc(";===========================================================================", build.TextColor.MAGENTA)
build.printc(";", build.TextColor.MAGENTA)
build.printc(f"; Export finished:", build.TextColor.MAGENTA)
build.printc(";", build.TextColor.MAGENTA)
build.printc(";===========================================================================", build.TextColor.MAGENTA)


