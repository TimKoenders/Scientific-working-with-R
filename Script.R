###### Course: Scientific working with R

# Class 1 -----------------------------------------------------------------
getwd()
dir()
2 + 2
2-2
2/3
sin(2 * pi)
log(2)
exp(1)
log(exp(1))
# Logical operators
x <- 2 #, =, <<-, ->, ->>
y <- 3
x > 2
x >= 2
x == 3
(x <= 2) & (y ==3)
(x < 2) | (y== 3)
!(y ==3) #! symbol represents negation

#### Data types
## atomoric classes
# Character, integer, numeric, complex,
# logical
"abcd"
class(12.5)
class(12)
12L
class(1 + 2i)
class(TRUE)
class(F)

1/0
0/0

# vector --- same class of elements
#list --- any classes of elements
x <- c(0.5, 0.8)
x <- c(TRUE, FALSE, TRUE)
x <- c(T,F)
x <- c("a", "b", "c")
length(x)
x <- 9:30
x[5]

x <- vector("numeric", 10)
x <- vector ("logical",5)
?vector

y<- c(1.5, "ab")

x <- 0:6
class(x)
y <- as.numeric(x)
as.numeric(x)
as.logical(x)
as.factor(x)

x <- c("a", "b", "c", "d")
as.numeric(x)

x <- list("a", 1, TRUE)
x <- list("a", list(1,"b"))
x[[2]]


# Matrices
m <- matrix(nrow =2, ncol =3)
dim(m)
dim(m)[1]
nrow(m)

m <- matrix(1:6, nrow =2)
m <- matrix(1:6, nrow =2, ncol =3, byrow = T)
t(m)
attributes(m)
m <- 1:10 
dim(m) <- c(5,2)

x <- c(3,4,5)
y <- c(5,7,8)

rbind(x,y)
cbind(x,y)

# Factorss -- represent categorical data
# Unordered, ordered

x <- c("y", "n", "y", "y")
x <- factor(x)
table(x)
unclass(x)
factor(c("y", "n", "n", "y","y"),levels = c("y","n"))
x

# missing values NA and NaN
x <- c(1,2, NaN, NA, 5)
x[4]
x[3]
is.na(x)
x[is.na(x)]
x[!is.na(x)]
is.nan(x)

# Data frames -- collection of columns
# Columns --- potentially different classes
# Coloumns of the same length!

df <- data.frame(
  num <- 2:5, 
  logical_Values <- c(T, T, T, F)
)

df <- data.frame(
  num <- 2:5, 
  char <- c('a', 'b', 'c', 'd')
)

df[2,1]
df[,1]
df[2,]
df[c(1,4),1]
df$num
df$char
names(df)

x <- 1:3
names(x) <- c("first", "second", "th")
x["second"] + 3

# Reading in data

library(readxl)
imdb_top_1000 <- read_excel("C:/Users/koend/OneDrive/Bureaublad/WU 2023-2024/Scientific working with R and LaTex/imdb_top_1000.xlsx")

# Indexing

x <- c("a", "b", "c", "d", "d")
x[1]
x[1:3]
x[c(2,4)]
x[x > "a"]
log_vec <- (x > "a")
x[log_vec]
x[!log_vec]
x[-3]
x[-c(2,4)]

m <- matrix(1:6, nrow = 2)
m[1,2]
m[1,2:3, drop = F]

# removing NA values
x <- c(1,2, NA, 4, NA, 6)
bad <- is.na(x)
x[!bad]
y <- c("a", "NA", "c", "d", NA, "f")
complete.cases(x,y)
x[good]
y[good]

y <- 10:13
x + y
x - y
x*y
x / y

x >= 2 
y == 11
x <- matrix(1:4, nrow =2)
y <- matrix (5:8, nrow =2)
x*y
x / y
x %*% y  # matrix multiplication 


# Control structures
x <- 5
if (x <2) {
  print("x is less than 2")
} else {
  print("x is geq 2")
} 

if (x < 2) {
  print("x is less than 2")
} else if (x < 6) {
  print("x is between 2 and 6")
} else {
  print("x is greater than 6")
}
 
for (i in 1:10){
  print(i)
}

y <- c(2,3,5)
for (element in y){
  print(element)
}

letters <- c("a", "b", "c")
word <- ""
for (letter in letters) {
  word <- paste(word, letter, sep = "")
}

