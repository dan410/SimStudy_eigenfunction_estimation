

library(xtable)
junk <- readRDS("analysis/results/fpca-fda-params-ind-3.rds")
junk <- readRDS("analysis/results/fpca-ss-params-ind-3.rds")
junk <- readRDS("cache/fpca-ss-params-ind-3.rds")
junk <- readRDS("cache/fpca-fda-params-ind-3.rds")

(res <- L2_summary(junk))
xtable(res,digits=3)
rm(junk)



FPC <- readRDS("cache/fpca-fda-params-ind-3.rds")
curve(fpc1_true, ylim=c(-2,2), col="red", main="B-spline, no spatial dependence")
for(i in 1:50){
  jj <- FPC[[i]]
  jj50 <- jj[[1]]
  jj50.1 <- jj50[[1]]
  curve(jj50.1, add=TRUE, col = 'gray')
}
curve(fpc1_true, col="red", add=TRUE)


FPC <- readRDS("cache/fpca-fda-params-ind-2.rds")
curve(fpc2_true, ylim=c(-2,2), col="red", main="B-spline, no spatial dependence")
for(i in 1:50){
  jj <- FPC[[i]]
  jj50 <- jj[[1]]
  jj50.2 <- jj50[[2]]
  curve(jj50.2, add=TRUE, col = 'gray')
}
curve(fpc2_true, col="red", add=TRUE)
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

