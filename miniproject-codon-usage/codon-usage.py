#!/usr/bin/env python3

# Import required modules
import sys
import fasta
import codons

# Check if files are passed as an argument
if len(sys.argv) > 1:
        
        # Init dictionary
        aas = {}

        # Test if filepath
        try:

            # Open file
            with open(sys.argv[1],"r") as f:

                # Init counter
                counter = 0

                # Retrive fasta as obj
                assembly = fasta.FASTAReader(f)

                # Loop through fasta
                for ident,sequence in assembly:
                    # print(ident)
                    counter += 1

                    # Convert from codon to AA
                    for j in range(0,len(sequence),3):
                        codon = sequence[j:j+3]
                        # print(codon)
                        key = codons.forward[codon]
                        aas.setdefault(key,0)
                        aas[key]+=1
                
                # Counter for genes in fasta
                print(counter)

                # AAs
                print(dict(sorted(aas.items())))

        # Error if file not found
        except FileNotFoundError:
            print(f"Error: File {f} not found.")

# Error if < 1 arguments
else:
    print("Usage: assembly-metrics.py <file_path>")