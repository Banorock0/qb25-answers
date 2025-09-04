# Codon Usage Miniproject
## Jander Kugelman

Miniproject 2 to translate codons into amino acids, count the proportion, and compare amino acid composition between different proteins.

## Exercise 2:
codon-usage.py parses through fasta files and prints the identifier of each sequence and prints each codon in the sequence. The script is correct because for each sequence in the fasta file, the identifier is printed to the terminal following by the codons in the sequences, starting with a methionine and ending with a stop codon.

## Exercise 3:
subset.fa returns the following dictionary:

```{'*': 1, 'A': 17, 'C': 4, 'D': 5, 'E': 10, 'F': 7, 'G': 12, 'H': 3, 'I': 7, 'K': 6, 'L': 17, 'M': 3, 'N': 5, 'P': 13, 'Q': 3, 'R': 9, 'S': 13, 'T': 11, 'V': 8, 'Y': 1}```

This is correct because there are two genes that are within the subset.fa file, so there should be at least two M. Also, only one of the gene sequences is fully intact, so there should only be one stop codon.

cytoplasm.fa and membrane return the following dictionaries, respectfully:

```{'*': 100, 'A': 3183, 'C': 954, 'D': 2252, 'E': 3544, 'F': 1610, 'G': 2663, 'H': 1273, 'I': 1907, 'K': 2570, 'L': 4769, 'M': 988, 'N': 1704, 'P': 2762, 'Q': 2166, 'R': 2622, 'S': 3808, 'T': 2633, 'V': 2525, 'W': 535, 'Y': 1201}```

```{'*': 100, 'A': 3364, 'C': 1031, 'D': 2039, 'E': 2953, 'F': 1961, 'G': 3143, 'H': 1224, 'I': 2365, 'K': 2207, 'L': 5044, 'M': 1010, 'N': 1797, 'P': 3053, 'Q': 1879, 'R': 2511, 'S': 4272, 'T': 3468, 'V': 2921, 'W': 595, 'Y': 1438}```

The cytoplasm has greater abundance of D, E, H, K, Q, and R.
The membrane has greater abundance of A, C, F, G, I, L, M, N, P, S, T, V, W, and Y.

The interior of membrane is hydrophobic, which is likely the reason why there is a higher abundance of residues with hydrophobic side chains.