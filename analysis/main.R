# load required packages and required functions
source("libraries/libs.R")


# paramsfile <- "params-ind-20.rds" 
# dat <- readRDS(paste("data/data-", paramsfile, sep=''))
# run_calc(dat = dat, paramsfile = paramsfile, method = "ssfcov2")
# run_calc(dat = dat, paramsfile = paramsfile, method = "fda")

## for "params-ind-50.rds" I used lambda = 10^-3.75
## for "params-ind-20.rds" I used lambda = 10^-3.75
## for "params-ind-10.rds" I used lambda = 10^
## for "params-ind-5.rds" I used lambda = 10^

### fit the missing gap data ###
paramsfile <- "params-ind-5.rds" 
dat <- readRDS(paste("data/gapdata-", paramsfile, sep=''))
run_calc(dat = dat, paramsfile = paramsfile, method = "ssfcov2")
run_calc(dat = dat, paramsfile = paramsfile, method = "fda")

paramsfile <- "params-ind-10.rds" 
dat <- readRDS(paste("data/gapdata-", paramsfile, sep=''))
run_calc(dat = dat, paramsfile = paramsfile, method = "ssfcov2")
run_calc(dat = dat, paramsfile = paramsfile, method = "fda")

paramsfile <- "params-ind-20.rds" 
dat <- readRDS(paste("data/gapdata-", paramsfile, sep=''))
run_calc(dat = dat, paramsfile = paramsfile, method = "ssfcov2")
run_calc(dat = dat, paramsfile = paramsfile, method = "fda")


# ### fit the beta data ####
# paramsfile <- "params-ind-5.rds" 
# dat <- readRDS(paste("data/betadata-", paramsfile, sep=''))
# run_calc(dat = dat, paramsfile = paramsfile, method = "ssfcov2")
# run_calc(dat = dat, paramsfile = paramsfile, method = "fda")
# 
# paramsfile <- "params-ind-20.rds" 
# dat <- readRDS(paste("data/betadata-", paramsfile, sep=''))
# run_calc(dat = dat, paramsfile = paramsfile, method = "ssfcov2")
# run_calc(dat = dat, paramsfile = paramsfile, method = "fda")
# 
# paramsfile <- "params-ind-10.rds" 
# dat <- readRDS(paste("data/betadata-", paramsfile, sep=''))
# run_calc(dat = dat, paramsfile = paramsfile, method = "ssfcov2")
# run_calc(dat = dat, paramsfile = paramsfile, method = "fda")

