# Rscript for 11.11.2019
# Simulation of Bernoulli and binomial distributions!
set.seed(1989)
bins <- rbinom(n = 1000, size = 1, prob = 0.5)
bins
mean(bins)
var(bins)

bins <- rbinom(n = 1000, size = 5, prob = 0.6)
bins
mean(bins)
var(bins)

y = bins
table(y)
hist(y, probability = TRUE, breaks = c(-0.5:5.5), main = "Binomial of size five witn n=1000 and a probability of sucess of p=0.6")



# Now let'S read our data and do some computation
filepath <- "D:\\PhD\\Lectures" # in quotation " " marks declare what the new Working Directory will be
setwd(filepath) # SET the Working Directory for this session
library(haven)
students_pisa2015 <- read_sav(file = "D:\\PhD\\Lectures\\PISA\\germany_pisa2015.sav")
students_pisa2015 <- students_pisa2015 %>% select(c("CNTSTUID",
                                                    "ST001D01T", "ST004D01T", 
                                                    "ST005Q01TA", "ST007Q01TA", "ST019BQ01T", "ST019CQ01T",
                                                    "ST005Q01TA","ST006Q01TA","ST006Q02TA",   
                                                    "ST006Q03TA","ST006Q04TA","ST007Q01TA","ST008Q01TA",   
                                                    "ST008Q02TA","ST008Q03TA","ST008Q04TA","ST011Q01TA",  
                                                    "ST011Q02TA","ST011Q03TA","ST011Q04TA","ST011Q05TA",   
                                                    "ST011Q06TA","ST011Q07TA","ST011Q08TA","ST011Q09TA",   
                                                    "ST011Q10TA","ST011Q11TA","ST011Q12TA","ST011Q16NA",   
                                                    "ST011D17TA","ST011D18TA","ST011D19TA",
                                                    "ST127Q01TA"))
