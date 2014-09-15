
library(xtable)

### L2-norm summary statistic

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

### Missing gap data

fit.ss5 <- readRDS("cache/gap-fpca-ss-params-ind-5.rds")
fit.ss10 <- readRDS("cache/gap-fpca-ss-params-ind-10.rds")
fit.ss20 <- readRDS("cache/gap-fpca-ss-params-ind-20.rds")
res.ss5 <- L2_summary(fit.ss5)
res.ss10 <- L2_summary(fit.ss10)
res.ss20 <- L2_summary(fit.ss20)

fit.fda5 <- readRDS("cache/gap-fpca-fda-params-ind-5.rds")
fit.fda10 <- readRDS("cache/gap-fpca-fda-params-ind-10.rds")
fit.fda20 <- readRDS("cache/gap-fpca-fda-params-ind-20.rds")
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

file = "beta-fpca-ss-params-ind-20"
FPC <- readRDS(paste("cache/",file, ".rds" ,sep=""))
# PC1
n <- length(FPC)
eval.xs <- 1:1000/1001
eval.mat <- matrix(0, nrow= n+1, ncol = length(eval.xs))
eval.mat[1,] <- fpc1_true(eval.xs)
for(i in 1:n){
  eval.mat[i+1,] <- FPC[[i]]$fpc1(eval.xs)
  ### the following code forces the sign of the estimate PCF to match the true PCF
  if(eval.mat[i+1,1] < eval.mat[i+1,1000]) eval.mat[i+1,] <- -1*eval.mat[i+1,]
}
limits <- apply(eval.mat[-1,], 2, quantile, probs = c(0.025, .975))
avg <- apply(eval.mat[-1,], 2, mean)
df <- data.frame(x = eval.xs, avg = avg, lower = limits[1,], upper = limits[2,], truth = eval.mat[1,])
ggp <- ggplot(df, aes(x = x, y = avg))
ggp <- ggp + geom_line() + geom_line(aes(y=truth), linetype="dashed")
ggp <- ggp + geom_ribbon(aes(ymin=lower, ymax = upper), alpha= 0.3)
ggp <- ggp + xlab('') + ylab('1st FPC') + ylim(c(-2,2)) + theme_bw()
ggp <- ggp + theme(axis.title.y = element_text(size = rel(1.2), angle = 90))
ggp 
ggsave(paste("figure/fpc1-", file, ".pdf", sep=""), width = 4, height = 4)

ys <- as.vector(t(eval.mat[-1,]))
xs <- rep(eval.xs, n)
id <- rep(1:n, each = length(eval.xs))
df <- data.frame(id = id, x = xs, y = ys)
truth = eval.mat[1,]
truth.df <- data.frame(xs = eval.xs, truth = truth)

ggp <- ggplot(df, aes(x = x, y = y))
ggp <- ggp + geom_line(aes(group=id), alpha= 0.2) + geom_line(data=truth.df, aes(x=xs, y=truth), color="red", size=2)
ggp <- ggp + xlab('') + ylab('1st FPC') + theme_bw()
ggp <- ggp + theme(axis.title.y = element_text(size = rel(1.2), angle = 90))
ggp 
ggsave(paste("figure/fpc1-lines-", file, ".pdf", sep=""), width = 4, height = 4)


########### PC2 ##############
n <- length(FPC)
eval.xs <- 1:1000/1001
eval.mat <- matrix(0, nrow= n+1, ncol = length(eval.xs))
eval.mat[1,] <- fpc2_true(eval.xs)
for(i in 1:n){
  eval.mat[i+1,] <- FPC[[i]]$fpc2(eval.xs)
  ### the following code forces the sign of the estimate PCF to match the true PCF by a simple check on the concavity of the estimate
  ### logic: if the value near the end points is less than the valus near the center, then the concavity is incorrect
  if((eval.mat[i+1,5] < eval.mat[i+1,500]) & (eval.mat[i+1,995] < eval.mat[i+1,500])) eval.mat[i+1,] <- -1*eval.mat[i+1,]
}
limits <- apply(eval.mat[-1,], 2, quantile, probs = c(0.025, .975))
avg <- apply(eval.mat[-1,], 2, mean)
df <- data.frame(x = eval.xs, avg = avg, lower = limits[1,], upper = limits[2,], truth = eval.mat[1,])
ggp <- ggplot(df, aes(x = x, y = avg))
ggp <- ggp + geom_line() + geom_line(aes(y=truth), linetype="dashed")
ggp <- ggp + geom_ribbon(aes(ymin=lower, ymax = upper), alpha= 0.3)
ggp <- ggp + xlab('') + ylab('2nd FPC') + ylim(c(-3,3))+ theme_bw()
ggp <- ggp + theme(axis.title.y = element_text(size = rel(1.2), angle = 90))
ggp 

ggsave(paste("figure/fpc2-", file, ".pdf", sep=""), width = 4, height = 4)

ys <- as.vector(t(eval.mat[-1,]))
xs <- rep(eval.xs, n)
id <- rep(1:n, each = length(eval.xs))
df <- data.frame(id = id, x = xs, y = ys)
truth = eval.mat[1,]
truth.df <- data.frame(xs = eval.xs, truth = truth)

ggp <- ggplot(df, aes(x = x, y = y))
ggp <- ggp + geom_line(aes(group=id), alpha= 0.2) + geom_line(data=truth.df, aes(x=xs, y=truth), color="red", size=2)
ggp <- ggp + xlab('') + ylab('2nd FPC') + theme_bw()
ggp <- ggp + theme(axis.title.y = element_text(size = rel(1.2), angle = 90))
ggp 

ggsave(paste("figure/fpc2-lines-", file, ".pdf", sep=""), width = 4, height = 4)


