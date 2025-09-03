#!/usr/bin/env python3

with open("ce11_genes.bed",'r') as f:
    for i in f:
        i = i.rstrip("\n").split("\t")
        if i[5] == "-":
            original_score = -1 * float(i[4])
        else:
            original_score = float(i[4])
        feature_size = int(i[2]) - int(i[1])
        new_score = original_score * feature_size
        print(f"{i[0]}\t{i[1]}\t{i[2]}\t{i[3]}\t{new_score}\t{i[5]}")