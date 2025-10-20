# 3.1
# Lab strain: 09, 11, 23, 35, 39
# Wine strain: 24, 27, 31, 62, 63

# 3.3
library(tidyverse)

df <- read.table("gt_long.txt",header=TRUE)
filter_df1 <- subset(df, chrom == "chrII" & sampleID == "A01_62")

filter_df1$genotype <- as.factor(filter_df1$genotype)

plt1 <- ggplot(filter_df1,aes(x=position,y=0,color=genotype)) +
  geom_point(size = 3) +
  labs(
    title = "Genotype by Position for chrII (Sample A01_62)",
    x = "Position",
    y = "",
    color = "Genotype"
  )
plt1
ggsave("figures/ex3_3.png", plot = plt1)

# The ends of the chromosome (positions 0 to ~0.5e5 and ~5.4e5 to ~8.2e5) seem to be mostly from the wine strain, while the inbetween region (postions ~0.5e5 to ~5.4e5) seem to mostly be from the lab strain. The transitions indicate where crossover between the lab and wine parent strains occured for chromosome 2 in sample A01_62.

# 3.4
filter_df2 <- subset(df,sampleID == "A01_62")

filter_df2$genotype <- as.factor(filter_df2$genotype)

plt2 <- ggplot(filter_df2,aes(x=position,y=0,color=genotype)) +
  geom_point(size = 3) +
  ylim(-0.25, 0.25) +
  facet_grid(rows = vars(chrom), scales = "free_x", space = "free_x")
plt2

ggsave("figures/ex3_4_1.png", plot = plt2, width=15, height=18)

df$genotype <- as.factor(df$genotype)

plt3 <- ggplot(df, aes(x = position, y = 0, color = genotype)) +
  geom_point(size = 3) +
  ylim(-0.25, 0.25) +
  facet_grid(rows = vars(chrom), cols = vars(sampleID), scales = "free_x", space = "free_x")
plt3

ggsave("figures/ex3_4_2.png", plot = plt3, width=30, height=18)