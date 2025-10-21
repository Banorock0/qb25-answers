# Week 5
### 2.2
1. The slope is 0.37757. This means that per year of age, generally, the number of maternal de novo mutations increases by ~0.38. It seems to match the plot, but the data is pretty scattered, so it might not be the most representative.
2. The relationship is significant as indicated by the *** next to the slope of Mother_age. This means that the p-value is equal to or below 0.001. That indicates that the null hypothesis (i.e., the relationship between maternal age and dnm) can be rejected as there is a 0.1% chance that the data will confirm that there is no relationship.

### 2.4
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 10.32632    1.70235   6.066 3.08e-09 ***
Father_age   1.35384    0.05353  25.291  < 2e-16 ***

dnm@50.5 = 10.32632 + 1.35384 * 50.5
         = 78.69546 

### 2.6
data:  df_merge$n_mat and df_merge$n_pat
t = -61.609, df = 395, p-value < 2.2e-16
alternative hypothesis: true mean difference is not equal to 0
95 percent confidence interval:
 -40.48685 -37.98284
sample estimates:
mean difference 
      -39.23485 

On average, there were about 39 more contributions to de novo mutations from the father than the mother per proband. This does reflect the trend seen in ex2_c_pid.png. The relationship is significant with a p-value < 2.2e-16. This p-value is effectively 0, meaning that there is an extremely strong statistical difference between maternal and paternal dnm counts (i.e., 0% chance that the observed difference occurred by chance).

lm(formula = I(df_merge$n_pat - df_merge$n_mat) ~ 1, data = df_merge)

Residuals:
    Min      1Q  Median      3Q     Max 
-30.235  -9.235  -1.235   7.765  61.765 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  39.2348     0.6368   61.61   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

The coefficient of the intercept should and does agree with the mean difference from the t-test, which indicates how many more contributions (~39) to de novo mutations the father provides than the mother per proband.

### 3.1
Dataset: 2025-09-23 - FIDE Chess Player Ratings

### 3.2
- The GM title group has markedly higher ratings than other titles.  
- There is a positive trend between age and rating, but considerable variability.  
- Rating distributions by title show long tails and overlap between titles for some age ranges.


### 3.3
**Hypothesis:** For titled chess players, older age is associated with higher FIDE ratings, after accounting for title.  
**Model fitted:** `rating ~ age + title`  
**Results:**  
- Age coefficient -3.25045 → For each additional year of age, rating decreases by ~3.25045 points, on average, holding title constant.  
- Title coefficients:
    - titleFM      159.20277   
    - titleGM      430.30283   
    - titleIM      276.59961   
    - titleWCM    -289.98268   
    - titleWFM     -90.54255   
    - titleWGM     146.33363   
    - titleWIM      21.33234
- p-value for age < 0.001 → the association is statistically significant.  
- R² =  0.7124
**Interpretation:**  
While age has a statistically significant negative association with rating, the practical effect is modest compared to the large rating differences associated with title. Thus, title is the major differentiator of rating.