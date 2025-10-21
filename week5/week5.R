library(tidyverse)
library(broom)

# Exercise 1
# 1.1
df_dnm <- read.csv("aau1043_dnm.csv")

# 1.2
df_dnm_counts <- df_dnm %>% group_by(Proband_id,Phase_combined) %>%
  summarize(n = n()) %>% filter(Phase_combined != "")

# 1.3
df_page <- read.csv("aau1043_parental_age.csv")

# 1.4
df_merge <- merge(df_page,df_dnm_counts)

# Exercise 2
# 2.1a
df_mat <- subset(df_merge, Phase_combined == "mother", select = -Father_age) %>% rename(n_mat = n)
plt_mat <- ggplot(df_mat,aes(x=Mother_age,y=n_mat)) +
  geom_point()
plt_mat
ggsave("figures/ex2_a.png", plot = plt_mat)
# 2.1a
df_pat <- subset(df_merge, Phase_combined == "father", select = -Mother_age) %>% rename(n_pat = n)
plt_pat <- ggplot(df_pat,aes(x=Father_age,y=n_pat)) +
  geom_point()
plt_pat
ggsave("figures/ex2_b.png", plot = plt_pat)

# 2.2
model_mat <- lm(data = df_mat, formula = n_mat ~ 1 + Mother_age)
summary(model_mat)

# 2.3
model_pat <- lm(data = df_pat, formula = n_pat ~ 1 + Father_age)
summary(model_pat)

# 2.4
father_x <- tibble(Father_age = 50.5)
dnm_x <- predict(model_pat, newdata = father_x)
print(dnm_x)

# 2.5
df_mat <- subset(df_mat, select = -Phase_combined)
df_pat <- subset(df_pat, select = -Phase_combined)
df_merge <- merge(df_mat,df_pat)

dnm_merge <- data.frame(
  probandid = df_merge$Proband_id,
  count = c(df_merge$n_mat, df_merge$n_pat),
  age = c(df_merge$Mother_age, df_merge$Father_age),
  parent = rep(c("Maternal", "Paternal"), each = nrow(df_merge))
)
# not sure if asking for distribution across proband or age here
plt_dnm_age <- ggplot(dnm_merge, aes(x = age, fill = parent)) +
  geom_histogram(alpha = 0.5, position = "identity", bins = 30)
plt_dnm_age
ggsave("figures/ex2_c_age.png", plot = plt_dnm_age)
plt_dnm_proband <- ggplot(dnm_merge, aes(x = count, fill = parent)) +
  geom_histogram(alpha = 0.5, position = "identity", bins = 30)
plt_dnm_proband
ggsave("figures/ex2_c_pid.png", plot = plt_dnm_proband)

# 2.6
t.test(df_merge$n_mat, df_merge$n_pat, paired = TRUE)
fit_diff <- lm(I(df_merge$n_pat - df_merge$n_mat) ~ 1, data = df_merge)
summary(fit_diff)

# 3.1
library(tidytuesdayR)
tt_data <- tidytuesdayR::tt_load("2025-09-23")
fide_sep <- tt_data$fide_ratings_september

# 3.2
## 1) rating vs age
fide_sep <- fide_sep %>% mutate(age = 2025 - bday)

ggplot(fide_sep, aes(x = age, y = rating)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(x = "Age (years)", y = "FIDE Rating",
       title = "FIDE Rating vs Age - Sep")
ggsave("figures/ex3a_rating_vs_age_sep.png", width = 6, height = 4)

## 2) rating by title (GM, IM, etc)
ggplot(fide_sep, aes(x = title, y = rating)) +
  geom_boxplot(alpha = 0.7) +
  coord_flip() +
  labs(x = "Title", y = "FIDE Rating",
       title = "Distribution of Ratings by Title")

ggsave("figures/ex3b_rating_by_title.png", width = 6, height = 4)

# 3.3
lm_model <- lm(rating ~ age + title, data = fide_sep)
summary(lm_model)
