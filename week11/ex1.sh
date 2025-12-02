#!/bin/bash

# 3x coverage
echo "3x coverage:"
python ex1.py 3
Rscript ex1.R data/genome_cov_3x.txt 3 3 1.73

# 10x coverage
echo "10x coverage:"
python ex1.py 10
Rscript ex1.R data/genome_cov_10x.txt 10 10 3.16

# 30x coverage
echo "30x coverage:"
python ex1.py 30
Rscript ex1.R data/genome_cov_30x.txt 30 30 5.47