x <- matrix(1:6, nrow =2)
for (i in 1:nrow(x)){
  for(j in 1:ncol(x)){
    print(x[i,j])
  }
}

x <- matrix(1:6, nrow = 2)
for (i in 1:nrow(x)) {
  for (j in 1:ncol(x)) {
    x[i, j] <- i + j
    print(x[i, j])  # Uncomment this line if you want to print the updated values
  }
}

count <- 0
while(count < 10){
  print(count)
  count = count -1
}

# random walk
q <- 0 
while(q >= -5 & q <=5){
  print(q)
  coin <- rbinom(1, 1, 0.5)
  
  if (coin ==1) {
    q = q +1
  } else {
     q -1
  }
  storage_for_q <- c(storage_for_q, q)
}

plot(storage_for_q)

# other control structures --- repeat, break

add_two_numbers <- function(a,b) {
  result <- a + b
  return(result)
}
add_two_numbers(10,15)







# Class 2 -----------------------------------------------------------------
setwd("C:/Users/PC-TC302-10/Downloads")
data <- read.csv("imdb_top_1000.csv")

above_eleven <- function(x){
  ind <- (x>11)
  x[ind]
}
above_eleven(c(13,14,5,6,17))

above <-function(x, t = 10) {
  ind <- (x>t)
  x[ind]
}

above(c(13,14,5,6,17), 5)

column_mean <- function(x){
  nc <- ncol(x)
  means <- numeric(nc)
  for (i in 1:nc) {
    means[i] <- mean(x[,i], na.rm = T)
  }
  return(means)
}

?airquality
column_mean(airquality)

x <- rnorm(100)
y <- rnorm(100)
head(x, 10)
tail(y,5)
summary(x)
df_rndm <- data.frame(x = x, y = y)
head(df_rndm, 5)

?lm
args(lm)
model <- lm(formula = y ~ x, data = df_rndm)
summary(model)

lm(data = df_rndm, y ~ x)

lm <- function(x)
{x^2}
?lm 

stats::lm(data = df_rndm, y ~ x) ## when writing another function yourself that is already an R function one can specify the package corresponding to the function one wants to use
search()

rm(list=ls())

make_power <- function(n){
  pow <- function (x){
    x^n
  }
  return(pow)
}

cube <- make_power(3)
cube(4)
fourth_power <- make_power(4)
fourth_power(4)

install.packages("lubridate")
library(lubridate)
today()
now(tz = "UTC")
x <- ymd ("2021-01-29")
class(x)
mdy("January 20th, 2022")
dmy("20-January-2021")
ymd(20210121)
ymd_hms("2021-01-20 18:45:32")
now()
as_date(now())

#Loop functions *apply, split

x<- list(a =1:6, b = rnorm(5))
x 
lapply(x, mean)

x <- list(a = matrix(1:6, nrow=2), b=matrix(7:10, nrow=2))
x
lapply(x, function(mat){mat[,1]})

y <- 1:3
runif(10)
lapply(y, runif)
lapply(y, runif, min = -20, max =20)

lapply(airquality, mean, na.rm = T)

df <- data.frame(x = c(1,2,3), y = c(T,F,T), x = c(2,5,6))
df
lapply(df, class) == "numeric"


#str and summary
data <- read.csv("imdb_top_1000.csv")
dim(data)
View(data)
str(df)
summary(df)


install.packages("tidyverse")
library(tidyverse)
?glimpse

# Simulations
rnorm(10, mean = 0, sd = 1)
dnorm(1, mean = 0, sd =1)
pnorm(0, mean = 0, sd =1)
qnorm(0,975, mean = 0, sd =1)

runif(10)

# seeding

set.seed(1)
rnorm(10)
rnorm(10)
set.seed(1)
rnorm(10)

set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, sd =2)
y <- 0.5 + 3*x + e
summary(y)
plot(x,y)

sample(1:10, 4)
sample(1:10)
sample(1:10, 4, replace = T)

system.time(rnorm(1000000))
x <- rnorm(100)
y <- rnorm(100)
mean(x)
sd(x)
var(x)
cor(x,y)
cov(x,y)
cor(x,y) * sd(x) * sd(y)
hist(x)
hist(y, col="cyan", breaks = 20)

