#!/usr/bin/env python3

import sys
import fasta

# Check if files are passed as an argument
if len(sys.argv) > 1:

    try:
        with open(sys.argv[1],"r") as f:
            assembly = fasta.FASTAReader(f)
            for ident,sequence in assembly:
                # print(ident)
                for i in range(0,len(sequence),3):
                    codon = sequence[i:i+3]
                    # print(codon)
                    
    
    # Error if file not found
    except FileNotFoundError:
        print(f"Error: File {f} not found.")

# Error if < 1 arguments
else:
    print("Usage: assembly-metrics.py <file_path>")