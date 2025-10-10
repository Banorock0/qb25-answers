library(tidyverse)
# Step 2.2
df1 <- read.table("AF.txt",header=TRUE)
plt1 <- ggplot(df1,aes(x=AF)) +
  geom_histogram(bins=11)
plt1

ggsave("figures/ex2_1.png", plot = plt1)

# I think that the figure looks as expected with most common allelic frequency around 0.5.
# Crossing two haploid strains together will on average result in 50/50 representation from 
# each parent due to crossover events, however, at a specific site, the allelic variation could 
# be higher or lower.
# The distribution looks relatively symmetric.

# Step 2.3
df2 <- read.table("DP.txt",header=TRUE)
plt2 <- ggplot(df2,aes(x=DP)) +
  geom_histogram(bins=21) +
  xlim(0,20)
plt2

ggsave("figures/ex2_2.png", plot = plt2)

# The figure looks as expected, with the lower read depths ~5 occurring the most frequently.
# The lower read depth likely correlates with the average fragmentation size for the fragments being sequenced.
# The distribution looks right skewed.

