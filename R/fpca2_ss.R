#' calculate first two principal component functions for a collection of data sets
#' 
#' The function is a wrapper function for \code{fpca_ss()}, and uses the \code{plyr} package to handle splitting the data sets and combining the results
#' @param sets list of data sets as output from \code{sim_data()}
#' @param n.marginal.knots number of knot locations to use on the marginal domain. The number of knot locations actually used in estimation will be n^2 on the product domain. Default is 5.
#' @return list with each element a list containing the first two estimate FPCs
fpca2_ss <- function(sets, n.marginal.knots=NULL, marginal.knots=NULL){
  df <- ldply(sets, function(x){x}) #converting list to data frame
  FPC <- dlply(df, .variables=c("m","sigma0"), .fun = fpca_ss, n.marginal.knots=n.marginal.knots, marginal.knots=marginal.knots)
  return(FPC)
}