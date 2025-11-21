#!/bin/bash

# Test
# python week10.py data/test.fna data/HOXD70.txt -300 out/test.txt

# AA alignment
python week10.py data/CTCF_38_M27_AA.faa data/BLOSUM62.txt -10 out/CTCF_38_M27_AA_align.txt

# DNA alignment
python week10.py data/CTCF_38_M27_DNA.fna data/HOXD70.txt -300 out/CTCF_38_M27_DNA_align.txt