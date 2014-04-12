######### DEFINE IN INPUTS ###########
#' m        # number of observations per curve
#' type 	    # type of basis functions to use
#' basis.pars	# this is the alpha value, which controls the smoothness of the process
#' sigma0 		# standard deviation of the error process
#' rand.obs		# if TRUE randomize observation locations for each curve (I have not implements the fixed point version of this)
#' n.dim  		# Integer value specifying the number of basis functions to use, effectively specifying the dimension of the functional space
#' cov.model    # type of cavariance function to use for each of the random effects corresponding to principal component functions
#' cov.pars     # parameters for each of the covariance functions specified in cov.model
#' locs			# 2xn matrix with curve locations

m <- c(10) 	
type <- "Cos" 	    
basis.pars <- 2	# this is the alpha value controlling smoothness of the process
sigma0 <- c(0.368) 	
rand.obs <- TRUE 	
n.dim <- 10 	

# specify the covariance model for each basis function. Must specify a covariance type for each basis function and the corresponding covariance parameters in cov.pars
cov.model <- rep("exponential",n.dim)
cov.pars=rbind(c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0))
# specify locations to simulate curves. Must be a 2xn matrix 
locs <- expand.grid(1:10/10, 1:10/10)

paramList <- list(m=m, type=type, basis.pars=basis.pars, sigma0=sigma0,
                  rand.obs=rand.obs, n.dim=n.dim,
                  cov.model=cov.model, cov.pars = cov.pars, locs=locs)

saveRDS(paramList, 'analysis/params/params-ind-10.rds')


