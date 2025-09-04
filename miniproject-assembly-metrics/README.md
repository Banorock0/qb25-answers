# Assembly Metrics Miniproject
## Jander Kugelman

Miniproject 1 to parse through .fasta files and calculate metrics.

## Required Fasta Files

*Caenorhabditis remanei*:

- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248909/caenorhabditis_remanei.PRJNA248909.WBPS19.genomic.fa.gz

- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248911/caenorhabditis_remanei.PRJNA248911.WBPS19.genomic.fa.gz

- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA53967/caenorhabditis_remanei.PRJNA53967.WBPS19.genomic.fa.gz

- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA577507/caenorhabditis_remanei.PRJNA577507.WBPS19.genomic.fa.gz

## Unzipped File Sizes:

- 115M caenorhabditis_remanei.PRJNA248909.WBPS19.genomic.fa

- 121M caenorhabditis_remanei.PRJNA248911.WBPS19.genomic.fa

- 141M caenorhabditis_remanei.PRJNA53967.WBPS19.genomic.fa

- 127M caenorhabditis_remanei.PRJNA577507.WBPS19.genomic.fa

## Usage
1. Make getGenomes.sh and assembly-metrics.py executable: 

    ```chmod +x getGenomes.sh assembly-metrics.py```

2. Run getGenomes.sh to download required fasta files and fasta module:

    ```./getGenomes.sh```

3. Run assembly-metrics.py to parse through fasta files and return number of contigs, total sequence length, and average sequence length:

    ```./assembly-metrics.py *.fa```

## Results

File Name: caenorhabditis_remanei.PRJNA248909.WBPS19.genomic.fa

Number of contigs: 1591, Total Length: 118549266, Average Length: 74512.42363293526

File Name: caenorhabditis_remanei.PRJNA248911.WBPS19.genomic.fa

Number of contigs: 912, Total Length: 124541912, Average Length: 136559.11403508772

File Name: caenorhabditis_remanei.PRJNA53967.WBPS19.genomic.fa

Number of contigs: 3670, Total Length: 145442736, Average Length: 39630.17329700272

File Name: caenorhabditis_remanei.PRJNA577507.WBPS19.genomic.fa

Number of contigs: 187, Total Length: 130480874, Average Length: 697758.6844919786