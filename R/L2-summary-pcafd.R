
L2_summary_pcafd <- function(){

# To measure performance, compute L2 norm of difference between estimated and true EFs
ef1 <- numeric(n.data.sets)
ef2 <- numeric(n.data.sets)
for( i in 1:n.data.sets){
  ef1[i] <- norm_L2(EIG.EST[[i]]$pc1, fpc1_true)
  ef2[i] <- norm_L2(EIG.EST[[i]]$pc2, fpc2_true)
}
mean(ef1)
sd(ef1)/sqrt(n.data.sets)
mean(ef2)
sd(ef2)/sqrt(n.data.sets)
}