install.packages("palmerpenguins")
library(palmerpenguins)
?penguins
dim(penguins)
View(penguins)

library(ggplot2)

ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g)) + geom_point()
glimpse(penguins)
table(factor(penguins$species))
unique(penguins$species)
ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g)) + geom_point(aes(color = species))
ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g)) + geom_point(aes(shape = species, color = species ))
facet_wrap(~species)


?ToothGrowth
View(ToothGrowth)
library(dplyr)
df <- ToothGrowth
df2 <- filter(df, dose == 0.5)
df3 <- arrange(df2, len)
df3 <- arrange(df2, -len)
df3 <- arrange(df2, desc(len))

View(df3)

arrange(filter(df, dose == 0.5), len)

df %>% 
  filter(dose == 0.5)  %>% 
  arrange(len)


df %>% 
  filter(dose == 0.5) %>%
  group_by(supp) %>%
  summarize(mean_len = mean(len, na.rm = T))

?diamonds
library(ggplot2)
head(diamonds)
dim(diamonds)
diamonds2 <- mutate(diamonds, carat2 = carat * 100)
glimpse(diamonds2)

diamonds %>%
  mutate(carat2 = carat * 100) %>%
  select(carat2, cut, price)
  

data <- read.csv("imdb_top_1000.csv")

install.packages("readxl")
library(readxl)
readxl_example()
read_excel(readxl_example("type-me.xlsx"))
excel_sheets(readxl_example("type-me.xlsx"), 
             sheet = "numeric_coercion")

?read_csv

new_df <- diamonds %>%
  select(price, carat) %>%
  mutate(price_per_carat = price / carat)

head(new.df)
write.csv(new_df, "price_per_carat.csv", row.names = F)







.
# Class 3 -----------------------------------------------------------------
library(tidyverse)
library(palmerpenguins)
library(here)
library(skimr)
library(janitor)
library(dplyr)

View(penguins)
head(penguins)
skim_without_charts(penguins) # skim data grame, get useful summary stats
glimpse(penguins)
head(penguins)

penguins %>% 
  dplyr::select(-species)

penguins %>% 
  rename(island_new = island, bill_length = bill_length_mm)

penguins <- rename_with(penguins, toupper)
glimpse(penguins)

penguins <- clean_names(penguins) 
penguins <- rename_with(penguins, tolower)
penguins

penguins %>% arrange(-bill_length_mm)
glimpse(penguins)


penguins %>% group_by(island) %>% drop_na() %>% 
  summarize(mean_bill_length_mm = mean(bill_length_mm))

penguins %>% group_by(island) %>% 
  summarize(mean_bill_length_mm = mean(bill_length_mm, na.rm = T))

penguins %>% group_by(island) %>% 
  summarize(max_bill_length_mm = max(bill_length_mm, na.rm = T), 
            min_bill_length_mm = min(bill_length_mm, na.rm = T))

penguins %>% group_by(species, island) %>% drop_na() %>% 
  summarize(mean_bill_length_mm = mean(bill_length_mm),
            max_bill_length_mm = max(bill_length_mm))

penguins %>% filter(species == "Adelie", island == "Dream")

# separate, unite, mutate

View(penguins)

? unite
penguins2 <- penguins %>%
  unite(species_island, c("species", "island"), sep = "-")
glimpse(penguins2)
View(penguins2)

? mutate
penguins2 %>% mutate(body_mass_kg = body_mass_g / 1000) %>%
  group_by(species_island) %>%
  summarize(mean_body_mass = mean(body_mass_kg, na.rm = TRUE))
View(penguins2)

? separate
penguins_back <- penguins2 %>%
  separate(species_island, into = c('species', 'island'), sep = '-')
penguins_back

# Anscombe's quartet
install.packages("Tmisc")
library(Tmisc)
? Tmisc
data(quartet)
View(quartet)
glimpse(quartet)

quartet %>% 
  group_by(set) %>%
  summarize(mean(x), sd(x), mean(y), sd(y), cor(x, y))

ggplot(quartet, aes(x, y)) + 
  geom_point() +
  geom_smooth(method = stats::lm, se = F) +
  facet_wrap(~set)

install.packages('datasauRus')
library(datasauRus)
glimpse(datasaurus_dozen)

