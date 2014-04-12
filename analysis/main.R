# load required packages and required functions
source("libraries/libs.R")


paramsfile <- "params-ind-50.rds" 
dat <- readRDS(paste("data/data-", paramsfile, sep=''))
run_calc(dat = dat, paramsfile = paramsfile, method = "ssfcov2")
run_calc(dat = dat, paramsfile = paramsfile, method = "fda")

## for "params-ind-50.rds" I used lambda = 10^-2
## for "params-ind-10.rds" I used lambda = 
## for "params-ind-5.rds" I used lambda = 10^