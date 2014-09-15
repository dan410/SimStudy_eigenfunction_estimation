
paramsfile = "params-ind-67.rds"
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

####################################
### Create data with time gaps at random places ###
paramsfile = "params-ind-5.rds"
params <- readRDS(file = paste('analysis/params/', paramsfile, sep=""))
m <- params$m
length <- ceiling(m/.75 - m) # this will generate data with approx 25% missing values
### How many data sets do you want to use?
n.data.sets <- 100

### converting output frm sim_data to a list of data frames
SIMDAT <- sim_data_gap(n = n.data.sets, params=params, length = length)
gapdat <- NULL
for(i in 1:n.data.sets){
  gapdat[[i]] <- SIMDAT[[i]][[1]]
}

saveRDS(gapdat, file = paste("data/gapdata-", paramsfile, sep=""))

##################################################################
#### Using Beta distribution for the observation distribution ####
paramsfile = "params-ind-50.rds"
params <- readRDS(file = paste('analysis/params/', paramsfile, sep=""))

### How many data sets do you want to use?
n.data.sets <- 100

### converting output frm sim_data to a list of data frames
SIMDAT <- sim_data2(n = n.data.sets, params=params)
dat <- NULL
for(i in 1:n.data.sets){
  dat[[i]] <- SIMDAT[[i]][[1]]
}

saveRDS(dat, file = paste("data/betadata-", paramsfile, sep=""))
