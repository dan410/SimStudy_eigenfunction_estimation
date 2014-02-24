#################################################################
###### creating a data frame of results suitable for plotting ###
#################################################################
fpc.true <- list() # list of the true fpcs 

########## 1st FPC ##################
# define a function for the true FPC
fpc.true[[1]] <- function(x){1/sqrt(0.5)*cos(pi*x)}

# create data frame with true function evaluated on a fine grid
Time <- 1:1000/1000
X <- fpc.true[[1]](Time)
true.fpc <- data.frame(Time=Time, X=X)
true.fpc$FPC <-1
true.fpc$m <- "truth"
true.fpc <- true.fpc[rep(1:nrow(true.fpc), times=length(sigma0)),]
true.fpc$sigma0 <- rep(sigma0, each=1000)

evaldf <- NULL
for(i in 1:len.m){
	for(j in 1:len.sigma0){
		ef <- EIGFUN[[len.sigma0*(i-1) + j]]
		vals <- ef$values
		fun <- ef$fns[[order(vals, decreasing=TRUE)[1] ]]
		Time <- 1:1000/1000
		X <- fun(Time)
		if(X[1]<0){X <- -1*X}  # trying to force uniformity among function estimates since sign seems to change
		temp <- data.frame(Time=Time, X=X)
		temp$FPC <- 1
		temp$m <- m[i]
		temp$sigma0 <- sigma0[j]
		evaldf <- rbind(evaldf, temp)
	}
}

fpc1.df <- rbind(evaldf, true.fpc)
fpc1.df$m <- factor(fpc1.df$m, levels=levels.m)

gg <- ggplot(fpc1.df, aes(x=Time, y=X, group=m, col=m))	
gg + geom_line() + facet_grid(~sigma0, labeller=label_both)	+ theme_bw() + scale_color_hue()

########## 2nd FPC ##################
# define a function for the true FPC
fpc.true[[2]] <- function(x){1/sqrt(0.5)*cos(2*pi*x)}

# create data frame with true function evaluated on a fine grid
Time <- 1:1000/1000
X <- fpc.true[[2]](Time)
true.fpc <- data.frame(Time=Time, X=X)
true.fpc$FPC <-2
true.fpc$m <- "truth"
true.fpc <- true.fpc[rep(1:nrow(true.fpc), times=length(sigma0)),]
true.fpc$sigma0 <- rep(sigma0, each=1000)

evaldf <- NULL
for(i in 1:len.m){
	for(j in 1:len.sigma0){
		ef <- EIGFUN[[len.sigma0*(i-1) + j]]
		vals <- ef$values
		fun <- ef$fns[[order(vals, decreasing=TRUE)[2] ]]
		Time <- 1:1000/1000
		X <- fun(Time)
		if(X[1]<0){X <- -1*X}
		temp <- data.frame(Time=Time, X=X)
		temp$FPC <- 2
		temp$m <- m[i]
		temp$sigma0 <- sigma0[j]
		evaldf <- rbind(evaldf, temp)
	}
}

fpc2.df <- rbind(evaldf, true.fpc)
fpc2.df$m <- factor(fpc2.df$m, levels=levels.m)

gg <- ggplot(fpc2.df, aes(x=Time, y=X, group=m, col=m))	
gg + geom_line() + facet_grid(~sigma0, labeller=label_both)	+ theme_bw() + scale_color_hue()
