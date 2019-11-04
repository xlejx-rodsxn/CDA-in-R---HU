# Create a working directory (note: 1 / in mac and ubuntu, 2 \\ in windows!)
# spell the path exactly. In my laptop, for example, I store all the material for class in "D:\PhD\Lectures\Introduction to Categorical Data Analysis"
# but R will not understand that, so I need to correct it

getwd() # GET the current Working Directory
filepath <- "D:\\PhD\\Lectures" # in quotation " " marks declare what the new Working Directory will be
setwd(filepath) # SET the Working Directory for this session

#Libraries
library(tidyverse)

# Excel
library(readxl)
cda_stats <- read_excel("cda_stats_hu.xlsx") 
names(cda_stats) <- c("x1","x2","x3","x4","x5","x6","x7","x8","x9","x10","x11","x12","x13","x14","x15","x16","x17")

# Remember that we are dealing with categorical data (e.g. binary, nominal, ordinal or counts) These types have
# specific classes in R

# Types of objects
class(cda_stats)
str(cda_stats)

# None of them is a factor, so let's make one. 
levels(cda_stats$x9)

# Here is the pipe operator %>% (cntrl + shift + m in windows)

cda_stats <- cda_stats %>% mutate(x9_cat = as.factor(x9))
class(cda_stats$x9)
class(cda_stats$x9_cat)

levels(cda_stats$x9_cat)

# the pipe operator allows to do all kinds of summaries for our data
# it follows the same structure
# DATA %>% operation %>% operation %>% ....

# Let's write some informative summaries by groups of interest

# median rents by part of berlin

# number of people by dog vs. cat lover who reported to be extremely happy about answering our survey

# Good point to introduce the logical operators: <, >, <=, >=, |, &, ==

# Let's recode some data, again using %>% 
# One of the questions was: "What is the derivative of f(x) = 2x*y + x^2  + x*y, with respect to x?"
# And the answer is....... 2x + y, but our variable recorded the following

cda_stats$x12

cda_stats <- cda_stats %>% mutate(mom_uni = if_else(x12 == "Yes", 1, 0))
cda_stats$mom_uni

# what is the percentage of people whose mother went to university who had a grade of 1 in their previous studies

# Now PISA

# SPSS
library(haven)
students_pisa2015 <- read_sav(file = "D:\\PhD\\Lectures\\PISA\\CY6_MS_CMB_STU_QQQ.sav")

# For only Germany
germany_pisa2015 <- filter(students_pisa, CNTRYID == 276)

#write_sav(germany_pisa2015, path="D:\\PhD\\Lectures\\PISA\\germany_pisa2015.sav", compress=F)

germany_pisa2015 <- read_sav(file = "D:\\PhD\\Lectures\\PISA\\germany_pisa2015.sav")

# filter

# select

# arrange(, desc())

# bind_cols

# bind_rows

# left_join

