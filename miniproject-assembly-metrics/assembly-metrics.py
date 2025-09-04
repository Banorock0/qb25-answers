#!/usr/bin/env python3

import sys
import fasta

# Check if files are passed as an argument
if len(sys.argv) > 1:

    # Loop through files passed
    for i in range(1,len(sys.argv)):

        # Initalize variables
        num = 0
        length = 0
        avg = 0
        contig_len = []
        contig_tlen = 0

        # Load file path
        f_path = sys.argv[i]

        # Force filepath as argument
        try:
            # Open file
            with open(f_path,"r") as f:

                # Pass file to fasta module
                assemblies = fasta.FASTAReader(f)

                # Loop through fasta file
                for ident, sequence in assemblies:

                    # Count contigs
                    num += 1

                    # Calculate total length of sequences
                    length += len(sequence)

                    # Save seq length per contig
                    contig_len.append(len(sequence))
                
                # Sort contig lengths
                contig_len.sort(reverse=True)

                # Calculate N50 by looping through sorted contig lengths
                for l in contig_len:
                    contig_tlen += l

                    # N50 = shortest contig at 50% of the total assembly length
                    if contig_tlen > length/2:
                        N50 = l
                        break
                
                # Calculate average sequence length
                avg = length/num

                # Print results
                print(f"File Name: {f_path}\nNumber of contigs: {num}, Total Length: {length}, Average Length: {avg}\nSequence length of the shortest contig at 50% of the total assembly length (N50): {N50}\n")

        # Error if not file
        except FileNotFoundError:
            print(f"Error: File {f_path} not found.")

# Error if < 1 arguments
else:
    print("Usage: assembly-metrics.py <file_path>")
