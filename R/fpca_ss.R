#' Estimates principal component functions by computing eigenfunctions of the covariance function
#' 
#' Estimates principal component functions by computing eigenfunctions of the covariance function
#' 
#' @param dat functional data set
#' @param n.marginal.knots number of knot locations to use on the marginal domain. The number of knot locations actually used in estimation will be n^2 on the product domain.
#' @return list containing first two principal component functions
fpca_ss <- function(dat, n.marginal.knots = 5){
  ##### estimating eigenfunctions ####
  df <- ldply(dat, function(x){x})
    
  EIG <- dlply(df, .variables=c("m","sigma0"), function(x){
    cov.est <- estimate_cov_function(x, n.marginal.knots = n.marginal.knots)
    eig.est <- estimate_eigenfunctions
    vals <- eig.est$values
    return(list(eig.est = eig.est))
  })
  return(EIG)
}