#!/usr/bin/env conda run -n qb25 python
import sys

sample_ids = ["A01_62", "A01_39", "A01_63", "A01_35", "A01_31",
              "A01_27", "A01_24", "A01_23", "A01_11", "A01_09"]

sample_ids = sorted(sample_ids)

with open("gt_long.txt","w") as o:
    sys.stdout = o

    print("sampleID\tchrom\tposition\tgenotype")

    with open("biallelic.vcf","r") as i:

        for line in i:
            if line.startswith("#"):
                continue
            
            fields = line.rstrip("\n").split()
            chrom = fields[0]
            pos   = fields[1]

            for sample in sample_ids:
                data = fields[9]
                if (data[0] == "0") or (data[0] == "1"):
                    print(f"{sample}\t{chrom}\t{pos}\t{data[0]}")
                else:
                    continue