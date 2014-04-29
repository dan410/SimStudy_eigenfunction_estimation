#' generates data from a family of curves
#' 
#' generates a functional data set by evaluating curves and adding Gaussian noise.
#' 
#' @param locs N by 2 matrix of spatial locations
#' @param coef matrix or data frame containing the coefficients of the basis functions. The number of columns is equal to the number of basis functions
#' @param basis.fns basis functions given by the output of create_basis
#' @param sigma0 standard deviation of the noise term.
#' @param m number of observations per curve
#' @param pts vector of values where the curves will be evaluated
#' @return ID integer identifying a single curve
#' @return locs spatial location of each curve
#' @return Time argument values where curves are evaluated
#' @return X response variable
sim_sfda_data_beta <- function(locs, coef, basis.fns, sigma0, m=NULL, pts = NULL){
  
  ncurve <- NROW(coef)
  nBasis <- NCOL(coef)
  
  ID <- rep(1:ncurve, each=m)
  Locs <- apply(locs, 2, rep, each=m)
  Time <- numeric(length(ID))
  X <- numeric(length(ID))
  
  ### I've hard-coded assuming 100 curves in each data set
  if(ncurve != 100) stop('number of curves is not equal to 100')
  for(i in 1:25){
    Time[ID==i] <- runif(m)
    ys <- NULL
    for( j in 1:nBasis){
      ys <- cbind(ys, basis.fns[[j]](Time[ID==i]))
    }
    ys <- ys%*%as.vector(coef[i,])
    X[ID==i] <- ys + rnorm(n=length(ys), sd=sigma0)
  }
  for(i in 26:50){
    Time[ID==i] <- rbeta(m, shape1=1, shape2=5)
    ys <- NULL
    for( j in 1:nBasis){
      ys <- cbind(ys, basis.fns[[j]](Time[ID==i]))
    }
    ys <- ys%*%as.vector(coef[i,])
    X[ID==i] <- ys + rnorm(n=length(ys), sd=sigma0)
  }
  for(i in 51:75){
    Time[ID==i] <- rbeta(m, shape1=5, shape2=1)
    ys <- NULL
    for( j in 1:nBasis){
      ys <- cbind(ys, basis.fns[[j]](Time[ID==i]))
    }
    ys <- ys%*%as.vector(coef[i,])
    X[ID==i] <- ys + rnorm(n=length(ys), sd=sigma0)
  }
  for(i in 75:100){
    Time[ID==i] <- rbeta(m, shape1=0.5, shape2=0.5)
    ys <- NULL
    for( j in 1:nBasis){
      ys <- cbind(ys, basis.fns[[j]](Time[ID==i]))
    }
    ys <- ys%*%as.vector(coef[i,])
    X[ID==i] <- ys + rnorm(n=length(ys), sd=sigma0)
  }
  
  dat <- data.frame( ID=ID,locs = Locs, Time=Time, X=X)
  return(dat)
}
