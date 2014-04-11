# load required packages and required functions
source("libraries/libs.R")

#char2seed("Fortin")

paramsfile <- "params-ind-20.rds"
dat <- readRDS(paste("data/data-", paramsfile, sep=''))
run_calc(dat = dat, paramsfile = paramsfile, method = "fda")