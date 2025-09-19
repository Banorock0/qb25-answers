#!/bin/bash

# 1
bedtools intersect -u -a nhek-active.bed -b nhek-
repressed.bed 

# No output means mutually exclusive

# 2,3
bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed

bedtools intersect -v -a nhek-active.bed -b nhlf-active.bed

# bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed | wc -l
# bedtools intersect -v -a nhek-active.bed -b nhlf-active.bed | wc -l
# Features in 1: 11608
# Features in 2: 2405

# wc -l nhek-active.bed 
# Features in total 14013 = features in nhek-active

# The -u argument ensures only one instance of overlapping features

# 4,5,6
bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed -f 1
# Each feature in nhek-active is completely overlapped by nhlf-active

bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed -F 1
# Each feature in nhlf-active is completely overlapped by nhek-active

bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed -f 1 -F 1
# Each feature is completely reciprocally overlapped

# 7,8,9
# active-active
bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed
# Chromatin state is mostly active 

# active-repressed
bedtools intersect -u -a nhek-active.bed -b nhlf-repressed.bed
# Chromatin state is some active, some repressed, and one poised

# repressed-repressed
bedtools intersect -u -a nhek-repressed.bed -b nhlf-repressed.bed
# Chromatin state is all repressed