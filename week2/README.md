Exercise 1:
```
bowtie2 -p 4 -x /Users/cmdb/qb25-answers/week2/genomes/sacCer3 -U ~/Data/BYxRM/fastq/A01_01.fq.gz > A01_01.sam

samtools sort -o A01_01.bam A01_01.sam

samtools index A01_01.bam

samtools idxstats A01_01.bam > A01_01.idxstats
```

Exercise 2:
The haplotype markers match up with the visualization in IGV (i.e., R markers look the same and B markers look the same).

Exercise 4:
```
minimap2 -a -x map-ont ../genomes/sacCer3.fa ERR8562478.fastq > longreads.sam
```

Exercise 5:
```
hisat2 -p 4 -x /Users/cmdb/qb25-answers/week2/genomes/sacCer3 -U /Users/cmdb/qb25-answers/week2/rawdata/SRR10143769.fastq > SRR10143769.sam
```

The 3' ends of each gene seems to have the most coverage.