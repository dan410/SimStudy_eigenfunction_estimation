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

### compute smoothed estimates of the curves using regression smoothing
#mybasis <- create.fourier.basis(rangeval = c(0,1), nbasis = nbasis)
create.bspline.basis(rangeval=rangeval, norder=norder, breaks=breaks)
datfd <- smooth.basis(argvals = argvals, y = y, fdParobj = mybasis)$fd

### compute eigenfunctions using fda package funcitons
dat.pca <- pca.fd(datfd, nharm = 2, centerfns = FALSE) # not centering functions

fpc1 <- extract_pcf(dat.pca, nharm=1)
fpc2 <- extract_pcf(dat.pca, nharm=2)

return(fpca = list(fpc1=fpc1, fpc2=fpc2))
}



