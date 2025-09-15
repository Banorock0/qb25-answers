#!/bin/bash

# Maketools command
bedtools makewindows -g hg16-main.chrom.sizes -w 1000000 #> hg16-1mb.bed

# Reformat hg16-kc file
cut -f1-3,5 hg16-kc.tsv #> hg16-kc.bed

# Count intersecting genes
bedtools intersect -c -a hg16-1mb.bed -b hg16-kc.bed #> hg16-kc-count.bed

# Calculations

# hg19
# 1
wc -l hg19-kc.bed 
# 80270 genes

# 2
bedtools intersect -v -a hg19-kc.bed -b hg16-kc.bed | wc -l
# 42717 unique genes in hg19

# 3
# Some genes are in hg19 and not in hg16 because there is about a 6 year lapse between hg16 and hg19 where more human samples were likely collected for sequencing and sequencing tools/instruments improved.

# hg16
# 1
wc -l hg16-kc.bed 
# 21365 genes

# 2
bedtools intersect -v -a hg16-kc.bed -b hg19-kc.bed | wc -l
# 3460 unique genes in hg19

# 3
# Some genes are in hg16 and not hg19 might be because there could have been some erroneous gene entries from earlier that were determined to be wrong or part of another gene when the hg19 assembly was made.