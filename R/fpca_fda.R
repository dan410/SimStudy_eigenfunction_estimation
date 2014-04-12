#' Estimates principal component functions 
#' 
#' Estimates principal component functions
#' 
#' @param dat data frame containing a functional data set in the format of the output of \code{sim_data()}
#' @param ... arguments passed to the \code{create.bspline.basis()} function
#' @return list containing first two principal component functions
fpca_fda <- function(dat, ...){

### reformat data so that it is suitable for creating funcitonal data object
 argvals <- matrix(dat$Time, nrow = dat$m[1], byrow=FALSE)
 y <- matrix(dat$X, nrow = dat$m[1], byrow = FALSE)

  ### CHANGE THIS!!!!! #####
  #argvals <- matrix(dat$Time, nrow = 15, byrow=FALSE)
  #y <- matrix(dat$X, nrow = 15, byrow = FALSE)
  ### END CHANGE ###
### compute smoothed estimates of the curves using regression smoothing
#mybasis <- create.fourier.basis(rangeval = c(0,1), nbasis = nbasis)
#create.bspline.basis(rangeval=rangeval, norder=norder, breaks=breaks)

### using smoothing penelty on the seconde derivative
n = NROW(argvals)
#  We now set up a basis system with a knot at every data point.
#  The number of basis functions will equal the number of interior knots
#  plus the order
nbasis = n + 2
basisobj = create.bspline.basis(c(0,1), nbasis)
#  Note that there are more basis functions than observed values.  A
#  basis like this is called "super-saturated."  We have to use a
#  positive smoothing parameter for it to work.  Set up an object of
#  class "fdPar" that penalizes the total squared second derivative,
#  using a smoothing parameter that is set here to 10^(-4.5).
lambda = 10^(-2) # found by minimizing GCV
fdParobj = fdPar(fdobj=basisobj, Lfdobj=2, lambda=lambda)
#  Smooth the data, outputting a list containing various quantities
datfd = smooth.basis(argvals, y, fdParobj)$fd

#mybasis <- create.bspline.basis(...)
#datfd <- smooth.basis(argvals = argvals, y = y, fdParobj = mybasis)$fd

### compute eigenfunctions using fda package funcitons
dat.pca <- pca.fd(datfd, nharm = 2, centerfns = FALSE) # not centering functions

fpc1 <- extract_pcf(dat.pca, method = "fda", nharm=1)
fpc2 <- extract_pcf(dat.pca, method = "fda", nharm=2)

return(fpca = list(fpc1=fpc1, fpc2=fpc2))
}



