# This study seeks to understand the estimation of eigenfunctions using the nonparametric covariance and eigenfunction estimator proposed by Cai and Yuan 2010. Particularly, interest is in the effect of the number of observations per curve, as well as the level of noise in the measurement error process.

# NOTE: set the current working directory to this project using setwd(dir = "")

# load required packages and required functions
source("libraries/libs.R")

# Specify the parameter file to use. These files are in the params folder.
paramsfile = "params-ind-1.rds"
params <- readRDS(file = paste('analysis/params/', paramsfile, sep=""))

# Set the seed for the Random Number Generator for reproducible results
# char2seed('fortin')

# How many data sets do you want to use?
n.data.sets <- 3

# Generate the data sets using the specified parameter values
SIMDAT <- sim_data(n=n.data.sets, params=params)

# Estimate the principal component functions for each data set and sore them in a list
### using smoothing spline method ###
EIG.EST <- list() #initialize empty list
for(i in 1:n.data.sets){
  EIG.EST[[i]] <- fpca_ss(dat=SIMDAT[[i]], n.marginal.knots=5)
}

saveRDS(EIG.EST, file = paste("analysis/results/fpca-ss-", "paramsfile"))
 
################### FDA Package using pca.fd() ############
EIG.EST <- list()
for(i in 1:n.data.sets){
  EIG.EST[[i]] <- fpca_fda(dat=SIMDAT[[i]][[2]], nbasis=7)
}
saveRDS(EIG.EST, file = paste("analysis/results/fpca-pcafd-", "paramsfile"))







