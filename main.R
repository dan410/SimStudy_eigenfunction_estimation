# This study seeks to understand the estimation of eigenfunctions using the nonparametric covariance and eigenfunction estimator proposed by Cai and Yuan 2010. Particularly, interest is in the effect of the number of observations per curve, as well as the level of noise in the measurement error process.

# load required packages 
library(ssfcov2)
library(sfdasim)
library(ggplot2)
source('run-simulations.R')
source('L2norm.R')

# set the working directory
setwd(dir = "/Users/dan410/Google Drive/Research/Projects/Simulation_Studies/SimStudy_eigenfunction_estimation")
# set the parameters
paramsfile = "params-dep-1.rds"
params <- readRDS(file = paste('params/', paramsfile, sep=""))

results <- run_sims(n.iter = 30, m = params$m, levels.m = params$levels.m, type = params$type, basis.pars = params$basis.pars, sigma0 = params$sigma0, rand.obs = params$rand.obs, n.dim = params$n.dim, n.marginal.knots = params$n.marginal.knots, cov.model = params$cov.model, cov.pars = params$cov.pars, locs = params$locs)$results

saveRDS(results, file = paste('results/results-', paramsfile, sep=""))

results <- readRDS(file = paste('results/results-', paramsfile, sep=""))

n.iter = 30
ef1 <- numeric(n.iter)
ef2 <- numeric(n.iter)
for( i in 1:n.iter){
    ef1[i] <- L2norm1(results[[i]][[2]]$eig.est)
    ef2[i] <- L2norm2(results[[i]][[2]]$eig.est)
}

mean(ef1)
sd(ef1)
mean(ef2)
sd(ef2)
        
# Include code to plot results and compute tabulated values
########## plot all FPCs on one plot ####################

fpc.df <- rbind(fpc1.df, fpc2.df)
fpc.df$m <- factor(fpc.df$m, levels=levels.m)

gg <- ggplot(fpc.df, aes(x=Time, y=X, group=m, col=m))	
gg + geom_line() + facet_grid(FPC~sigma0, labeller=label_both)	+ theme_bw() + scale_color_hue()




