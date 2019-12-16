#Rscript Class 16.12.2019

# IIA test
# From package example

install.packages("mlogit")
library(mlogit)
## from Greene's Econometric Analysis p. 731

data("TravelMode",package="AER")
TravelMode <- mlogit.data(TravelMode,choice="choice",shape="long",
                          alt.var="mode",chid.var="individual")

## Create a variable of income only for the air mode

TravelMode$avinc <- with(TravelMode,(mode=='air')*income)

## Estimate the model on all alternatives, with car as the base level
## like in Greene's book.

#x <- mlogit(choice~wait+gcost+avinc,TravelMode,reflevel="car")
x <- mlogit(choice~wait+gcost+avinc,TravelMode)

## Estimate the same model for ground modes only (the variable avinc
## must be dropped because it is 0 for every observation

g <- mlogit(choice~wait+gcost,TravelMode,reflevel="car",
            alt.subset=c("car","bus","train"))

## Compute the test

hmftest(x,g)
# }


# Multinomial Probit Model
install.packages("MNP")
library(MNP)

data("japan")
res <- mnp(cbind(LDP, NFP, SKG, JCP) ~ gender + education + age, 
           data = japan,
           n.draws = 10000, verbose = TRUE)
summary(res)

res1 <- mnp(cbind(LDP, NFP, SKG, JCP) ~ gender + education + age, 
            data = japan,n.draws = 50000, verbose = TRUE)

res2 <- mnp(cbind(LDP, NFP, SKG, JCP) ~ gender + education + age, 
            data = japan,coef.start = c(1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1),
            cov.start = matrix(0.5, ncol=3, nrow=3) + diag(0.5, 3),
            n.draws = 50000, verbose = TRUE)

res3 <- mnp(cbind(LDP, NFP, SKG, JCP) ~ gender + education + age, 
            data = japan,coef.start = c(-1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1),
            cov.start = matrix(0.9, ncol=3, nrow=3) + diag(0.1, 3),
            n.draws = 50000, verbose = TRUE)

#install.packages("coda")
#library(coda)
res.coda <- mcmc.list(chain1=mcmc(res1$param[,-7]),
                      chain2=mcmc(res2$param[,-7]),
                      chain3=mcmc(res3$param[,-7]))

japan10a <- japan[10,]

predict(res, newdata = japan10a,
        newdraw = rbind(res$param[25001:50000,],
                        res$param[25001:50000,],
                        res$param[25001:50000,]), 
        type = "prob")


#Ordinal models
df <- df %>% mutate(HISCED_n = ifelse(HISCED %in% c(0,1,2,3), 3, HISCED))

# Books in household
table(df$ST013Q01TA)

## Load packages
library(erer)
library(margins)
library(MASS)
library(ggeffects)


## Load library to run polr
library(MASS)
library(tidyverse)
df <- df %>% dplyr::select(c(ST013Q01TA,PV1READ,HISCED_n,ST004D01T,IMMIG))
df <- na.omit(df)
## Present model
mod.ordlog <- polr(factor(ST013Q01TA) ~ PV1READ + factor(HISCED_n) + factor(ST004D01T) + factor(IMMIG), 
                 data=df, Hess=T)
summary(mod.ordlog)

# 4-6 Odds Ratios and percent change

## Save odds ratios, CI, stx
beta_hat<- coef(mod.ordlog)
ci <- exp(cbind(confint.default(mod.ordlog)))

## Calculate precentage changes
perc.beta_hat <- (exp(beta_hat)-1)*100

## OR and CI
exp(cbind(OR = coef(mod.ordlog), ci))

# 7. Compute Discrete Change for C and B
#Store variables in vectors
HISCED_n <- df$HISCED_n
ST004D01T <- df$ST004D01T
IMMIG <- df$IMMIG

#install.packages("erer")
library(erer)
# Here we are computing marginal effects at the mean 
marginal_effect_ord <- ocME(w = mod.ordlog, rev.dum = T)
marginal_effect_ord$out
