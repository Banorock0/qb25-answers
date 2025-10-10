#!/bin/bash

# Step 1.1
# samtools index -M *.bam

# Q1.1
for sample in "A01_09" "A01_11" "A01_23" "A01_24" "A01_27" "A01_31" "A01_35" "A01_39" "A01_62" "A01_63"
do
    echo -en $sample"\t" 
    samtools view -c $sample.bam
done > read_counts.txt

# A01_09	669548
# A01_11	656245
# A01_23	708732
# A01_24	797385
# A01_27	602404
# A01_31	610360
# A01_35	803554
# A01_39	713726
# A01_62	816639
# A01_63	620829

# Step 1.2
for sample in "A01_09" "A01_11" "A01_23" "A01_24" "A01_27" "A01_31" "A01_35" "A01_39" "A01_62" "A01_63"
do
    echo $sample.bam 
done > bamListFile.txt

# run FreeBayes to discover variants 
freebayes -f sacCer3.fa -L bamListFile.txt --genotype-qualities -p 1 > unfiltered.vcf

# the resulting VCF file is unfiltered, meaning that it contains low-confidence calls and also has some quirky formatting, so the following steps use a software suite called vcflib to clean up the VCF

# filter the variants based on their quality score and remove sites where any sample had missing data
vcffilter -f "QUAL > 20" -f "AN > 9" unfiltered.vcf > filtered.vcf

# FreeBayes has a quirk where it sometimes records haplotypes rather than individual variants; we want to override this behavior
vcfallelicprimitives -kg filtered.vcf > decomposed.vcf

# in very rare cases, a single site may have more than two alleles detected in your sample; while these cases may be interesting, they may also reflect technical errors and also pose a challenge for parsing the data, so we remove them
vcfbreakmulti decomposed.vcf > biallelic.vcf