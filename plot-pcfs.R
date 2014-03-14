

# 
# junk <- readRDS("analysis/results/fpca-fda-params-ind-2.rds")
# junk <- readRDS("analysis/results/fpca-fda-params-dep-2.rds")
# junk <- readRDS(file.choose())
# xtable(L2_summary(junk),digits=3)
# rm(junk)



FPC <- readRDS("analysis/results/fpca-fda-params-ind-2.rds")
curve(fpc1_true, ylim=c(-2,2), col="red", main="B-spline, no spatial dependence")
for(i in 1:50){
  jj <- FPC[[i]]
  jj50 <- jj[[2]]
  jj50.1 <- jj50[[1]]
  curve(jj50.1, add=TRUE, col = 'gray')
}
curve(fpc1_true, col="red", add=TRUE)


FPC <- readRDS("analysis/results/fpca-fda-params-ind-2.rds")
curve(fpc2_true, ylim=c(-2,2), col="red", main="B-spline, no spatial dependence")
for(i in 1:50){
  jj <- FPC[[i]]
  jj50 <- jj[[2]]
  jj50.2 <- jj50[[2]]
  curve(jj50.2, add=TRUE, col = 'gray')
}
curve(fpc2_true, col="red", add=TRUE)
###########################################

FPC <- readRDS("cache/fpca-ss-params-ind-1.rds")
curve(fpc1_true, ylim=c(-2,2), col="red", main="ss-cov fit, no spatial dependence")
for(i in 1:50){
  jj <- FPC[[i]]
  jj50 <- jj[[2]]
  jj50.1 <- jj50[[1]]
  curve(jj50.1, add=TRUE, col = 'gray')
}
curve(fpc1_true, ylim=c(-2,2), col="red", add=TRUE)

FPC <- readRDS("cache/fpca-ss-params-ind-1.rds")
curve(fpc2_true, ylim=c(-2,2), col="red", main="ss-cov fit, no spatial dependence")
for(i in 1:50){
  jj <- FPC[[i]]
  jj50 <- jj[[2]]
  jj50.2 <- jj50[[2]]
  curve(jj50.2, add=TRUE, col = 'gray')
}
curve(fpc2_true, ylim=c(-2,2), col="red", add=TRUE)

