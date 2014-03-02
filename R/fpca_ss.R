#' Estimates principal component functions by computing eigenfunctions of the covariance function
#' 
#' Estimates principal component functions by computing eigenfunctions of the covariance function
#' 
#' @param dat functional data set that can be passed to \code{ssfcov2::estimate_cov_function()}. See documentation for details.
#' @param n.marginal.knots number of knot locations to use on the marginal domain. The number of knot locations actually used in estimation will be n^2 on the product domain.
#' @return list containing first two principal component functions
fpca_ss <- function(dat, n.marginal.knots){ 
  cov.est <- estimate_cov_function(dat, n.marginal.knots = n.marginal.knots)
  eig.est <- estimate_eigenfunctions(cov.est)
  fpc1 <- extract_pcf(nharm = 1, method = 'ss', eig.est)
  fpc2 <- extract_pcf(nharm = 2, method = 'ss', eig.est)
  return(list(fpc1 = fpc1, fpc2 = fpc2))
}