# Rscript for 27.01.2020
setwd("D:\\PhD\\Lectures\\PISA")
library(tidyverse)

#First let's read our data from the PISA
df <- readRDS(file="germany_pisa2015")

df <- df %>% mutate(gender=ST004D01T,
                    edu_mom=ST005Q01TA,
                    edu_father=ST007Q01TA,
                    computer=ST011Q04TA,
                    books=ST013Q01TA,
                    breakfast=ST076Q01NA,
                    income=PA042Q01TA)

df <- select(df, c(gender,edu_mom,edu_father,computer,books,breakfast,income,JOYSCIE,SCIEEFF,IMMIG,hisei,OUTHOURS,PV1MATH,PV1READ))

sapply(df, function(x) summary(x))

#Multiple imputation!!!

#Visualizing missing data patterns
install.packages("VIM")
library(VIM)
aggr(df)
matrixplot(df)

#Multiple Imputation
install.packages("mice")
library(mice)


md.pattern(df)
p <- md.pairs(df)
p

impt_0 <- mice(data=df, maxit=0)

imp <- mice(data=df, m=1, method = "cart")


imp5 <- mice(df, m = 5, seed = 27012020, method = "cart")

fit <- with(imp5, lm(PV1READ ~ factor(gender) + factor(edu_mom) + factor(income) + factor(IMMIG) + JOYSCIE))
round(summary(pool(fit)), 2)


summary(lm(PV1READ ~ factor(gender) + factor(edu_mom) + factor(income) + factor(IMMIG) + JOYSCIE,
   data=na.omit(df)))

#Other packages for MI
install.packages("Amelia")
install.packages("Hmisc")