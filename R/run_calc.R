
#### Estimate the principal component functions for each data set and sore them in a list
run_calc <- function(dat, paramsfile, method, n.marginal.knots=5, marginal.knots=NULL){
  n.data.sets <- length(dat)

  if(method == "ssfcov2"){
    ### using smoothing spline method ###
    #n.marginal.knots <- 5
    #marginal.knots=NULL
    
    FPC <- list() #initialize empty list
    for(i in 1:n.data.sets){
      FPC[[i]] <- fpca_ss(dat[[i]], n.marginal.knots=n.marginal.knots, marginal.knots=marginal.knots)
    }
    
    saveRDS(FPC, file = paste("analysis/results/fpca-ss-", paramsfile, sep=""))    
  }
  if(method == "fda"){
    ################### FDA Package using pca.fd() ############
    
    ### Here we use B-spline basis with breaks that depend on the number of knots used in the smoothing spline estimator
    rangeval <- c(0,1)
    #breaks <- min(rangeval) + (max(rangeval) - min(rangeval)) * (1:n.marginal.knots)/(n.marginal.knots + 1)
    #breaks <- c(rangeval[1], breaks, rangeval[2]) # first and last break point must be min/max range value
    
    ### 
    FPC <- list()
    for(i in 1:n.data.sets){
      FPC[[i]] <- fpca_fda(dat[[i]], rangeval = rangeval, norder = 4, nbasis=5)
    }
    
    saveRDS(FPC, file = paste("analysis/results/fpca-fda-", paramsfile, sep=""))  
  }
  
  return(0)
}