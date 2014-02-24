######### DEFINE INPUTS ###########
#' m 		 	# number of observations per curve
#' levels.m     # factor levels for m including "truth"
#' type 	    # type of basis functions to use
#' basis.pars	# this is the alpha value, which controls the smoothness of the process
#' sigma0 		# standard deviation of the error process
#' rand.obs		# if TRUE randomize observation locations for each curve (I have not implements the fixed point version of this)
#' n.dim  		# Integer value specifying the number of basis functions to use, effectively specifying the dimension of the functional space
#' n.marginal.knots  number of knots to use in estimation of the covariance function (see estimate_cov_function() for details)
#' cov.model    # type of cavariance function to use for each of the random effects corresponding to principal component functions
#' cov.pars     # parameters for each of the covariance functions specified in cov.model
#' locs			# 2xn matrix with curve locations

m <- c(10,50) 	
levels.m <- c("truth", "10", "50") # TODO: remove this if no longer needed for simulation step
type <- "Cos" 	    
basis.pars <- 2		
sigma0 <- c( 0.368) 	
rand.obs <- TRUE 	
n.dim <- 10
n.marginal.knots <- 5
# specify the covariance model for each basis function. Must specify a covariance type for each basis function and the corresponding covariance parameters in cov.pars
cov.model <- rep("pure.nugget",n.dim)
cov.pars=rbind(c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0))
# specify locations to simulate curves. Must be a 2xn matrix 
locs <- expand.grid(1:5/5, 1:5/5)

paramList <- list(m=m, levels.m=levels.m, type=type, basis.pars=basis.pars, sigma0=sigma0,
                      rand.obs=rand.obs, n.dim=n.dim, n.marginal.knots=n.marginal.knots,
                cov.model=cov.model, cov.pars = cov.pars, locs=locs)

saveRDS(paramList, 'params/params-ind-1.rds')


