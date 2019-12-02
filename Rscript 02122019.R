#R Script for class on the 02.12.2019
setwd("D:\\PhD\\Lectures\\PISA")

#First let's read our data from the PISA
df <- readRDS(file="germany_pisa2015")

# Let's create some variables for our analysis of events

# We want to model the event of high grades in math and high grades in german

# Linear model
lm()
glm(, family = gaussian(link = "identity"))
summary()
confint()
predict(, type="response")
# Probit model
glm(, family = binomial(link="probit"))

# Logit model
glm(, family = binomial(link="logit"))

# Marginal effects (like in stata)
#install.packages("mfx")
library(mfx)

probitmfx()

logitmfx()

logitor()

# Evaluating predictions
#install.packages("epiR")
library(epiR)
