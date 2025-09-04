#!/usr/bin/env python3

# Py script to parse through gene expression data and metadata to print samples by gene

gene = {}
count = 0
first3 = []

# Open expression data file and populate dictionary with header and data of following line
with open("GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct") as f1:
    _ = f1.readline()
    _ = f1.readline()
    header = f1.readline().rstrip("\n").split("\t")
    data = f1.readline().rstrip("\n").split("\t")
    for i in range(len(header)):
        gene[header[i]] = data[i]

# Open metadata file and determine if sampid is in the dictionary keys to print in bed format
with open("GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt") as f2:
    next(f2)
    for line in f2:
        sampid = line.rstrip("\n").rsplit("\t")[0]
        smtsd = line.rstrip("\n").rsplit("\t")[6]
        if sampid in gene.keys():
            print(f"{sampid}\t{gene[sampid]}\t{smtsd}")
            if float(gene[sampid]) > 0 and count < 4:
                first3.append(smtsd)
                count+=1

print(f"\nFirst three tissues with expression > 0: {first3[0]}, {first3[1]}, and {first3[2]}")
# First three tissues with expression > 0: Brain - Cortex, Adrenal Gland, and Thyroid