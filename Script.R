###### Course: Scientific working with R

# Class 1 -----------------------------------------------------------------
getwd()
dir()
# setwd("C:\Users\koend\OneDrive\Bureaublad\WU 2023-2024\Scientific working with R and LaTex")
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




