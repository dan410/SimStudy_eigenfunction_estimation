
#' computes L2 norm of the difference between two functions
#' 
#' computes L2 norm of the difference between two functions: int_lower^upper (f - g)^2
#' 
#' @param f function
#' @param g function
#' @param lower lower bound for the support of f and g
#' @param upper upper bound for the support of f and g
#' @return scalar valued norm
norm_L2 <- function(f, g, lower=0, upper=1){
  stopifnot(is.function(f), is.function(g), lower < upper)
  diff2 <- function(x){(f(x) - g(x))^2}
  diff2_flip <- function(x){(-1*f(x) - g(x))^2}
  return(min(integrate(diff2, lower=lower, upper=upper)$value, 
             integrate(diff2_flip, lower=lower, upper=upper)$value))
}