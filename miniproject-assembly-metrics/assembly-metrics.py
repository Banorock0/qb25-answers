#!/usr/bin/env python3

import sys
import fasta

if len(sys.argv) > 1:
    f_path = sys.argv[1]
    try:
        with open(f_path,"r") as f:
            fasta
    except FileNotFoundError:
        print(f"Error: File {f_path} not found.")
else:
    print("Usage: assembly-metrics.py <file_path>")
