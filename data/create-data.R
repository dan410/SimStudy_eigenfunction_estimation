
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

### Create gaps at random places ###
dat <- readRDS("data/data-params-ind-67.rds")
gapdat <- NULL
for( i in 1:100){
  gapdat[[i]] <- ddply(dat[[i]], .(ID), create_gap, start="random", length=17)
}


gp <- ggplot(gapdat[[1]], aes(x=Time, y=X, group=ID))
gp <- gp + geom_line()
gp

saveRDS(gapdat, file = "data/gapdata-params-ind-67.rds")

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
