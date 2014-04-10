#' calculate first two principal component functions for a collection of data sets
#' 
#' The function is a wrapper function for \code{fpca_fda()}, and uses the \code{plyr} package to handle splitting the data sets and combining the results
#' @param sets list of data sets as output from \code{sim_data()}
#' @param ... addition arguments passed to the \code{fda::create.bspline.basis() function}
#' @return list with each element a list containing the first two estimate FPCs
fpca2_fda <- function(sets, ...){
  #df <- ldply(sets, function(x){x}) #converting list to data frame
  
  FPC <- dlply(sets, .variables=c("m","sigma0"), .fun = fpca_fda, ...)
  return(FPC)
}