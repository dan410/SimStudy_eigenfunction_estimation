
#' compute L2 norm of difference between estimated and true EFs as well as summary stats
#' 
#' compute L2 norm of difference between estimated and true EFs as well as summary stats
#' 
#' @param fpc list with each element a list of the first two FPCs
#' @param round.digits integer indicating the number of decimal places to be used. Negative values are allowed (see ?base::round for details)
#' @return data frame containing summary statistics 
L2_summary <- function(fpc, round.digits = 4){
   FPC.L2 <- ldply(fpc, .fun = fpca_L2norm)
   stopifnot(is.data.frame(FPC.L2))
    
   summary <- data.frame(median.PC1 = median(FPC.L2$L2fpc1),
                         mean.PC1 = mean(FPC.L2$L2fpc1),
                         se.PC1 = sd(FPC.L2$L2fpc1)/sqrt(length(FPC.L2$L2fpc1)),
                         median.PC2 = median(FPC.L2$L2fpc2),
                         mean.PC2 = mean(FPC.L2$L2fpc2),
                         se.PC2 = sd(FPC.L2$L2fpc2)/sqrt(length(FPC.L2$L2fpc2)))
   
   return(round(summary, digits = round.digits))
}