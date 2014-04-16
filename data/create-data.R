
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
for( i in 1:50){
  gapdat[[i]] <- ddply(dat[[i]], .(ID), create_gap, start=16, length=5, beginning=TRUE)
}
for(i in 51:100){
  gapdat[[i]] <- ddply(dat[[i]], .(ID), create_gap, start=16, length=5, beginning=FALSE)
}

gp <- ggplot(gapdat[[51]], aes(x=Time, y=X, group=ID))
gp + geom_line()

saveRDS(gapdat, file = "data/gapdata-params-ind-20.rds")

### Create gaps at random places
dat <- readRDS("data/data-params-ind-20.rds")
gapdat <- NULL
for( i in 1:100){
  gapdat[[i]] <- ddply(dat[[i]], .(ID), create_gap, start="random", length=5)
}


gp <- ggplot(gapdat[[1]], aes(x=Time, y=X, group=ID))
gp + geom_line()

saveRDS(gapdat, file = "data/gapdata2-params-ind-20.rds")
