##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##' @title
##' @n.iter integer number of simulations
##' @param m number of observations per curve
##' @param levels.m factor levels for m including 'truth'
##' @param type type of basis functions to use
##' @param basis.pars this is the alpha value, which controls the smoothness of the process
##' @param sigma0 standard deviation of the error process
##' @param rand.obs  if TRUE randomize observation locations for each curve (I have not implements the fixed point version of this)
##' @param n.dim  if TRUE randomize observation locations for each curve (I have not implements the fixed point version of this)
##' @param n.marginal.knots  if TRUE randomize observation locations for each curve (I have not implements the fixed point version of this)
##' @param cov.model  if TRUE randomize observation locations for each curve (I have not implements the fixed point version of this)
##' @param cov.pars  if TRUE randomize observation locations for each curve (I have not implements the fixed point version of this)
##' @param locs  if TRUE randomize observation locations for each curve (I have not implements the fixed point version of this)
##' @return list with the results of the simulations (\todo{add more detail})
##' @author Daniel Fortin
run_sims <- function(n.iter, m, levels.m, type, basis.pars, sigma0, rand.obs, n.dim, n.marginal.knots, cov.model, cov.pars, locs){

RESULTS <- list()  # this will be a list of lists to store the simulation results for each iteration

obsPerCurve <- m  # creating a more descriptive name

iter = 1
while (iter <= n.iter){
# first simulate curves at the given locations using specified covariance structure on the coefficients
curves <- sim_sfda_curves(nBasis=n.dim, type=type, basis.pars = basis.pars, cov.model=cov.model, cov.pars=cov.pars, locs = locs)

# simulate data sets corresponding to the user specified number of observations per curve and error variance
SIMDAT <- list()
for (i in 1:length(obsPerCurve)){	
	dat.noErrorVar <- sim_sfda_data(locs=curves$locs, coef=curves$coef, basis.fns=curves$basis.fns, sigma0=0.000001, m = obsPerCurve[i]) 
	for (j in 1:length(sigma0)){	                                       
		dat <- dat.noErrorVar
		dat$X <- dat.noErrorVar$X + rnorm(n=nrow(dat), sd = sigma0[j])
		dat$m <- obsPerCurve[i] 
		dat$sigma0 <- sigma0[j] 
		SIMDAT[[length(sigma0)*(i-1) + j]] <- dat	
	}                  
}


##### estimating eigenfunctions ####
##### WARNING: this is time consuming
df <- ldply(SIMDAT, function(x){x})


RESULTS[[iter]] <- dlply(df, .variables=c("m","sigma0"), function(x){
  cov.est <- estimate_cov_function(x, n.marginal.knots = n.marginal.knots)
  eig.est <- estimate_eigenfunctions(cov.est)
  return(list(eig.est = eig.est))
})

iter <- iter + 1  # increase iteration value and continue the loop
}

return(list(results = RESULTS))

}