ggplot(datasaurus_dozen, aes(x, y, colour = dataset)) +
  geom_point() +
  facet_wrap(~dataset, ncol = 3) +
  theme_void() + 
  theme(legend.position = "none")

# plotting penguins
glimpse(penguins)

ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point(aes(color = species, size = species, alpha = species))

ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point(aes(color = species, size = species, alpha = species)) +
  geom_smooth()

ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point(aes(color = species)) +
  geom_smooth(method = lm, se = T)

ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point(aes(color = species)) +
  geom_smooth(aes(linetype = penguins$species), method = lm)

ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_jitter()

# to diamonds
ggplot(data = diamonds, aes(x = cut, fill = cut)) + 
  geom_bar()

ggplot(data = diamonds, aes(x = carat)) + 
  geom_histogram(color = "magenta", fill = "lightblue")

ggplot(data = diamonds, aes(x = carat, fill = cut)) + 
  geom_histogram(color = "magenta")

ggplot(data = diamonds, aes(x = carat, fill = cut)) + 
  geom_histogram(color = "magenta")

breaks_vector <- seq(0, 3, 0.2)
ggplot(data = diamonds, aes(x = carat, fill = cut)) + 
  geom_histogram(color = "magenta", breaks = breaks_vector) +
  theme_minimal() + 
  theme(legend.position = "none") +
  xlab("Carats") + 
  ylab("Number of diamonds") +
  labs(title = "Histogram",
       subtitle = "Carats",
       caption = "What do colors mean? Look at the legend!",
       fill = "Goodness of cut")

plot1 <- ggplot(data = diamonds, aes(x = carat, fill = cut)) + 
  geom_histogram(color = "magenta", breaks = breaks_vector) +
  theme_minimal()
print(plot1)


plot1 + xlab("Carats") + 
  ylab("Number of diamonds") +
  labs(title = "Histogram",
       subtitle = "Carats",
       caption = "What do colors mean? Look at the legend!",
       fill = "Goodness of cut")

ggplot(data = diamonds, aes(x = cut, y = carat, color = cut)) + 
  geom_boxplot()


