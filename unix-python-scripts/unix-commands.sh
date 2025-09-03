#!/bin/bash

# 1.

wc -l ce11_genes.bed
# 53935 ce11_genes.bed

cut -f 1 ce11_genes.bed | sort | uniq -c
# 5460 chrI
# 6299 chrII
# 4849 chrIII
# 21418 chrIV
#   12 chrM
# 9057 chrV
# 6840 chrX

cut -f 6 ce11_genes.bed | sort | uniq -c
# 26626 -
# 27309 +

# 3.

cut -f 7 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort | uniq -c | sort -r | head -n 3
# 3288 Whole Blood
# 1132 Muscle - Skeletal
#  867 Lung

grep RNA GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | wc -l
# 20017

grep -v RNA GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | wc -l
# 2935

# 5.

cut -f 3 gencode.v46.basic.annotation.gtf | sort | grep -v \# | uniq -c | sort
#  107 Selenocysteine
# 118625 transcript
# 182871 UTR
# 63086 gene
# 64806 stop_codon
# 64970 start_codon
# 664771 CDS
# 865650 exon

grep lnc gencode.v46.basic.annotation.gtf | cut -f 1 | sort | uniq -c | sort
# 1176 chrY
# 12332 chr2
# 13469 chr1
# 3275 chr22
# 3284 chr21
# 3365 chrX
# 3961 chr20
# 4092 chr18
# 4405 chr13
# 5398 chr9
# 5515 chr19
# 5684 chr14
# 6251 chr10
# 6464 chr11
# 6720 chr17
# 6937 chr16
# 7428 chr15
# 7598 chr8
# 7627 chr7
# 7677 chr4
# 7867 chr12
# 8385 chr5
# 8483 chr6
# 9268 chr3