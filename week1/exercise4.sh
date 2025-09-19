#!/bin/bash

# 1
bedtools intersect -c -a hg19-kc.bed -b snps-chr1.bed | sort -k 5n | tail -n 1

# Systematic name: ENST00000490107.6_7
# Human readable name: SMYD3
# Position: hg19 chr1:245,912,649-246,670,581
# Size: 757,933
# Exon count: 12

# This gene has the most SNPs because it is relatively large, and larger genes naturally accumulate more SNPs because they span more DNA.

# 2
bedtools sample -n 20 -seed 42 -i snps-chr1.bed > snps-chr1_20.bed

bedtools sort -i snps-chr1_20.bed > snps-chr1_sorted.bed

bedtools sort -i hg19-kc.bed > kg19-kc_sorted.bed

bedtools closest -d -a kg19-kc_sorted.bed -b snps-chr1_sorted.bed -t first

# SNPs inside gene
bedtools closest -d -a kg19-kc_sorted.bed -b snps-chr1_sorted.bed -t first | grep -w 'chr1' | awk '$11==0' | wc -l

# 17

bedtools closest -d -a kg19-kc_sorted.bed -b snps-chr1_sorted.bed -t first | grep -w 'chr1' | awk '$11!=0' | sort -k 11n | head -n 1
bedtools closest -d -a kg19-kc_sorted.bed -b snps-chr1_sorted.bed -t first | grep -w 'chr1' | awk '$11!=0' | sort -k 11n | tail -n 1

# Range: (1664,36227401) = 36226237