#' extract principal principal component function from a fitted object
#' 
#' extract principal principal component funciton from a fitted object.
#' The \code{method} variable specifies how the functions are calculated
#' from the fitted object. Currently only two methods are implemented. 
#' The method "ss" corresponds to the output object from the 
#' \code{estimate_eigenfunctions()} function from the ssfcov2 package.
#' The method "pcafd" corresponds to the output from the \code{pca.fc()} function
#' in the fda package.
#' 
#' @param nharm integer corresponding to the principal component function. nharm = 1 corresponds to the leadng principal component function.
#' @param method string specifying method to use. Current options are "ss" and "pcafd".
#' @param fit.obj fitted object from which PCFs can be derived
#' @return the principal component function corresponding to nharm
extract_pcf <- function(nharm, method = NULL, fit.obj = NULL){
  if(is.null(method)) stop("method is not specified")
  
  if(method == "pcafd"){ # pca.fd() function in fda package
    pcf <- function(x){eval.fd(x,  fit.obj[[1]])[, nharm]}
  }
  if(method == "ss"){ # estimate_eigenfunctions() function in ssfcov2 package
    pcf <- fit.obj$fns[[order(fit.obj$values, decreasing=TRUE)[nharm] ]]
  }
  return(pcf)
}