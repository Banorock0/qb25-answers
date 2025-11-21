import sys
import numpy as np
from fasta import readFASTA

def needleman_wunsch(f, sf, gp, o):

    # 1.1
    input_sequences = readFASTA(open(f))
    seq1_id, seq1 = input_sequences[0]
    seq2_id, seq2 = input_sequences[1]

    sigma = {}
    fs = open(sf)
    alphabet = fs.readline().strip().split()
    for line in fs:
        line = line.rstrip().split()
        row_char = line[0]
        for i in range(1, len(line)):
            sigma[(alphabet[i-1], row_char)] = float(line[i])
    fs.close()

    n = len(seq1)
    m = len(seq2)

    # 1.2
    F = np.zeros((n+1, m+1), dtype=float)
    TB = np.zeros((n+1, m+1), dtype=object)

    # 1.3
    for i in range(1, n + 1):
        F[i][0] = F[i-1][0] + gp
        TB[i][0] = 'U'

    for j in range(1, m + 1):
        F[0][j] = F[0][j-1] + gp
        TB[0][j] = 'L'


    # Fill scoring matrix
    for i in range(1, n+1):
        for j in range(1, m+1):

            char1 = seq1[i-1]
            char2 = seq2[j-1]

            # substitution score from matrix
            d = F[i-1, j-1] + sigma[(char1, char2)]
            u = F[i-1, j] + gp
            l = F[i, j-1] + gp

            F[i, j] = max(d, u, l)

            # Traceback flags
            if F[i,j] == d:
                TB[i,j] = 'D'
            elif F[i,j] == u:
                TB[i,j] = 'U'
            else:
                TB[i,j] = 'L'

    # 1.4
    i, j = n, m
    sequence1_alignment = ""
    sequence2_alignment = ""

    while i > 0 or j > 0:
        direction = TB[i][j]
        if direction == 'D':
            sequence1_alignment = seq1[i-1] + sequence1_alignment
            sequence2_alignment = seq2[j-1] + sequence2_alignment
            i -= 1
            j -= 1
        elif direction == 'U':
            sequence1_alignment = seq1[i-1] + sequence1_alignment
            sequence2_alignment = '-' + sequence2_alignment
            i -= 1
        elif direction == 'L': 
            sequence1_alignment = '-' + sequence1_alignment
            sequence2_alignment = seq2[j-1] + sequence2_alignment
            j -= 1
    identity_alignment = ''
    for k in range(len(sequence1_alignment)):
        if sequence1_alignment[k] == sequence2_alignment[k]:
            identity_alignment += '|'
        else:
            identity_alignment += ' '

    output = open(o, 'w')

    for i in range(0, len(identity_alignment), 100):
        output.write(sequence1_alignment[i:i+100] + '\n')
        output.write(identity_alignment[i:i+100] + '\n')
        output.write(sequence2_alignment[i:i+100] + '\n\n\n')

    # 1.5
    num_matches = sum(
        1 for a, b in zip(sequence1_alignment, sequence2_alignment) if a == b
    )

    identity_pct = 100 * num_matches / len(sequence1_alignment)

    gaps_seq1 = sequence1_alignment.count('-')
    gaps_seq2 = sequence2_alignment.count('-')

    alignment_score = F[n][m]

    if f.endswith(".faa"):
        print("Amino Acid Alignment")
    else:
        print("DNA Alignment:")
    print("- Alignment score:", alignment_score)
    print("- Gaps in sequence 1:", gaps_seq1)
    print("- Gaps in sequence 2:", gaps_seq2)
    print("- Identity (%): {:.2f}".format(identity_pct))


f = sys.argv[1]
sf = sys.argv[2]
gp = float(sys.argv[3])
o = sys.argv[4]

needleman_wunsch(f, sf, gp, o)