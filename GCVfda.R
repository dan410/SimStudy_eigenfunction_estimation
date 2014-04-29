
#  A roughness penalty approach is more flexible, allowing continuous
#  control over smoothness and degrees of freedom, can be adapted to
#  known features in the curve, and will generally provide better RMSE
#  for given degrees of freedom.

#  It does require a bit more effort, though.
#  First, we define a little display function for showing how
#  df, gcv and RMSE depend on the log10 smoothing parameter
plotGCVRMSE.fd = function(lamlow, lamhi, lamdel, x, argvals, y,
                          fdParobj, wtvec=NULL, fdnames=NULL, covariates=NULL)  {
  loglamvec = seq(lamlow, lamhi, lamdel)
  loglamout = matrix(0,length(loglamvec),4)
  m = 0
  for (loglambda in loglamvec) {
    m = m + 1
    loglamout[m,1] = loglambda
    fdParobj$lambda = 10^(loglambda)
    smoothlist = smooth.basis(argvals, y, fdParobj, wtvec=wtvec,
                              fdnames=fdnames, covariates=covariates)
    xfd = smoothlist$fd   #  the curve smoothing the data
    loglamout[m,2] = smoothlist$df
    #  degrees of freedom in the smoothing curve
    #loglamout[m,3] = sqrt(mean((eval.fd(argvals, xfd) - x)^2))
    loglamout[m,4] = mean(smoothlist$gcv)  #  the mean of the N gcv values
  }
  cat("log10 lambda, deg. freedom, RMSE, gcv\n")
  for (i in 1:m) {
    cat(format(round(loglamout[i,],3)))
    cat("\n")
  }
  #par(mfrow=c(3,1))
  #plot(loglamvec, loglamout[,2], type="b")
  #title("Degrees of freedom")
  #plot(loglamvec, loglamout[,3], type="b")
  #title("RMSE")
  plot(loglamvec, loglamout[,4], type="b")
  title("Mean gcv")
  return(loglamout)
}

dat <- readRDS("data/data-params-ind-5.rds")
argvals <- with(dat[[1]], subset(dat[[1]]$Time, ID==3))
y <- with(dat[[1]], subset(dat[[1]]$X, ID==3))
n = length(x)
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
lambda = 10^(-2)
fdParobj = fdPar(fdobj=basisobj, Lfdobj=2, lambda=lambda)
#  Smooth the data, outputting a list containing various quantities
smoothlist = smooth.basis(argvals, y, fdParobj)
xfd = smoothlist$fd   #  the curve smoothing the data
df  = smoothlist$df   #  the degrees of freedom in the smoothing curve
gcv = smoothlist$gcv  #  the value of the gcv statistic
plotfit.fd(y, argvals, xfd)
points(argvals,y, pch="*")
#  Repeat these analyses for a range of log10(lambda) values by running
#  the function plotGCVRMSE that we defined above.

loglamout = plotGCVRMSE.fd(-5, -0.5, 0.25, x, argvals, y, fdParobj)
