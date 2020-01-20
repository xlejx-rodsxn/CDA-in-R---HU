#Rscript 20.01.2020
#R Script for class on the 02.12.2019
setwd("D:\\PhD\\Lectures\\PISA")
library(tidyverse)

#First let's read our data from the PISA
df <- readRDS(file="germany_pisa2015")
df <- na.omit(df) %>% mutate(good_math = as.factor(ifelse(PV1MATH >= quantile(PV1MATH)[4], 1, 0)))
read <- df$PV1READ
df <- data.frame(lapply(df, function(x) droplevels(as.factor(as.character(x)))))
df$read <- read
df <- select(df, -c(PV1MATH, PV1READ, PROGN, GRADE, ST003D03T))

# Divide data into training and testing
## 75% of the sample size
smp_size <- floor(0.75 * nrow(df))

## set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(df)), size = smp_size)

train <- df[train_ind, ]
test <- df[-train_ind, ]

library(mboost)

model <- glmboost(good_math ~ ., data = train, 
                  family=Binomial(), center = F)

### 10-fold cross-validation
cv10f <- cv(model.weights(model), type = "kfold")
cvm <- cvrisk(model, folds = cv10f, papply = lapply)
mstop(cvm)
print(cvm)

# Evaluate predictions
bestmod <- model[mstop(cvm)]
summary(bestmod)
plot(varimp(bestmod))

predict(bestmod, newdata=train, type = "response")


md <- glm(good_math ~ ., family = binomial, data = train)
summary(md)
predict(md, newdata=test, type = "response")

# Other criteria
### 25 bootstrap iterations (manually)
set.seed(270488)
n <- nrow(df)
bs25 <- rmultinom(25, n, rep(1, n)/n)
cvm <- cvrisk(model, folds = bs25, papply = lapply)
mstop(cvm)

### same by default
cvrisk(model, papply = lapply)

### 25 bootstrap iterations (using cv)
bs25_2 <- cv(model.weights(model), type="bootstrap")
all(bs25 == bs25_2)

#install.packages("survey")
library(survey)
data(api)

"15 school districts were sampled and then all schools in each district. 
The two-stage sample is defined by the sampling unit (dnum) and the population size(fpc)."

dclus1 <- svydesign(id = ~dnum, weights = ~pw, data = apiclus1, fpc = ~fpc)

summary(dclus1)

svymean(~api00, dclus1)

svyquantile(~api00, dclus1, quantile=c(0.25,0.5,0.75), ci=TRUE)

svyratio(~api.stu, ~enroll, design=subset(dclus1, stype=="H"))

vars <- names(apiclus1)[c(12:13,16:23,27:37)]

svymean(make.formula(vars), dclus1, na.rm=TRUE)

svyby(~ell+meals, ~stype, design=dclus1, svymean)

regmodel <- svyglm(api00~ell+meals,design=dclus1)
logitmodel <- svyglm(I(sch.wide=="Yes")~ell+meals, design=dclus1, family=quasibinomial())
summary(regmodel)
summary(logitmodel)


install.packages("srvyr")
library(srvyr)

