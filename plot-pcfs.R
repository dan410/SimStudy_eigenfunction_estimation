
### L2-norm summary statistic
library(xtable)
fit.ss20 <- readRDS("analysis/results/fpca-ss-params-ind-20.rds")
fit.fda20 <- readRDS("analysis/results/fpca-fda-params-ind-20.rds")

fit.ss5 <- readRDS("cache/fpca-ss-params-ind-5.rds")
fit.ss10 <- readRDS("cache/fpca-ss-params-ind-10.rds")
fit.ss20 <- readRDS("cache/fpca-ss-params-ind-20.rds")
res.ss5 <- L2_summary(fit.ss5)
res.ss10 <- L2_summary(fit.ss10)
res.ss20 <- L2_summary(fit.ss20)

fit.fda5 <- readRDS("cache/fpca-fda-params-ind-5.rds")
fit.fda10 <- readRDS("cache/fpca-fda-params-ind-10.rds")
fit.fda20 <- readRDS("cache/fpca-fda-params-ind-20.rds")
res.fda5 <- L2_summary(fit.fda5)
res.fda10 <- L2_summary(fit.fda10)
res.fda20 <- L2_summary(fit.fda20)

r1 <- cbind(res.ss5[,1:3], res.fda5[,1:3])
r2 <- cbind(res.ss10[,1:3], res.fda10[,1:3])
r3 <- cbind(res.ss20[,1:3], res.fda20[,1:3])
r4 <- cbind(res.ss5[,4:6], res.fda5[,4:6])
r5 <- cbind(res.ss10[,4:6], res.fda10[,4:6])
r6 <- cbind(res.ss20[,4:6], res.fda20[,4:6])

fpc1 <- rbind(r1, r2, r3)
fpc1 <- fpc1[,-c(1,4)]
xtable(fpc1, digits = 4)

fpc2 <- rbind(r4, r5, r6)
fpc2 <- fpc2[, -c(1,4)]
xtable(fpc2, digits = 4)

fit.fda20.gap <- readRDS("cache/gap-fpca-fda-params-ind-20.rds")
fit.ss20.gap <- readRDS("cache/gap-fpca-ss-params-ind-20.rds")

(res.ss20 <- L2_summary(fit.ss20.gap))
(res.fda20 <- L2_summary(fit.fda20.gap))

fit.fda10.gap <- readRDS("cache/gap-fpca-fda-params-ind-10.rds")
fit.ss10.gap <- readRDS("cache/gap-fpca-ss-params-ind-10.rds")

(res.ss10 <- L2_summary(fit.ss10.gap))
(res.fda10 <- L2_summary(fit.fda10.gap))

### Beta distribution data

fit.ss5 <- readRDS("cache/beta-fpca-ss-params-ind-5.rds")
fit.ss10 <- readRDS("cache/beta-fpca-ss-params-ind-10.rds")
fit.ss20 <- readRDS("cache/beta-fpca-ss-params-ind-20.rds")
res.ss5 <- L2_summary(fit.ss5)
res.ss10 <- L2_summary(fit.ss10)
res.ss20 <- L2_summary(fit.ss20)

fit.fda5 <- readRDS("cache/beta-fpca-fda-params-ind-5.rds")
fit.fda10 <- readRDS("cache/beta-fpca-fda-params-ind-10.rds")
fit.fda20 <- readRDS("cache/beta-fpca-fda-params-ind-20.rds")
res.fda5 <- L2_summary(fit.fda5)
res.fda10 <- L2_summary(fit.fda10)
res.fda20 <- L2_summary(fit.fda20)

r1 <- cbind(res.ss5[,1:3], res.fda5[,1:3])
r2 <- cbind(res.ss10[,1:3], res.fda10[,1:3])
r3 <- cbind(res.ss20[,1:3], res.fda20[,1:3])
r4 <- cbind(res.ss5[,4:6], res.fda5[,4:6])
r5 <- cbind(res.ss10[,4:6], res.fda10[,4:6])
r6 <- cbind(res.ss20[,4:6], res.fda20[,4:6])

fpc1 <- rbind(r1, r2, r3)
fpc1 <- fpc1[,-c(1,4)]
xtable(fpc1, digits = 4)

fpc2 <- rbind(r4, r5, r6)
fpc2 <- fpc2[, -c(1,4)]
xtable(fpc2, digits = 4)

### plot principal component functions with pointwise confidence bands
FPC <- readRDS("analysis/results/fpca-fda-params-ind-20.rds")
FPC <- readRDS("cache/beta-fpca-fda-params-ind-20.rds")
file = "beta-fpca-fda-params-ind-10"
FPC <- readRDS(paste("cache/",file, ".rds" ,sep=""))
# PC1
n <- length(FPC)
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
ggp <- ggp + geom_line() + geom_line(aes(y=truth), linetype="dashed")
ggp <- ggp + geom_ribbon(aes(ymin=lower, ymax = upper), alpha= 0.3)
ggp <- ggp + xlab('') + ylab('1st FPC') + theme_bw()
ggp <- ggp + theme(axis.title.y = element_text(size = rel(1.2), angle = 90))
ggp 
ggsave(paste("figure/fpc1-", file, ".pdf", sep=""))
# PC2
n <- length(FPC)
eval.xs <- 1:1000/1001
eval.mat <- matrix(0, nrow= n+1, ncol = length(eval.xs))
eval.mat[1,] <- fpc2_true(eval.xs)
for(i in 1:n){
  eval.mat[i+1,] <- FPC[[i]]$fpc2(eval.xs)
  ### the following code forces the sign of the estimate PCF to match the true PCF by a simple check on the concavity of the estimate
  ### logic: if the value near the end points is less than the valus near the center, then the concavity is incorrect
  if((eval.mat[i,5] < eval.mat[i,500]) & (eval.mat[i,995] < eval.mat[i,500])) eval.mat[i,] <- -1*eval.mat[i,]
}
limits <- apply(eval.mat[-1,], 2, quantile, probs = c(0.025, .975))
avg <- apply(eval.mat[-1,], 2, mean)
df <- data.frame(x = eval.xs, avg = avg, lower = limits[1,], upper = limits[2,], truth = eval.mat[1,])
ggp <- ggplot(df, aes(x = x, y = avg))
ggp <- ggp + geom_line() + geom_line(aes(y=truth), linetype="dashed")
ggp <- ggp + geom_ribbon(aes(ymin=lower, ymax = upper), alpha= 0.3)
ggp <- ggp + xlab('') + ylab('2nd FPC') + theme_bw()
ggp <- ggp + theme(axis.title.y = element_text(size = rel(1.2), angle = 90))
ggp 

ggsave(paste("figure/fpc2-", file, ".pdf", sep=""))




