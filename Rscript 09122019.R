#Rscript 09122019

#Read data

#R Script for class on the 02.12.2019
setwd("D:\\PhD\\Lectures\\PISA")
library(tidyverse)
#First let's read our data from the PISA
df <- readRDS(file="germany_pisa2015")

# Let's create some variables for our analysis of events
df <- df %>% mutate(top_math = ifelse(PV1MATH > quantile(PV1MATH, probs = 0.75), 1, 0))
df <- df %>% mutate(HISCED_n = ifelse(HISCED %in% c(0,1,2,3), 3, HISCED))

df %>% group_by(top_math) %>% summarise(mean(PV1MATH))

#Log-linked binomial models
loglinked.mod <- glm(top_math ~ factor(HISCED_n) + factor(IMMIG) + factor(PA042Q01TA), data=df, family = poisson(link = "log"))
exp(loglinked.mod$coefficients)

#Predicted probabilities: create "subsample", fit predicted probabilities for it
subsample <- with(df, data.frame(HISCED_n=factor(c(3,4,5,6), levels=c(3,4,5,6)), 
                             IMMIG=2,
                             PA042Q01TA=6))

predict(loglinked.mod, newdata = subsample, type="response", se.fit = T)

#Diagnostic accuracy

#BIC and AIC
loglinked.mod$aic
logLik(loglinked.mod)

#Prediction and confusion matrix
install.packages("ROCR")
library(ROCR)
predictions <- predict(loglinked.mod, type="response")
predictions_ <- ifelse(predictions>0.5, 1, 0)
pred.svm <- prediction(predictions_, df$top_math)
perf.svm <- performance(pred.svm, 'tpr', 'fpr')

#plots
install.packages("margins")
library(margins)
margins(loglinked.mod)
#Multinomial models

'ST093Q07NA	This issue will improve or get worse over next 20 years? The increase of greenhouse gases in the atmosphere	NUM	1.0	188	1 - 3		
						1	Improve
						2	Stay about the same
						3	Get worse
						7 / .N	Not Applicable
						8 / .I	Invalid
						9 / .M	No Response
						SYSTEM MISSING	Missing
'
table(df$ST093Q07NA)

install.packages("nnet")
library(nnet)

multinom.model <- multinom(formula = factor(ST093Q07NA) ~ PV1READ + factor(HISCED_n), data=df)
summary(multinom.model)
predict(multinom.model)
predict(multinom.model, type="prob")

#z-statistics
z <- summary(multinom.model)$coefficients/summary(multinom.model)$standard.errors
z

# 2-tailed z test
p <- (1 - pnorm(abs(z), 0, 1)) * 2
p

library(broom)
tidy(multinom.model)

#Let's compute some predictive probabilities
df[["HISCED_n"]] <- factor(df$HISCED_n)

margins(multinom.model)
dydx(head(df), multinom.model, "HISCED_n")
