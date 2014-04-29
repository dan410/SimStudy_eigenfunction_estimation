
#' Generates a list of simulated functional data sets
#' 
#' Generates a collection of indepedednt data sets generated under the scenario specified by the given parameters, and returns them as a list. 
#' 
#' @param n number of data sets to generate
#' @param params parameter values specifying the data generating process
#' @return list of functional data sets

sim_data2 <- function(n, params, DIST = runif, ...){
  
  obsPerCurve <- params$m  # creating a more descriptive name for number of observations per curve
  
  ALLDAT <- list() # initializing as list
  iter = 1
  while (iter <= n){
    # first simulate curves at the given locations using specified covariance structure on the coefficients
    curves <- sim_sfda_curves(nBasis=params$n.dim, type=params$type, basis.pars = params$basis.pars, cov.model=params$cov.model, cov.pars=params$cov.pars, locs = params$locs)
    
    # simulate data sets corresponding to the user specified number of observations per curve and error variance
    SIMDAT <- list() # initializing as a list object
    for (i in 1:length(obsPerCurve)){  
      dat.noErrorVar <- sim_sfda_data_beta(locs=curves$locs, coef=curves$coef, basis.fns=curves$basis.fns, sigma0=0.000001, m = obsPerCurve[i]) 
      for (j in 1:length(params$sigma0)){                                         
        dat <- dat.noErrorVar
        dat$X <- dat.noErrorVar$X + rnorm(n=nrow(dat), sd = params$sigma0[j])
        dat$m <- obsPerCurve[i] 
        dat$sigma0 <- params$sigma0[j] 
        SIMDAT[[length(params$sigma0)*(i-1) + j]] <- dat	
      }                  
    }
    ALLDAT[[iter]] <- SIMDAT
    iter <- iter + 1  # increase iteration value and continue the loop
  } # end while
  return(ALLDAT)
}