# Exercises
## 1
### 1.1
- 100bp reads
- 1Mbp genome
- 3x coverage

Number of reads needed: $\frac{1Mbp * 3x}{100bp} = 30K\ reads$

### 1.4
1. Percentage genome with 0x coverage: 4.8409%
2. The data fits the poisson expectations well. The normal distribution underestimates the number of 1x to 2x coverage and overestimates the regions of 3x-5x coverage.

### 1.5
1. Percentage genome with 0x coverage: 0.005%
2. The data mostly fits the poisson expectations with a small underestimate for 10x coverage. The normal distribution underestimates coverage between 5x and 10x and overestimates between 11x and 16x coverage.

### 1.6
1. Percentage genome with 0x coverage: 0.0015999999999999999%
2. The data mostly fits the poisson expectations with overestimation for 30x coverage and underestimation for 29x coverage. The normal distribution underestimates coverage between 20x and 29x and overestimates between 30x and 40x coverage.

## 2
### 2.4
dot -Tpng data/graph.dot -o figures/ex2_digraph.png

### 2.5
Possible sequence: CATTGATTCTTATTCATTT

### 2.6
To accurately reconstruct the genome, the graph needs to contain a unique path. This requires a sufficient read length and coverage so that the nodes can be resolved. Repeats must be shorter than the readlength. Without enough coverage or with repeats longer than k, multiple paths exist and the genome cannot be reconstructed.