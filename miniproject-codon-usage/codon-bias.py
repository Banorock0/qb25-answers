#!/usr/bin/env python3

import sys
import fasta
import codons

# Check if files are passed as an argument
if len(sys.argv) > 1 and len(sys.argv) < 4:

    # Test if filepath
    try:

        # Open file
        with open(sys.argv[1],"r") as f:
                
            # Test if upper
            try:

                # Store AA
                aa = sys.argv[2]

                # Init dict
                counts = {}

                # Retrive fasta as obj
                assembly = fasta.FASTAReader(f)

                # Loop through fasta
                for ident,sequence in assembly:
                        
                    # Convert from codon to AA
                    for j in range(0,len(sequence),3):
                        codon = sequence[j:j+3]

                        for l in codons.reverse[aa]:
                            counts.setdefault(l,0)
                            if codon == l:
                                counts[l] += 1
                            else:
                                continue

                # Codon bias counter     
                for m in counts.keys():
                    print(f"{m}\t{counts[m]}")            

            # Error if aa not uppercase string
            except aa.isupper() == False:
                print(f"Error: {aa} is formatted incorrectly.")

    # Error if file not found
    except FileNotFoundError:
        print(f"Error: File {f} not found.")

# Error if < 1 arguments
else:
    print("Usage: assembly-metrics.py <file_path> N")