##### R script for lecture on the 28.10.2019
# In this lecture we cover some basic functionality in R and try to get familiar with how R studio works.
# It consists of # of points that were covered in the first chapters of R for Data Science plus some useful tips.

# Understanding the different parts of R Studio

# R console is a calculator; we can create objects!
# +; -; *; /; ^; 

#And we can simulate variables from specific distributions such as:

rnorm(100, mean=0, sd=1)
rbinom(100, size=4, p=0.1)

# vectors, scalars, matrices
1:10
n <- 100
m <- 100
matrix(rnorm(n*m,mean=0,sd=1), n, m) 
n_by_m <- matrix(rnorm(n*m,mean=0,sd=1), n, m) 
myvector <- c("A","B","C","D","E")

# types of data
df <- as.data.frame(n_by_m)

# Or transform our variables
log(x) #Natural log. 
sum(x) #Sum.
exp(x) #Exponential. 
mean(x) #Mean.
max(x) #Largest element. 
median(x) #Median.
min(x) #Smallest element. 
quantile(x) #Percentage quantiles.
round(x, n) #Round to n decimal places.
rank(x) #Rank of elements.
signif(x, n) #Round to n significant figures.
table(x) #make a table
var(x) #The variance.
cor(x, y) #Correlation. 
sd(x) #The standard deviation.
cut(x) #categorize a continuous variable

sample(myvector, 100, replace = T, prob = c(0.1,0.2,0.3,0.4,0.9))

# Create a working directory (note: 1 / in mac and ubuntu, 2 \\ in windows!)

filepath <- "D:\\PhD\\Lectures"
setwd(filepath)

# Types of objects

class()

# Entering data into R

# So let's install some packages we will be needing to enter our data into R
library(tidyverse)

# There are different ways depending on the format in which the data has been stored.
# Excel
library(readxl)
cda_stats <- read_excel("cda_stats_hu.xlsx") 
# Stata
# library(readstata13)
# SPSS
library(haven)
students_pisa <- read_sav(file = "D:\\PhD\\Lectures\\PISA\\CY6_MS_CMB_STU_QQQ.sav")
# CSV
# read_csv()
# RDS
# readRDS()
# Data on the web

# Deleting objects that are no longer necessary

rm() # will delete a list of objects separated by commas
# rm(list = ls()) #cntrl + shift + c will comment or uncomment parts of code

# Let's look at the data
View(cda_stats)

apply(cda_stats, 2, function(x) table(x))

# Now PISA
germany_pisa <- filter(students_pisa, CNTRYID == 276)

# and let's switch to Rmarkdown
install.packages("rmarkdown")
install.packages("knitr")