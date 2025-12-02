#!/usr/bin/env python

import numpy as np
import sys

# 1.2
genome_size = 1000000
read_length = 100
coverage = int(sys.argv[1])

num_reads = genome_size * coverage / read_length
print("Number of reads:", num_reads)

genome_coverage = np.zeros(genome_size, dtype=int)

rng = np.random.default_rng()
start_positions = rng.integers(0, genome_size - read_length + 1, size=int(num_reads))

for start in start_positions:
    genome_coverage[start:start+read_length] += 1

percent_0 = np.count_nonzero(genome_coverage == 0) / genome_size * 100
print(f"Percentage genome with 0x coverage: {percent_0}%")

output_file = f"data/genome_cov_{coverage}x.txt"
with open(output_file, "w") as f:
    for value in genome_coverage:
        f.write(f"{value}\n")

print("Coverage file saved as:", output_file)