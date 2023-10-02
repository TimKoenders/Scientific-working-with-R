######### Final project ##########
# Header ------------------------------------------------------------------

rm(list = ls())
gc()

pacman::p_load(
  tidyverse,
  ggplot2,
  lubridate,
  MASS,
  stargazer
)


# Data Set-up -------------------------------------------------------------
df <- read.csv("Housing.csv") #Loading the data
View(df)
dim(df)  # Displays the number of rows and columns in the dataframe.
str(df)  # Provides information about the structure of the dataframe.
summary(df)  #Provides summary statistics for numeric columns.
df$area_m2 <- df$area * 0.092903 # 1 square foot is approximately equal to 0.092903 square meters
df <- df[, !(names(df) == "area")] # Remove the original 'area' column from the dataframe
df$price_million <- df$price / 1000000 # Convert the price column to millions of dollars
df <- df[, !(names(df) == "price")] # Remove the original price column
glimpse(df)
df <- df %>% # Converting to fractors
  mutate(
    mainroad = as.factor(mainroad),
    guestroom = as.factor(guestroom),
    basement = as.factor(basement),
    hotwaterheating = as.factor(hotwaterheating),
    airconditioning = as.factor(airconditioning),
    prefarea = as.factor(prefarea),
    furnishingstatus = as.factor(furnishingstatus)
  )
str(df) # Check the structure of the data frame
summary(df[, sapply(df, is.numeric)]) # Provide summary statistics
cor_df <- cor(df[, sapply(df, is.numeric)])
cor_df


# Data Visualization ------------------------------------------------------

# Scatter plot of area_m2 vs. price_million with a trend line
ggplot(df, aes(x = area_m2, y = price_million)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(x = "Area (in square meters)", y = "Price (in million dollars)",
       title = "Scatter Plot of Area vs. Price with Trend Line")

# Boxplots of price_million by furnishingstatus
ggplot(df, aes(x = furnishingstatus, y = price_million, fill = furnishingstatus)) +
  geom_boxplot() +
  labs(x = "Furnishing Status", y = "Price (in million dollars)",
       title = "Boxplots of Price by Furnishing Status")

# Histogram of bedrooms
ggplot(df, aes(x = bedrooms)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(x = "Number of Bedrooms", y = "Frequency",
       title = "Histogram of Bedrooms")
# This histogram visualizes the distribution of the number of bedrooms in the dataset, showing the frequency of houses with different bedroom counts.

# Bar chart of mainroad vs. airconditioning
ggplot(df, aes(x = mainroad, fill = airconditioning)) +
  geom_bar(position = "dodge") +
  labs(x = "Main Road", y = "Count",
       title = "Bar Chart of Main Road vs. Air Conditioning",
       fill = "Air Conditioning")
# This bar chart shows a comparison of the counts of houses on the main road and whether they have air conditioning.
# Linear regression and scatterplot -------------------------------------------------------
lm_model <- lm(price_million ~ ., data = df)
lm_model
library(stargazer)
stargazer(lm_model, 
          title = "Linear Regression Results",
          align = TRUE,       
          style = "default",  
          digits = 3,         
          type = "latex",     
          out = "regression_table.tex")  

predicted_values <- predict(lm_model)
prediction_df <- data.frame(
  Actual = df$price_million,
  Predicted = predicted_values
)
ggplot(prediction_df, aes(x = Actual, y = Predicted)) +
  geom_point() +
  labs(x = "Actual Price (in million dollars)", y = "Predicted Price (in million dollars)",
       title = "Scatter Plot of Actual vs. Predicted Prices")
# Lasso regression and scatterplot ----------------------------------------
library(glmnet)
library(dplyr)

X <- data.matrix(df[, !names(df) %in% "price_million"])
y <- df$price_million

# Run LASSO regression with lambda = 0.5
lasso_model <- glmnet(X, y, alpha = 1, lambda = 0.5)
lasso_model

# Predict the values using the LASSO regression model
lasso_predicted_values <- predict(lasso_model, X)
lasso_prediction_df <- data.frame(
  Actual = y,
  Predicted = as.vector(lasso_predicted_values)
)
# Create a scatter plot
ggplot(lasso_prediction_df, aes(x = Actual, y = Predicted)) +
  geom_point() +
  labs(x = "Actual Price (in million dollars)", y = "Predicted Price (in million dollars)",
       title = "Scatter Plot of Actual vs. Predicted Prices")


# Split the data into training and test sets
n <- nrow(df)
test_prop <- 0.2
set.seed(12)
train <- sample(n, (1 - test_prop) * n)
X <- data.matrix(df[, !names(df) %in% "price_million"])
y_train <- df[train, "price_million"]
y_test <- df[-train, "price_million"]
X_train <- X[train, ]
X_test <- X[-train, ]

# Define a lambda grid for Lasso
lambda_grid <- seq(0.01, 5, 0.01)

# Fit Lasso models with cross-validation
lasso_model <- glmnet(X_train, y_train, alpha = 1, lambda = lambda_grid)
cv_lasso <- cv.glmnet(X_train, y_train, alpha = 1)

# Find the best lambda value
lambda_best <- cv_lasso$lambda.min

# Predict using the best Lasso model
y_hat_lasso <- predict(lasso_model, s = lambda_best, newx = X_test)
best_lasso_MSE <- mean((y_test - y_hat_lasso)^2)

# Output the MSE for the best Lasso model
cat("Best Lasso Model MSE:", best_lasso_MSE, "\n")

# Fit the winner Lasso model with the best lambda
winner_model <- glmnet(X_train, y_train, alpha = 1, lambda = lambda_best)

# Display the coefficients of the winner Lasso model
coef(winner_model)