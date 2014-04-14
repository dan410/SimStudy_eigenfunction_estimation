
paramsfile = "params-ind-20.rds"
params <- readRDS(file = paste('analysis/params/', paramsfile, sep=""))

### How many data sets do you want to use?
 n.data.sets <- 100

### converting output frm sim_data to a list of data frames
SIMDAT <- sim_data(n = n.data.sets, params=params)
dat <- NULL
for(i in 1:n.data.sets){
  dat[[i]] <- SIMDAT[[i]][[1]]
}

saveRDS(dat, file = paste("data/data-", paramsfile, sep=""))

### Use this code to create gaps in the data in order to investigate the effect of chunks of missing data
dat <- readRDS("data/data-params-ind-20.rds")
gapdat <- NULL
for( i in 1:length(dat)){
  gapdat[[i]] <- ddply(dat[[i]], .(ID), create_gap, start=15, length=5)
}

