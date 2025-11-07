## Ex 1
# 1.1
library(tidyverse)
library(DESeq2)
library(broom)

data <- read_delim("data/gtex_whole_blood_counts_downsample.txt",delim = ",")
meta <- read_delim("data/gtex_metadata_downsample.txt",delim = ",")

data <- column_to_rownames(data,"GENE_NAME")

# 1.2
identical(colnames(data),meta$SUBJECT_ID)

dds <- DESeqDataSetFromMatrix(countData = data,
                              colData = meta,
                              design = ~ SEX + DTHHRDY + AGE)

# 1.3
vsd <- vst(dds)

pca_sex <- plotPCA(vsd, intgroup = "SEX") +
  ggtitle("PCA of GTEX Samples (SEX)")
pca_dthhrdy <- plotPCA(vsd, intgroup = "DTHHRDY") +
  ggtitle("PCA of GTEX Samples (DTHHRDY)")
pca_age <- plotPCA(vsd, intgroup = "AGE") +
  ggtitle("PCA of GTEX Samples (AGE)") +
  scale_color_gradientn(colors = c("red","purple","green"))

ggsave("figures/ex1_pca_sex.png", plot = pca_sex)
ggsave("figures/ex1_pca_dthhrdy.png", plot = pca_dthhrdy) 
ggsave("figures/ex1_pca_age.png", plot = pca_age)

# PC1 = 48% variance; PC2 = 7% variance

# PC1 is likely the DTHHRDY condition because the clusters of natural vs. ventilator
# deaths are distinct, indicating that the DTHHRDY condition is a major source of variation
# in whole-blood gene expression.

# PC2 is likely the sex condition as there seems to be a small amount of variation
# present along the PC2 axis that separates male vs. female that does not seem to 
# distinctly separate the other two conditions.

## Ex 2
# 2.1
vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()

vsd_df <- bind_cols(meta, vsd_df)

m_WASH7P <- lm(data = vsd_df, formula = WASH7P ~ 1 + SEX)
summary(m_WASH7P)
# The p-value for sex-differential expression of WASH7P is 0.327, which indicates
# that there is not a significant difference in gene expression between males and
# females of WASH7P.

m_SLC25A47 <- lm(data = vsd_df, formula = SLC25A47 ~ 1 + SEX)
summary(m_SLC25A47)
# The p-value for sex-differential expression of WASH7P is 0.0293, which indicates
# that there is a significant difference in gene expression between males and
# females of SLC25A47. As the coefficient of estimated standard deviation of males
# is positive, males generally have higher expression of SLC25A47 than females.

# 2.2
dds <- DESeq(dds)

# 2.3
res_sex <- results(dds, name = "SEX_male_vs_female") %>%
  as_tibble(rownames = "GENE_ID")

res_sex %>%
  drop_na() %>% 
  filter(padj < 0.1) %>%
  nrow()
# Genes that exhibit significant differential expression between males and females
# at a 10% FDR: 262

loc <- read_delim("data/gene_locations.txt")
colnames(loc) <- c("GENE_ID", "CHROM")

res_sex_mapped <- res_sex %>% left_join(loc, by = "GENE_ID") %>% 
  arrange(padj)

# Top hits
# Genes that are most strongly upregulated in males are on the Y chromosome, which
# makes sense because females do not have Y chromosomes. Genes that are most strongly
# upregulated in females are on the X chromosome, and the two highest (XIST and TSIX)
# are involved in X-chromosome inactivation, which only occurs in females.
# There are more male-upregulated genes near the top of the list.

# WASH7P and SLC25A47
WASH7P <- res_sex_mapped %>% filter(str_detect(GENE_ID, "WASH7P"))
SLC25A47 <- res_sex_mapped %>% filter(str_detect(GENE_ID, "SLC25A47"))
# The results for WASH7P and SLC25A47 are broadly consistent with the basic linear
# regression models. WASH7P is not significantly upregulated in males or females 
# (p-value = 0.4599348), and # SLC25A47 is significantly upregulated in males 
# (p-value = 1.045432e-09).

# Short reflection
# Using a very stringent FDR (e.g., 1%) reduces false positives but increases 
# false negatives (fewer discoveries -> lower power to detect true effects).
# Using a lenient FDR (e.g., 20%) increases the number of discoveries but includes 
# more false positives.
# Larger sample sizes and larger effect sizes increase power, decreasing false 
# negatives for a given FDR threshold.
# Conversely, small sample sizes and small effect sizes make it difficult to 
# detect true differences without increasing the false positive rate.


# 2.4
res_dthhrdy <- results(dds, name = "DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes") %>%
  as_tibble(rownames = "GENE_ID")

res_dthhrdy %>%
  drop_na() %>% 
  filter(padj < 0.1) %>%
  nrow()
# Genes that exhibit significant differential expression according to death classification
# at a 10% FDR: 16069

# 2.5
meta_shuffle <- meta %>% mutate(SEX = sample(SEX, replace = FALSE))

dds_shuffle <- DESeqDataSetFromMatrix(countData = data,
                              colData = meta_shuffle,
                              design = ~ SEX + DTHHRDY + AGE)

dds_shuffle <- DESeq(dds_shuffle)

res_sex_shuffle <- results(dds_shuffle, name = "SEX_male_vs_female") %>%
  as_tibble(rownames = "GENE_ID")

res_sex_shuffle %>%
  drop_na() %>% 
  filter(padj < 0.1) %>%
  nrow()

# Genes that exhibit significant differential expression between males and females
# at a 10% FDR: 262
# VS.
# Genes that exhibit significant differential expression between males and females
# at a 10% FDR for randomly shuffled metadata: 1221
# The number of genes that appear significant increased by about 1000 for my random
# dataset. This suggests that the FDR thresholds out false positives well by reducing
# the rate of false positives for large-scale datasets.

## Ex3
res_sex_mapped$significant <- with(res_sex_mapped, padj < 0.1 & abs(log2FoldChange) > 1)

res_sex_mapped <- res_sex_mapped %>% drop_na()

vc <- ggplot(res_sex_mapped, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point(aes(color = significant), alpha = 0.7) +
  scale_color_manual(values = c("FALSE" = "grey", "TRUE" = "red")) +
  scale_y_log10()
  ggtitle("Volcano Plot (SEX)")

vc

ggsave("figures/ex3_vc.png", plot = vc)