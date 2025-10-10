#!/usr/bin/env python3

f_name = "biallelic.vcf"
count = 0

Q1 = False

if Q1 == True:
    print("AF")

    for line in open(f_name):
        if line.startswith('#'):
            continue
        fields = line.rstrip("\n").split("\t")

        # grab what you need from `fields`
        if "AF=" in fields[7]:
            f7 = fields[7].split(";")
            for i in f7:
                if "AF=" in i:
                    if i[0] == "A":
                        AF = i.split("=")
                        print(AF[1])
else:
    print("DP")

    for line in open(f_name):
        if line.startswith('#'):
            continue
        fields = line.rstrip("\n").split("\t")

        # grab what you need from `fields`
        f9 = fields[9].split(":")
        print(f9[2])
