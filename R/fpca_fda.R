fpca_fda <- function(dat, nbasis=7){

### reformat data so that it is suitable for creating funcitonal data object
mybasis <- create.fourier.basis(rangeval = c(0,1), nbasis = nbasis)
argvals <- matrix(dat$Time, nrow = dat$m[1], byrow=FALSE)
y <- matrix(dat$X, nrow = dat$m[1], byrow = FALSE)

### compute smoothed estimates of the curves using regression smoothing
datfd <- smooth.basis(argvals = argvals, y = y, fdParobj = mybasis)$fd
#plot(datfd)

### compute eigenfunctions using fda package funcitons
dat.pca <- pca.fd(datfd, nharm = 2, centerfns = FALSE) # not centering functions
# plot.pca.fd(dat.pca)

fpc1 <- extract_pcf(dat.pca, nharm=1)
fpc2 <- extract_pcf(dat.pca, nharm=2)

return(fpca = list(fpc1=fpc1, fpc2=fpc2))
}



