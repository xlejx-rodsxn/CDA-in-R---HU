#Install Packages
install.packages("oglmx")
install.packages("poLCA")

setwd("D:\\PhD\\Lectures\\PISA")
library(tidyverse)

df <- readRDS(file="germany_pisa2015")

#Generalized threshold models
library(oglmx)

#Ordinal models
df <- df %>% mutate(HISCED_n = ifelse(HISCED %in% c(0,1,2,3), 3, HISCED))

# Books in household
table(df$ST013Q01TA)

## Load packages
library(margins)
library(MASS)

df <- df %>% dplyr::select(c(ST013Q01TA,PV1READ,HISCED_n,ST004D01T,IMMIG))
df <- na.omit(df)
mod.ordlog <- polr(factor(ST013Q01TA) ~ PV1READ + factor(HISCED_n) + factor(ST004D01T) + factor(IMMIG), 
                   data=df, Hess=T)
summary(mod.ordlog)


results.oprob <- oglmx(factor(ST013Q01TA) ~ PV1READ + factor(HISCED_n) + factor(ST004D01T) + factor(IMMIG), data=df, link="probit",
                       constantMEAN = FALSE, constantSD = FALSE,delta=0,threshparam = NULL)
summary(results.oprob)
margins.oglmx(results.oprob,ascontinuous = TRUE)

#Latent class analysis
library(poLCA)

df_lca <- dplyr::select(df, c(ST011Q02TA,ST011Q03TA,ST011Q04TA,ST011Q05TA,ST011Q06TA,ST011Q07TA,
                       ST011Q08TA,ST011Q09TA,ST011Q10TA,ST011Q11TA,ST011Q12TA,ST011Q16NA,ST011D17TA,
                       ST011D18TA,ST011D19TA,ST012Q01TA,ST012Q02TA,ST012Q03TA,ST012Q05NA,ST012Q06NA,
                       ST012Q07NA,ST012Q08NA,ST012Q09NA,ST013Q01TA))
df_lca <- data.frame(apply(df_lca, 2, function(x) as.factor(x)))

attach(df_lca)
f <- cbind(ST011Q02TA,ST011Q03TA,ST011Q04TA,ST011Q05TA,ST011Q06TA,ST011Q07TA,
             ST011Q08TA,ST011Q09TA,ST011Q10TA,ST011Q11TA,ST011Q12TA,ST011Q16NA,ST011D17TA,
             ST011D18TA,ST011D19TA,ST012Q01TA,ST012Q02TA,ST012Q03TA,ST012Q05NA,ST012Q06NA,
             ST012Q07NA,ST012Q08NA,ST012Q09NA,ST013Q01TA) ~ 1

mod.lca <- poLCA(formula=f, data=df_lca, nclass = 3, maxiter = 1000, graphs = FALSE, tol = 1e-10, na.rm = FALSE, probs.start = NULL, nrep = 1, verbose = TRUE, calc.se = TRUE)
plot(mod.lca)
mod.lca$predcell$expected

#reorder obtained categories
probs.start <- mod.lca$probs.start
new.probs.start <- poLCA.reorder(probs.start, c(1, 3, 2))
mod.lca <- poLCA(formula=f, data=df_lca, nclass = 3, maxiter = 1000, graphs = FALSE, tol = 1e-10, na.rm = FALSE, probs.start = new.probs.start, nrep = 1, verbose = TRUE, calc.se = TRUE)


#avoid local maxima: nrep command

#little program to find best model
max_II <- -100000
min_bic <- 100000
lca_all <- list()
for(i in 2:4){
  lc <- poLCA(formula=f, data=df_lca, nclass = i, maxiter = 1000, graphs = FALSE, tol = 1e-10, na.rm = FALSE, probs.start = NULL, nrep = 1, verbose = TRUE, calc.se = TRUE)
  if(lc$bic < min_bic){
    min_bic <- lc$bic
    LCA_best_model<-lc
  }
  lca_all[[i]] <- lc
}    	

LCA_best_model
