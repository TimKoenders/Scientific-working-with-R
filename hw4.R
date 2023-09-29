# Header ------------------------------------------------------------------

rm(list = ls())
gc()

pacman::p_load(
  tidyverse,
  urca,
  readxl,
  ggplot2,
  lubridate,
  janitor,
  MASS,
  stargazer
)


# Analysis --------------------------------------------------------------

df <- read.csv("WineQT.csv")
glimpse(df)
View(df)

# Create a histogram of the "quality" column
library(ggplot2)
histogram_plot <- ggplot(df, aes(x = quality)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black") +
  labs(title = "Histogram of Wine Quality",
       x = "Quality",
       y = "Frequency")
print(histogram_plot)

# Generate a new column 'good_wine'
df$good_wine <- ifelse(df$quality >= 6, 1, 0)
View(df)

# Replace all periods with underscores
colnames(df) <- gsub("\\.", "_", colnames(df))

# Convert all column names to lowercase
colnames(df) <- tolower(colnames(df))
glimpse(df)
View(df)

# Select relevant variables
df_analysis <- dplyr::select(df, good_wine, alcohol, sulphates, ph, 
                             density, citric_acid, volatile_acidity)
# Run the logistic regression
logistic_model <- glm(good_wine ~ alcohol + sulphates + ph + density + citric_acid + volatile_acidity, 
                      data = df_analysis, family = binomial(link = "logit"))
summary(logistic_model)

# Run the probit regression
probit_model <- glm(good_wine ~ alcohol + sulphates + ph + density + citric_acid + volatile_acidity, 
                    data = df, family = binomial(link = "probit"))
summary(probit_model)

# Generate the LaTeX table
stargazer(logistic_model, probit_model, 
          title="Logistic and Probit Regressions for Wine Quality Data",
          label="tab:models",
          table.placement = "ht",
          type="latex")



