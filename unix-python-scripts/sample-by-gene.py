#!/usr/bin/env python3

with open("gencode.v46.basic.annotation.gtf","r") as f:
    for line in f:
        if line.startswith("#"): continue
        line = line.rstrip("\n").split("\t")
        if line[2] != "gene": continue
        name = line[8].split("\"")[5]
        print(f"{line[0]}\t{int(line[3])-1}\t{int(line[4])}\t{name}")