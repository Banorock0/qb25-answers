#!/usr/bin/env python3

# Import required modules
import sys
import fasta
import codons

# Check if files are passed as an argument
if len(sys.argv) > 1:

    # Init dictionary
    aas = {}

    for i in range(1,len(sys.argv)):

        # Test if filepath
        try:

            # Open file
            with open(sys.argv[i],"r") as f:

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
                        aas.setdefault(key,[0]*(len(sys.argv)-1))
                        aas[key][i-1]+=1
                
                # Counter for genes in fasta
                # print(counter)

                # AAs
                # print(dict(sorted(aas.items())))

        # Error if file not found
        except FileNotFoundError:
            print(f"Error: File {f} not found.")

    aas = dict(sorted(aas.items()))

    # Seq Compare
    for k in aas.keys():
        print(f"{k}\t{aas[k][0]}\t{aas[k][1]}")

# Error if < 1 arguments
else:
    print("Usage: assembly-metrics.py <file_path>")