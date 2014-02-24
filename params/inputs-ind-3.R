######### DEFINE IN INPUTS ###########
#' m 		 	# number of observations per curve
#' levels.m     # factor levels for m including "truth"
#' type 	    # type of basis functions to use
#' basis.pars	# this is the alpha value, which controls the smoothness of the process
#' sigma0 		# standard deviation of the error process
#' rand.obs		# if TRUE randomize observation locations for each curve (I have not implements the fixed point version of this)
#' n.dim  		# Integer value specifying the number of basis functions to use, effectively specifying the dimension of the functional space
#' cov.model    # type of cavariance function to use for each of the random effects corresponding to principal component functions
#' cov.pars     # parameters for each of the covariance functions specified in cov.model
#' locs			# 2xn matrix with curve locations

m <- c(5,10, 50) 	
levels.m <- c("truth", "50", "10", "5")
type <- "Cos" 	    
basis.pars <- 1		
sigma0 <- c(0.0001, 0.37, .74) 	
rand.obs <- TRUE 	
n.dim <- 10 		


# specify the covariance model for each basis function. Must specify a covariance type for each basis function and the corresponding covariance parameters in cov.pars
cov.model <- rep("pure.nugget",n.dim)
cov.pars=rbind(c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0), c(1,0.0))
# specify locations to simulate curves. Must be a 2xn matrix 
locs <- expand.grid(1:5/5, 1:10/10)

file <- "inputs-ind-3.rds"
save.results <- TRUE

source("run-simulations.R")
