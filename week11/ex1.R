suppressPackageStartupMessages(library(tidyverse))

args <- commandArgs(trailingOnly = TRUE)
filename <- args[1]
lambda <- as.numeric(args[2])
mu <- as.numeric(args[3])
sd <- as.numeric(args[4])

plot_title <- paste0(lambda, "x Genome Coverage")
output_file <- paste0("figures/ex1_", lambda, "x_cov.png")

coverage <- scan(filename)
genome_size = length(coverage)

df <- data.frame(coverage = coverage)

xs <- 0:max(coverage)

pois_df <- data.frame(
  xs = xs,
  counts = dpois(xs, lambda) * genome_size
)

norm_df <- data.frame(
  xs = xs,
  counts = dnorm(xs, mean = mu, sd = sd) * genome_size
)

h <- ggplot(df, aes(x = coverage, color = "A")) +
  geom_histogram(
    binwidth = 1,
    fill = "grey"
  ) +
  geom_line(
    data = pois_df,
    aes(x = xs, y = counts, color = "B"),
    linewidth = 1.2,
  ) +
  geom_line(
    data = norm_df,
    aes(x = xs, y = counts, color = "C"),
    linewidth = 1.2
  ) +
  scale_color_manual(
    name = "",
    values = c("A" = "black", "B" = "blue", "C" = "red"),
    labels = c("A" = "Coverage", "B" = "Poisson Distribution", "C" = "Normal Distribution")
  ) +
  labs(
    title = plot_title,
    x = "Coverage",
    y = "Count of Genome Positions"
  )

ggsave(output_file, plot = h)