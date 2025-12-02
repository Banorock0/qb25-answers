#!/usr/bin/env python3

reads = ['ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT', 'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT']

k = 3
graph = set()

for read in reads:
    for i in range(len(read) - k):
        kmer1 = read[i:i+k]
        kmer2 = read[i+1:i+1+k]
        graph.add(f"{kmer1} -> {kmer2}")

with open("data/edges.txt", "w") as f:
    for edge in graph:
        f.write(f"{edge}\n")
    
with open("data/graph.dot", "w") as f:
    f.write("digraph debruijn {\n")
    for edge in graph:
        f.write(f"    {edge};\n")
    f.write("}\n")