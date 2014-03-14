# This study seeks to understand the estimation of eigenfunctions using the nonparametric covariance and eigenfunction estimator proposed by Cai and Yuan 2010. Particularly, interest is in the effect of the number of observations per curve, as well as the level of noise in the measurement error process.

run_sims <- function(n.data.sets, paramsfile){
# NOTE: set the current working directory to this project using setwd(dir = "")

### Specify the parameter file to use. These files are in the params folder.
# paramsfile = "params-dep-1.rds"
params <- readRDS(file = paste('analysis/params/', paramsfile, sep=""))

### How many data sets do you want to use?
#n.data.sets <- 25

 ### Generate the data sets using the specified parameter values
 SIMDAT1 <- sim_data(n=n.data.sets, params=params, gap=TRUE, start=1, length=5)
 SIMDAT2 <- sim_data(n=n.data.sets, params=params, gap=TRUE, start=1, length=5, beginning = FALSE)
 SIMDAT <- c(SIMDAT1, SIMDAT2)
 #### Estimate the principal component functions for each data set and sore them in a list
 ### using smoothing spline method ###
 n.marginal.knots <- 5
 marginal.knots=NULL
# eps <- 0.001
# marginal.knots <- seq(0+eps,1-eps, length=7)

FPC <- list() #initialize empty list
for(i in 1:n.data.sets){
  FPC[[i]] <- fpca2_ss(SIMDAT[[i]], n.marginal.knots=n.marginal.knots, marginal.knots=marginal.knots)
}

saveRDS(FPC, file = paste("analysis/results/fpca-ss-", paramsfile, sep=""))

 
################### FDA Package using pca.fd() ############

### Here we use B-spline basis with breaks that depend on the number of knots used in the smoothing spline estimator
rangeval <- c(0,1)
#breaks <- min(rangeval) + (max(rangeval) - min(rangeval)) * (1:n.marginal.knots)/(n.marginal.knots + 1)
#breaks <- c(rangeval[1], breaks, rangeval[2]) # first and last break point must be min/max range value

### 
FPC <- list()
for(i in 1:n.data.sets){
 FPC[[i]] <- fpca2_fda(sets=SIMDAT[[i]], rangeval = rangeval, norder = 4, nbasis=5)
}

saveRDS(FPC, file = paste("analysis/results/fpca-fda-", paramsfile, sep=""))

return(0)
}





