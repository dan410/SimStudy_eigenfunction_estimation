#' extranct principal componetn funciton for pcafd fitted object in the fda package
#' 
#' #' extranct principal componetn funciton for pcafd fitted object in the fda package
#' 
#' @return the principal component function corresponding to nharm
extract_pcf <- function(pcafd, nharm){
    function(x){eval.fd(x,  pcafd[[1]])[, nharm]} 
}