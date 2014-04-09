
paramsfile = "params-ind-20.rds"
params <- readRDS(file = paste('analysis/params/', paramsfile, sep=""))

### How many data sets do you want to use?
# n.data.sets <- 25

SIMDAT <- sim_data(n=100, params=params)



saveRDS(SIMDAT, file = paste("data", paramsfile, sep=""))
