##### R script for lecture on the 28.10.2019
# In this lecture we cover some basic functionality in R and try to get familiar with how R studio works.

# The symbol # is important for the comments, so we can write stuff for humans to understand. R will not understand this
# cntrl + shift + c will comment or uncomment parts of code

# Understanding the different parts of R Studio: for example the editor, is where this Rscript opens up. 

# We can open up many editors where we will type our code

# R console is a calculator; we can create objects!
# +; -; *; /; ^; 

5 + 5

2^100

2/10000

#And we can simulate variables from specific distributions such as:

rnorm(n = 100, mean=0, sd=1) # for the standardized normal
rbinom(n = 100, size=4, p=0.1) # or the binomial distribution

# Basic functions to create objects vectors, scalars, matrices
# <- is the assignment operator, and it can be replaced with the symbol = (is a matter of taste, but profis use =, i still like to use <-)
sqc <- 1:10
N <- 100
M <- 100
matrix(rnorm(n = N*M,mean=0,sd=1), n, m) 
n_by_m <- matrix(rnorm(n*m,mean=0,sd=1), n, m) 

# Beware that R reads the code written in editor or console and needs to be EXACTLY what to do
# and to refer to objects always use the exact same NaMe

name <- c("Angela Merkel")

Name
# vs
name

# types of data
df <- as.data.frame(n_by_m) # data frame

# Some interesting operations on our objects
x <- rnorm(n = 100, mean=0, sd=1) # for the standardized normal
y <- rbinom(n = 100, size=4, p=0.1) # or the binomial distribution

log(x) #Natural log. 
sum(x) #Sum.
exp(x) #Exponential. 
mean(x) #Mean.
max(x) #Largest element. 
median(x) #Median.
min(x) #Smallest element. 
quantile(x) #Percentage quantiles.
round(x, digits = 2) #Round to n decimal places.
rank(x) #Rank of elements.
table(y) #make a table
var(x) #The variance.
cor(x, y) #Correlation. 
sd(x) #The standard deviation.
cut(x, breaks=3, labels = c("low","mid","high")) #categorize a continuous variable

# We can create samples
myvector <- c("A","B","C","D","E")
sample(myvector, size=100, replace = T, prob = c(0.1,0.2,0.3,0.4,0.9))

# how can we find out if in this sample there are more Es than say As?

smp <- table(sample(myvector, size=100, replace = T, prob = c(0.1,0.2,0.3,0.4,0.9)))
prop.table(smp)

# Deleting objects that are no longer necessary

rm(name) # will delete a list of objects separated by commas
# rm(list = ls()) will delete everything in the R Environment, be careful!

# Let's look at the data
View(smp)

# Getting some help in R
help(table)

# Reading external data into R (we cover only excel now, which is the most common)
getwd() # GET the current Working Directory
filepath <- "D:\\PhD\\Lectures" # in quotation " " marks declare what the new Working Directory will be
setwd(filepath) # SET the Working Directory for this session

# Excel
library(readxl)
cda_stats <- read_excel("cda_stats_hu.xlsx") 

# we can view the data by clicking on it in the environment or
View(cda_stats)

# We can see how our columns are named
colnames(cda_stats)

names(cda_stats) <- c("x1","x2","x3","x4","x5","x6","x7","x8","x9","x10","x11","x12","x13","x14","x15","x16","x17")

# An interesting function is the attach (but i dont use it as often because is confusing when you work with many data)
attach(cda_stats)

mean(x7)
sum(x7)
table(x3)

detach(cda_stats)

# A better option is to use the $ operator
cda_stats$x9

prop.table(table(cda_stats$x9))
