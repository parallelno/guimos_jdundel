#!/usr/bin/env python3

import os
import utils.build as build
from fddutil_python.src.fddimage import Filesystem

def export(input_files = [], output_fdd = 'bin\\out.fdd', basefdd_path = 'scripts\\basefdd\\os-t34.fdd'):
    
    if not os.path.exists(basefdd_path):
        build.exit_error(f'file_to_fdd ERROR: cannot find the base fdd image: {basefdd_path}')

    if len(input_files) == 0:
        build.exit_error('file_to_fdd ERROR: no input files specified')

    try:
        with open(basefdd_path, 'rb') as f:
            basefdd_data = f.read()
    except IOError:
        build.exit_error(f'file_to_fdd ERROR: cannot read the base fdd image: {basefdd_path}')

    fdd = Filesystem().from_array(basefdd_data)
    print('The base fdd image contains:')
    fdd.list_dir()

    for name in input_files:
        try:
            with open(name, 'rb') as f:
                data = f.read()
        except IOError:
            build.exit_error(f'file_to_fdd ERROR: cannot read the input file {name}')
        
        basename = os.path.basename(name)
        fdd.save_file(basename, data)
        print(f'file_to_fdd: Saved file {basename} to FDD image ({len(data)} bytes)')

    try:
        with open(output_fdd, 'wb') as f:
            f.write(bytes(fdd.bytes))
        print(f'file_to_fdd: FDD image saved to: {output_fdd}')
    except IOError:
        build.exit_error(f'file_to_fdd Error: cannot write FDD image to: {output_fdd}')