# This study seeks to understand the estimation of eigenfunctions using ...

# load required packages 
library(sfdasim)
library(ggplot2)
source('run-sims-pcafd.R')

# set the working directory
setwd(dir = "/Users/dan410/Google Drive/Research/Projects/Simulation_Studies/SimStudy_eigenfunction_estimation")
# set the parameters
paramsfile = "params-dep-1.rds"
params <- readRDS(file = paste('params/', paramsfile, sep=""))

m = params$m
levels.m = params$levels.m
type = params$type 
basis.pars = params$basis.pars 
sigma0 = params$sigma0 
rand.obs = params$rand.obs 
n.dim = params$n.dim 
n.marginal.knots = params$n.marginal.knots 
cov.model = params$cov.model 
cov.pars = params$cov.pars 
locs = params$locs


obsPerCurve <- m  # creating a more descriptive name

iter = 1
while (iter <= n.iter){
# first simulate curves at the given locations using specified covariance structure on the coefficients
curves <- sim_sfda_curves(nBasis=n.dim, type=type, basis.pars = basis.pars, cov.model=cov.model, cov.pars=cov.pars, locs = locs)

# simulate data sets corresponding to the user specified number of observations per curve and error variance
SIMDAT <- list()
for (i in 1:2){	
	dat.noErrorVar <- sim_sfda_data(locs=curves$locs, coef=curves$coef, basis.fns=curves$basis.fns, sigma0=0.000001, m = obsPerCurve[i]) 
	for (j in 1:length(sigma0)){	                                       
		dat <- dat.noErrorVar
		dat$X <- dat.noErrorVar$X + rnorm(n=nrow(dat), sd = sigma0[j])
		dat$m <- obsPerCurve[i] 
		dat$sigma0 <- sigma0[j] 
		SIMDAT[[length(sigma0)*(i-1) + j]] <- dat	
	}                  
}
### reformat data so that it is suitable for creating funcitonal data object
dat <- SIMDAT[[2]]
mybasis <- create.fourier.basis(rangeval = c(0,1), nbasis = 7)
argvals <- matrix(dat$Time, nrow = obsPerCurve[2], byrow=FALSE)
y <- matrix(dat$X, nrow = obsPerCurve[2], byrow = FALSE)


### compute smoothed estimates of the curves using regression smoothing
datfd <- smooth.basis(argvals = argvals, y = y, fdParobj = mybasis)$fd
plot(datfd)

### compute eigenfunctions using fda package funcitons
dat.pca <- pca.fd(datfd, nharm = 2, centerfns = FALSE) # not centering functions
plot.pca.fd(dat.pca)

### compute rotated versions of the PC using the varmax rotation
dat.rotpca <- varmx.pca.fd(dat.pca)
plot.pca.fd(dat.rotpca)

### brute force plotting of fpc
    pcafd <- dat.pca
    harmfd <- pcafd[[1]]
    basisfd <- harmfd$basis
    rangex <- basisfd$rangeval
    x <- seq(0,1, length = 100)
    fdmat <- eval.fd(x, harmfd)
plot(x, fdmat[,2], type = "l")

### smoothing using roughness penelty



iter <- iter + 1  # increase iteration value and continue the loop
}



n.iter = 2
ef1 <- numeric(n.iter)
ef2 <- numeric(n.iter)
for( i in 1:n.iter){
    ef1[i] <- L2norm1(results[[i]][[2]]$eig.est)
    ef2[i] <- L2norm2(results[[i]][[2]]$eig.est)
}

mean(ef1)
sd(ef1)
mean(ef2)
sd(ef2)
        




