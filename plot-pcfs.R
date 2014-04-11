

library(xtable)
#junk <- readRDS("analysis/results/fpca-fda-params-ind-3.rds")
fit.ss <- readRDS("analysis/results/fpca-ss-params-ind-20.rds")
fit.fda <- readRDS("analysis/results/fpca-fda-params-ind-20.rds")
fit.ss <- readRDS("cache/fpca-ss-params-ind-3.rds")
( res.ss <- L2_summary(fit.ss))
fit.fda <- readRDS("cache/fpca-fda-params-ind-3.rds") 
(res.fda <- L2_summary(fit.fda))

xtable(res.ss,digits=3)
xtable(res.fda, digits=3)

rm(junk)



FPC <- readRDS("cache/fpca-ss-params-ind-20.rds")
eval.xs <- 1:1000/1001
eval.mat <- matrix(0, nrow= n+1, ncol = length(eval.xs))
eval.mat[1,] <- fpc1_true(eval.xs)
for(i in 1:n){
  eval.mat[i+1,] <- FPC[[i]]$fpc1(eval.xs)
  ### the following code forces the sign of the estimate PCF to match the true PCF
  if(sign(eval.mat[1,1])*sign(eval.mat[i,1])<0) eval.mat[i,] <- -1*eval.mat[i,]
}

limits <- apply(eval.mat[-1,], 2, quantile, probs = c(0.025, .975))
avg <- apply(eval.mat[-1,], 2, mean)
df <- data.frame(x = eval.xs, avg = avg, lower = limits[1,], upper = limits[2,], truth = eval.mat[1,])
ggp <- ggplot(df, aes(x = x, y = avg))
ggp <- ggp + geom_line() + geom_line(aes(y=truth), color="red")
ggp <- ggp + geom_ribbon(aes(ymin=lower, ymax = upper), alpha= 0.3)
ggp 
  
### plot estimate of second principal component function
eval.xs <- 1:1000/1001
eval.mat <- matrix(0, nrow= n+1, ncol = length(eval.xs))
eval.mat[1,] <- fpc2_true(eval.xs)
for(i in 1:n){
  eval.mat[i+1,] <- FPC[[i]]$fpc2(eval.xs)
  ### the following code forces the sign of the estimate PCF to match the true PCF
  if(sign(eval.mat[1,500])*sign(eval.mat[i,500])<0) eval.mat[i,] <- -1*eval.mat[i,]
}

limits <- apply(eval.mat[-1,], 2, quantile, probs = c(0.025, .975))
avg <- apply(eval.mat[-1,], 2, mean)
df <- data.frame(x = eval.xs, avg = avg, lower = limits[1,], upper = limits[2,], truth = eval.mat[1,])
ggp <- ggplot(df, aes(x = x, y = avg))
ggp <- ggp + geom_line() + geom_line(aes(y=truth), color="red")
ggp <- ggp + geom_ribbon(aes(ymin=lower, ymax = upper), alpha= 0.3)
ggp 


###########################################

FPC <- readRDS("cache/fpca-ss-params-ind-3.rds")
curve(fpc1_true, ylim=c(-2,2), col="red", main="ss-cov fit, no spatial dependence")
for(i in 1:50){
  jj <- FPC[[i]]
  jj50 <- jj[[1]]
  jj50.1 <- jj50[[1]]
  curve(jj50.1, add=TRUE, col = 'gray')
}
curve(fpc1_true, ylim=c(-2,2), col="red", add=TRUE)

FPC <- readRDS("cache/fpca-ss-params-ind-3.rds")
curve(fpc2_true, ylim=c(-2,2), col="red", main="ss-cov fit, no spatial dependence")
for(i in 1:50){
  jj <- FPC[[i]]
  jj50 <- jj[[1]]
  jj50.2 <- jj50[[2]]
  curve(jj50.2, add=TRUE, col = 'gray')
}
curve(fpc2_true, ylim=c(-2,2), col="red", add=TRUE)