# Facets --- display smaller groups, subsets of your data
# facet_wrap, facet_grid
ggplot(data = penguins) +
  geom_point(aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  facet_wrap(~species)

ggplot(data = diamonds, aes(x = carat, fill = cut)) + 
  geom_histogram(color = "magenta", breaks = breaks_vector) +
  facet_wrap(~cut)

ggplot(data = diamonds, aes(x = carat, fill = cut)) + 
  geom_histogram(color = "magenta", breaks = breaks_vector) +
  facet_wrap(~cut, ncol = 5)

# two variables?
ggplot(data = penguins) +
  geom_point(aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  facet_wrap(~sex~species)

ggplot(data = penguins) +
  geom_point(aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  facet_grid(sex ~ species)

ggplot(data = drop_na(penguins)) +
  geom_point(aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  facet_grid(sex ~ species)

# dplyr + ggplot2
penguins %>% 
  drop_na() %>%
  filter(species == "Adelie") %>% 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, color = island)) +
  geom_point(alpha = 0.5) +
  annotate("text", x = 205, y = 3200, label = "NO POINTS HERE!",
           fontface = "italic", size = 3, angle = 40)

# saving: export or ggsave

ggsave("figure1.png")

# CHEATSHEET https://github.com/rstudio/cheatsheets/blob/main/data-visualization.pdf
glimpse(diamonds)

model <- lm(log(price) ~ log(carat), data = diamonds)
summary(model)
vcov(model)
coef(model)

confint(model, level = 0.99)

residuals <- resid(model)
summary(residuals)

ggplot(data = diamonds, aes(x = log(carat), y = log(price))) + 
  geom_point()

df <- diamonds
df$residuals <- residuals

residual_plot <- ggplot(data = df, aes(x = log(carat), y = residuals^2)) +
  geom_point() 
print(residual_plot)

# too many points? you can use hexes
install.packages("hexbin")
library(hexbin)

residual_plot + 
  geom_hex()

### INTERACTIVE PLOTS
install.packages("plotly")
library(plotly)

install.packages("gapminder")
library(gapminder)

?gapminder
plot <- gapminder %>%
  rename(population = pop) %>%
  filter(year == 1977) %>%
  ggplot(aes(gdpPercap, lifeExp, color = continent)) +
  geom_point() +
  theme_minimal() + 
  xlab("GDP per capita") + 
  ylab("Life expectancy")
print(plot)

ggplotly(plot)

# Can also add sliders and so on...
# https://plotly.com/r/sliders/

# LINEAR REGRESSION

library(ISLR2)
?Boston
glimpse(Boston)
df <- Boston %>%
  rename(
    crime_rate = crim,
    zoning_prop = zn,
    non_retail_business_prop = indus,
    charles_river = chas,
    nitrogen_ox = nox,
    aver_num_of_rooms = rm,
    dist_to_empl_centres = dis,
    house_age = age,
    highway_access = rad,
    pupil_teacher_ratio = ptratio,
    low_socecon_status_prop = lstat,
    med_house_value = medv
  )

glimpse(df)
summary(df)

linear_reg_1 <- lm(data = df, 
                   med_house_value ~ low_socecon_status_prop)
summary(linear_reg_1)

coef(linear_reg_1)[2]
confint(linear_reg_1)
y_hat <- predict(linear_reg_1, df[, "low_socecon_status_prop", drop = F])

ggplot(data.frame(y_hat = y_hat, y_act = df$med_house_value),
       aes(x = y_act, y = y_hat)) + geom_point()

res <- residuals(linear_reg_1)
ggplot(data.frame(x = res), aes(x = x)) +
  geom_density()

linear_reg_2 <- lm(data = df,
                   med_house_value ~ low_socecon_status_prop + 
                     house_age)
summary(linear_reg_2)

linear_reg_3 <- lm(data = df,
                   med_house_value ~ .)
summary(linear_reg_3)

linear_reg_4 <- lm(data = df,
                   med_house_value ~ . - non_retail_business_prop)
summary(linear_reg_4)

# can use memisc to concatenate results together
library(stargazer)

stargazer(linear_reg_1, linear_reg_2, linear_reg_3,
          type = "text")


stargazer(linear_reg_1, linear_reg_2, linear_reg_3,
          title = "Four regressions for Boston data",
          type = "latex",
          out = "table1.tex")

View(cor(df))


# Class 4 -----------------------------------------------------------------
library(tidyverse)
library(ISLR2)

df <- Boston %>%
  rename(
    crime_rate = crim,
    zoning_prop = zn,
    non_retail_business_prop = indus,
    charles_river = chas,
    nitrogen_ox = nox,
    aver_num_of_rooms = rm,
    dist_to_empl_centres = dis,
    house_age = age,
    highway_access = rad,
    pupil_teacher_ratio = ptratio,
    low_socecon_status_prop = lstat,
    med_house_value = medv
  )

linear_reg_1 <- lm(data = df, 
                   med_house_value ~ low_socecon_status_prop)

linear_reg_2 <- lm(data = df,
                   med_house_value ~ low_socecon_status_prop + 
                     house_age)

linear_reg_3 <- lm(data = df,
                   med_house_value ~ .)

# stargazer output  --- reporting outputs
library(stargazer)

stargazer(linear_reg_1, linear_reg_2, linear_reg_3,
          type = "text")

stargazer(linear_reg_1, linear_reg_2, linear_reg_3,
          title = "Four regressions for Boston data",
          type = "latex",
          out = "table1.tex")

View(cor(df))
glimpse(df)
stargazer(cor(df), title = "Correlations",
          type = "latex", out = "cor_table.tex")

linear_reg <- lm(data = df, med_house_value ~  pupil_teacher_ratio + 
                   nitrogen_ox + dist_to_empl_centres + house_age)
summary(linear_reg)
coefs <- coef(linear_reg) # coefficient estimates
vcov(linear_reg)
sd_coefs <- linear_reg %>% vcov() %>% diag() %>% sqrt() # sd of coefficients
t_stats <- coefs / sd_coefs # t statistics
t_stats

n <- nrow(df)
p <- length(coefs) - 1
ggplot(data.frame(grid = seq(-5, 5, 0.5)), aes(x = grid)) + 
  geom_function(fun = dt, args = list(df = n - p - 1)) + 
  geom_vline(xintercept = t_stats["house_age"], color = "red") +
  geom_vline(xintercept = -t_stats["house_age"], color = "red")

pt(t_stats["house_age"], df = n - p - 1) * 2 # p-value

# factors
df <- data.frame(
  y = c(15, 12, 11, 8, 2.5, 6, 5),
  x = c("high", "high", "high", "medium", "low", "medium", "low")
)
glimpse(df)
df$x <- factor(df$x, c("low", "medium", "high"))
ggplot(df, aes(x = y, y = 0, color = x)) + geom_point() 

simple_lr <- lm(data = df, y ~ x)
summary(simple_lr)

# Testing for heteroscedasticity
?diamonds
model <- lm(data = diamonds,
            log(price) ~ log(carat))
summary(model)

install.packages("lmtest")
library(lmtest)
?bptest
# Breusch-Pagan heteroscedasticity test
# H_0: no heteroscedasticity
bptest(model)

df <- Boston %>%
  rename(
    crime_rate = crim,
    zoning_prop = zn,
    non_retail_business_prop = indus,
    charles_river = chas,
    nitrogen_ox = nox,
    aver_num_of_rooms = rm,
    dist_to_empl_centres = dis,
    house_age = age,
    highway_access = rad,
    pupil_teacher_ratio = ptratio,
    low_socecon_status_prop = lstat,
    med_house_value = medv
  )

glimpse(df)
# Boston dataframe, continued
df %>% select(-med_house_value) %>% cor() %>% View()

df2 <- data.frame(y = c(1, 3, 4, 9),
                  x1 = c(1, 2, 2, 3),
                  x2 = c(1, 2, 2, 3.0001))
model_with_multic <- lm(data = df2, y ~ .)
summary(model_with_multic)

linear_model <- lm(data = df, med_house_value ~ .)
summary(linear_model)

#  Ridge or Lasso regression to adress multicollinearity as they impose some regularization.
install.packages("glmnet")
library(glmnet)
?glmnet
y <- df$med_house_value
X <- df %>% select(-med_house_value) %>% data.matrix()

lasso_model <- glmnet(X, y, alpha = 1, lambda = 0.4)
coef(lasso_model)
coef(linear_model)

lasso_coef_dynamics <- function(lambda, coef_name) {
  build_model <- glmnet(X, y, alpha = 1, lambda = lambda)
  current_coef <- coef(build_model)[coef_name, 1]
  return(current_coef)
}
# vectorized version of the function above
lasso_coef_dynamics_vec <- function(lambdas, coef_name) {
  result <- lapply(lambdas, lasso_coef_dynamics, coef_name)
  result <- unlist(result) # list to vector when appropriate
  return(result)
}

plot_coef_dynamics <- function(coef_name) {
  plot <- ggplot(data.frame(lambda_grid = seq(0, 2, 0.05)), aes(x = lambda_grid)) + 
    geom_function(fun = lasso_coef_dynamics_vec, args = list(coef_name = coef_name), color = "red") +
    geom_hline(yintercept = 0, linetype = 'dotted') +
    ylab(paste("Coefficient for", coef_name))
  print(plot)
}

plot_coef_dynamics("crime_rate")
plot_coef_dynamics("nitrogen_ox")
plot_coef_dynamics("house_age")

y_hat <- predict(lasso_model, X) # predicted y

# ridge regression
ridge_model <- glmnet(X, y, alpha = 0, lambda = 0.4)
coef(ridge_model) %>% round(2)

# train-test
?Auto
dim(Auto)
glimpse(Auto)
View(Auto)

n <- nrow(Auto)
test_prop <- 0.2
set.seed(9)
train <- sample(n, (1 - test_prop) * n)

?predict

model_train <- lm(data = Auto, mpg ~ horsepower, subset = train)
summary(model_train)
pred_mpg <- predict(model_train, Auto[-train, "horsepower", drop = F])
act_mpg <- Auto[-train, "mpg"]
MSE <- mean((act_mpg - pred_mpg)^2)

model_train_2 <- lm(data = Auto, mpg ~ horsepower + I(horsepower^2), subset = train)
summary(model_train_2)
pred_mpg_2 <- predict(model_train_2, Auto[-train, "horsepower", drop = F])
act_mpg_2 <- Auto[-train, "mpg"]
MSE_2 <- mean((act_mpg_2 - pred_mpg_2)^2)



MSE_function <- function(pow, seed) {
  set.seed(seed)
  train <- sample(n, (1 - test_prop) * n)
  model_train <- lm(data = Auto, mpg ~ poly(horsepower, pow), subset = train)
  pred_mpg <- predict(model_train, Auto[-train, "horsepower", drop = F])
  act_mpg <- Auto[-train, "mpg"]
  MSE <- mean((act_mpg - pred_mpg)^2)
  return(MSE)
}

cat(
  MSE_function(1, seed = 20), 
  MSE_function(2, seed = 20), 
  MSE_function(3, seed = 20), 
  MSE_function(4, seed = 20), 
  MSE_function(5, seed = 20)
)


ggplot(data = Auto, aes(x = horsepower, y = mpg)) + geom_point()

# cross-validation (k-fold)
install.packages("boot")
library(boot)
?cv.glm
linear_reg <- glm(data = Auto, mpg ~ horsepower)
cv.glm(Auto, linear_reg, K = 10)$delta # second element "bias-corrected ver."

linear_reg_2 <- glm(data = Auto, mpg ~ poly(horsepower, 2))
cv.glm(Auto, linear_reg_2, K = 10)$delta

?cv.glmnet
# cv.glmnet- for lasso - optimal lambda and comparison of models

n <- nrow(df)
test_prop <- 0.2
set.seed(12)
train <- sample(n, (1 - test_prop) * n)

X <- df %>% select(-med_house_value) %>% data.matrix()
y_train <- df[train, "med_house_value"]
y_test <- df[-train, "med_house_value"]
X_train <- X[train, ]
X_test <- X[-train, ]

linear_model_train <- lm(data = df, med_house_value ~ ., subset = train)
y_hat <- predict(linear_model_train, data.frame(X_test))
linear_model_MSE <- mean((y_test - y_hat)^2)

lambda_grid <- seq(0.01, 5, 0.01)
lasso_model <- glmnet(X_train, y_train, alpha = 1, lambda = lambda_grid)
# model_train <- lm(data = Auto, mpg ~ horsepower, subset = train)
cv_lasso <- cv.glmnet(X_train, y_train, alpha = 1)
lambda_best <- cv_lasso$lambda.min
y_hat_lasso <- predict(lasso_model, s = lambda_best, X_test)
best_lasso_MSE <- mean((y_test - y_hat_lasso)^2)

cat(linear_model_MSE, best_lasso_MSE)

winner_model <- glmnet(X_train, y_train, alpha = 1, lambda = lambda_best)
coef(winner_model)

# logistic and probit regressions
df_default <- ISLR2::Default
glimpse(df_default)
summary(df_default)

ggplot(data = df_default, 
       aes(x = income, y = balance, color = default, shape = default)) + geom_point()

logit <- glm(data = df_default, 
             default ~ balance + income + student,
             family = binomial(link = "logit"))
summary(logit)

pred_logit_probs <- predict(logit, type = "response")
pred_logit_outcomes <- rep("No", nrow(df_default))
pred_logit_outcomes[pred_logit_probs > 0.5] <- "Yes"
pred_logit_outcomes <- as.factor(pred_logit_outcomes)

table(df_default$default, pred_logit_outcomes)

probit <- glm(data = df_default, 
              default ~ balance + income + student,
              family = binomial(link = "probit"))
summary(probit)

pred_probit_probs <- predict(probit, type = "response")
pred_probit_outcomes <- rep("No", nrow(df_default))
pred_probit_outcomes[pred_probit_probs > 0.5] <- "Yes"
pred_probit_outcomes <- as.factor(pred_probit_outcomes)

table(df_default$default, pred_probit_outcomes)

stargazer(logit, probit, type = "text")

install.packages("devtools")
library(devtools)
devtools::install_github("selva86/InformationValue")
library(InformationValue)

converted_outcome <- ifelse(df_default$default == "Yes", 1, 0)
optimal_cutoff <- optimalCutoff(converted_outcome, pred_logit_probs)
pred_logit_outcomes <- rep("No", nrow(df_default))
pred_logit_outcomes[pred_logit_probs > optimal_cutoff] <- "Yes"
pred_logit_outcomes <- as.factor(pred_logit_outcomes)

confusionMatrix(converted_outcome, pred_logit_probs)
misClassError(converted_outcome, pred_logit_probs, threshold = optimal_cutoff)
plotROC(converted_outcome, pred_logit_probs)

