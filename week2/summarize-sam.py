#!/usr/bin/env python3

import sys

idxstats = {}
mismatches = {}

# Check if files are passed as an argument
if len(sys.argv) > 1:

    # Test if filepath
    try:

        # Open file
        with open(sys.argv[1],"r") as f:
            
            for line in f:

                # Skip lines starting with @
                if line.startswith("@"): continue
                line = line.rstrip("\n").split("\t")
                key = line[2]
                idxstats.setdefault(key,0)
                idxstats[key] += 1

                for i in line:
                    if i.startswith("NM"):
                        val = int(i.split(":")[2])
                        mismatches.setdefault(val,0)
                        mismatches[val] += 1

            d1 = {key: value for key, value in sorted(idxstats.items())}

            move1 = d1["chrM"]
            move2 = d1["*"]

            del d1["chrM"]
            del d1["*"]

            d1["chrM"] = move1
            d1["*"] = move2

            for k in d1.keys():
                print(f"{k}\t{d1[k]}")

            d2 = {key: value for key, value in sorted(mismatches.items())}

            for l in d2.keys():
                print(f"{l}\t{d2[l]}")

    # Error if file not found
    except FileNotFoundError:
        print(f"Error: File {f} not found.")

# Error if < 1 arguments
else:
    print("Usage: assembly-metrics.py <file_path> N")