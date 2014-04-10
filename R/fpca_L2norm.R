#' computes L2 norm for first two principal components
#' 
#' computes L2 norm for first two principal components
#'
#' @param fpcs list with each element containing a list of two functions corresponding to the principal component functions
#' @param fpc1 true first principal component from the process that generated the data
#' @param fpc2 true second principal component from the process that generated the data
#' @return data frame with columns containing information about each data set and the caclulated L2 norms between estimated and true FPCs
fpca_L2norm <- function(fpcs, fpc1 = fpc1_true, fpc2 = fpc2_true){
    L21 <- norm_L2(fpcs$fpc1, fpc1)
    L22 <- norm_L2(fpcs$fpc2, fpc2)
    data.frame(L2fpc1=L21, L2fpc2=L22)
}

