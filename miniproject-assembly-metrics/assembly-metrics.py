#!/usr/bin/env python3

import sys
import fasta

if len(sys.argv) > 1:
    for i in range(1,len(sys.argv)):
        num = 0
        length = 0
        avg = 0
        f_path = sys.argv[i]
        try:
            with open(f_path,"r") as f:
                assemblies = fasta.FASTAReader(f)
                for ident, sequence in assemblies:
                    num += 1
                    length += len(sequence)
                avg = length/num
                print(f"File Name: {f_path}\nNumber of contigs: {num}, Total Length: {length}, Average Length: {avg}")
        except FileNotFoundError:
            print(f"Error: File {f_path} not found.")
else:
    print("Usage: assembly-metrics.py <file_path>")
