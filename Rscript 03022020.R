#Rscript 04.01.2020
setwd("D:\\PhD\\Lectures\\PISA")
library(tidyverse)

df <- readRDS(file="germany_pisa2015")

df <- df %>% mutate(gender=ST004D01T,
                    edu_mom=ST005Q01TA,
                    edu_father=ST007Q01TA,
                    computer=ST011Q04TA,
                    books=ST013Q01TA,
                    breakfast=ST076Q01NA,
                    income=PA042Q01TA)

df <- dplyr::select(df, c(gender,edu_mom,edu_father,computer,books,breakfast,income,JOYSCIE,SCIEEFF,IMMIG,hisei,OUTHOURS,PV1MATH,PV1READ))

#Multiple imputation: passive imputation
df <- df %>% mutate(disadvantage = income + 2*breakfast + computer,
                    score_combined = PV1MATH^2 + sqrt(PV1READ))

library(mice)
impt_0 <- mice(data=df, maxit=0)

impt_0$method["JOYSCIE"] <- "normal"
impt_0$predictorMatrix
impt_0$method["disadvantage"] <- "~ I(income + 2*breakfast + computer)"
impt_0$predictorMatrix[c("income", "breakfast", "computer"), "disadvantage"] <- 0

impt_0$method["score_combined"] <- "~ I(PV1MATH^2 + sqrt(PV1READ))"

imp3 <- mice(df, m = 3, seed = 27012020, method = "cart")

plot(imp3)

# ggplot2

df <- na.omit(df)

# We have different types of variables: categorical and continuous
apply(df, 2, function(x) summary(x))

df <- df %>% mutate(top_math = ifelse(PV1MATH > quantile(PV1MATH, probs = 0.75), 1, 0))

#install.packages("ggplot2")
library(ggplot2)
#install.packages("gridExtra")
library(gridExtra)

# plot the lot
theme_set(theme_bw()) # replace default 'mouldy waffle' background


# Basic Bar plot
ggplot(df, aes(x=as.factor(top_math), fill=as.factor(top_math))) + 
  geom_bar(show.legend = T) +
  xlab("Top Math Performer") +
  ylab("Count of top math performers") +
  theme(legend.position = c(0.9,0.9), legend.justification = c(1,1)) +
  scale_fill_grey(name = "Math Performer", labels = c("No", "Yes"))

df$income <- factor(df$income, labels= c("Less than < $A", 
                                          "$A or more but less than $B",
                                          "$B or more but less than $C",
                                          "$C or more but less than $D",
                                          "$D or more but less than $E",
                                          "$E or more"))

ggplot(df, aes(x=as.factor(gender), fill=as.factor(top_math))) +
  geom_bar(position="fill") +
  scale_fill_brewer(palette = "RdBu", labels=c("No","Yes"), name="Top Math") +
  scale_x_discrete(labels = c("Girls", "Boys")) +
  facet_grid(. ~ income, labeller = label_value)

# Logit model
logit.mod <- glm(formula = top_math ~ factor(income) + PV1READ*factor(gender), data = df, family = binomial(link="logit"))
exp(logit.mod$coefficients)
exp(confint(logit.mod))

coefs.glm <- data.frame(var = names(exp(logit.mod$coefficients)),
                   oddsratio = exp(logit.mod$coefficients),
                   LowerLimit = exp(confint(logit.mod))[,1],
                   UpperLimit = exp(confint(logit.mod))[,2])

# Marginal effects (like in stata)
#install.packages("mfx")
library(mfx)
logitmfx(formula = logit.mod, data = df, atmean = TRUE)

logitor(formula = logit.mod, data = df)

ndata <- expand.grid(PV1READ = quantile(df$PV1READ), 
                     income = c("1","2","3","4","5","6"),
                     gender = c("1","2"))

# get predicted probabilities
preds <- predict(logit.mod, newdata = ndata, se.fit = TRUE)

# construct intervals by transforming predictions and 2*SEs
# and bundle with ndata for ease of plotting together
invlogit <- function(x){ 1 / (1 + exp(-x)) }
plottable <- with(preds, 
                  data.frame(ndata, 
                             fit = invlogit(fit),
                             lwr = invlogit(fit + 2*se.fit),
                             upr = invlogit(fit - 2*se.fit)) )

ggplot(plottable, aes(x = PV1READ, y = fit, col = income, fill = income)) + 
  geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.4, colour = NA) +
  geom_line(size = 1, alpha = 0.4) +
  scale_color_brewer(palette="Set1") +  # replace default colors and fill
  scale_fill_brewer(palette="Set1") +
  labs(x = "Score on Reading", y = "Probability of being top math performer", title = "Basic Plot")

ggplot(plottable, aes(x = PV1READ, y = fit, col = gender, fill = gender)) + 
  geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.4, colour = NA) +
  geom_line(size = 1, alpha = 0.4) +
  scale_color_brewer(palette="Greys") +  # replace default colors and fill
  scale_fill_brewer(palette="Greys") +
  labs(x = "Score on Reading", y = "Probability of being top math performer", title = "Basic Plot") +
  facet_wrap( ~ income)


#Forest plot
ggplot(data=coefs.glm, aes(x=var, y=oddsratio, ymin=LowerLimit, ymax=UpperLimit)) +
  geom_pointrange() + 
  geom_hline(yintercept=1, lty=2) +  # add a dotted line at x=1 after flip
  xlab("Variables") + ylab("OR") +
  scale_y_discrete(labels=c())
  theme_bw() +
  coord_flip()# use a white background

# Interaction Effects
install.packages("margins")
library(margins)
margins(logit.mod)


library(RColorBrewer)
head(brewer.pal.info, 10)
display.brewer.pal(n=6, name="YlGnBu")

# Rmarkdown


