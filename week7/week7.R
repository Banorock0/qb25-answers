library(tidyverse)
library(matrixStats)

# Exercise 1
# 1.1
df_dat <- read.delim('data/read_matrix.tsv',header=TRUE)
mat_dat <- as.matrix(df_dat)

sds_dat <- rowSds(mat_dat) %>% sort(decreasing=TRUE)
mat_dat_filt <- mat_dat[names(sds_dat)[1:500],]

# 1.2
pca_dat_filt = prcomp(t(mat_dat_filt))
pca_dat_filt$x[1,1:2]
pca_dat_filt$sdev

# 1.3
df_pca <- pca_dat_filt$x[,1:2] %>% as.data.frame()
df_pca$tissue <- str_split_i(rownames(df_pca), '_', 1)
df_pca$rep <- str_split_i(rownames(df_pca), '_', 2)

plt_pca_err <- ggplot(df_pca,aes(x=PC1,y=PC2,color=tissue,shape=rep)) +
  geom_point()
  
plt_pca_err
ggsave("figures/ex1_3_pca_err.png", plot = plt_pca_err)

# Issue with PCA
# change labels:
## Fe_Rep1 -> LFC.Fe1_Rep3
## LFC.Fe_Rep3 -> Fe_Rep1

# Change mislabeled data for whole dataset
colnames(df_dat)[colnames(df_dat) == "Fe_Rep1"] <- "LFC.Fe_Rep3_temp"
colnames(df_dat)[colnames(df_dat) == "LFC.Fe_Rep3"] <- "Fe_Rep1_temp"

colnames(df_dat)[colnames(df_dat) == "LFC.Fe1_Rep3_temp"] <- "LFC.Fe1_Rep3"
colnames(df_dat)[colnames(df_dat) == "Fe_Rep1_temp"] <- "Fe_Rep1"

mat_dat <- as.matrix(df_dat)

sds_dat <- rowSds(mat_dat) %>% sort(decreasing=TRUE)
mat_dat_filt <- mat_dat[names(sds_dat)[1:500],]

pca_dat_filt = prcomp(t(mat_dat_filt))
pca_dat_filt$x[1,1:2]
pca_dat_filt$sdev

df_pca <- pca_dat_filt$x[,1:2] %>% as.data.frame()

df_pca$tissue <- str_split_i(rownames(df_pca), '_', 1)
df_pca$rep <- str_split_i(rownames(df_pca), '_', 2)
plt_pca_fix <- ggplot(df_pca,aes(x=PC1,y=PC2,color=tissue,shape=rep)) +
  geom_point()

plt_pca_fix
ggsave("figures/ex1_3_pca_fix.png", plot = plt_pca_fix)

pca_var <- pca_dat_filt$sdev %>% as.matrix() %>% as.data.frame() %>% rename("variance" = "V1")
pca_var$PCs <- rownames(pca_var) %>% as.numeric()
plt_var <- ggplot(pca_var, aes(x=PCs,y=variance)) +
  geom_bar(stat = "identity")
plt_var
ggsave("figures/ex1_3_var.png", plot = plt_var)

# Exercise 2
# 2.1
combined = df_dat[,seq(1, 21, 3)]
combined = combined + df_dat[,seq(2, 21, 3)]
combined = combined + df_dat[,seq(3, 21, 3)]
combined = combined / 3
mat_com <- as.matrix(combined)
sds_com <- rowSds(mat_com) %>% sort(decreasing=TRUE)
sds_com_sub <- sds_com[sds_com > 1]
mat_com_filt <- mat_com[names(sds_com_sub),]

# 2.2
set.seed(42)
kmean_results <- kmeans(mat_com_filt,12,nstart=100)
label_order <- as.factor(kmean_results$cluster) %>% sort() %>% as.matrix()
mat_com_filt_sort <- mat_com_filt[rownames(label_order),]
labels <- as.factor(kmean_results$cluster) %>% sort()

# Adjust margins and plot
par(mar = c(10, 4, 4, 2))
plt_hm <- heatmap(
  mat_com_filt_sort,
  Rowv = NA,
  Colv = NA,
  RowSideColors = RColorBrewer::brewer.pal(12, "Paired")[labels],
  xlab = "Tissue",
  ylab = "Gene",
  las = 2,
  cexCol = 0.5
)

# 3
cluster9 <- rownames(label_order)[label_order == 9]
write.table(cluster9,file = "data/cluster9.txt",quote = FALSE,row.names = FALSE, col.names = FALSE)
cluster12 <- rownames(label_order)[label_order == 12]
write.table(cluster12,file = "data/cluster12.txt",quote = FALSE,row.names = FALSE, col.names = FALSE)