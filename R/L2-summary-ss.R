
#########################
# To measure performance, compute L2 norm of difference between estimated and true EFs
#########################
L2_summary_ss <- function(){
ef1 <- numeric(n.data.sets)
ef2 <- numeric(n.data.sets)
for( i in 1:n.data.sets){
  ef1[i] <- L2norm1(EIG.EST[[i]][[2]]$eig.est)
  ef2[i] <- L2norm2(EIG.EST[[i]][[2]]$eig.est)
}
# Summary statistics
mean(ef1)
sd(ef1)
mean(ef2)
sd(ef2)
}