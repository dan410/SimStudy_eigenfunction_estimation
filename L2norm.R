

L2norm1 <- function(obj){

########## 1st FPC ##################
# define a function for the true FPC
fpc1.true <- function(x){1/sqrt(0.5)*cos(pi*x)}
vals <- obj$values
ef1 <- obj$fns[[order(vals, decreasing=TRUE)[1] ]]

# note: the sign of the eigenfunction may neet to be changed in order for the norm to be calculated appropriately. here both versions are computed and the minimum is returned
g1 <- function(x){ (fpc1.true(x) - ef1(x))^2}
h1 <- function(x){ (fpc1.true(x) + ef1(x))^2}
norm1 <- min(integrate(g1, 0,1)$value, integrate(h1, 0,1)$value)

return(norm1)

}


L2norm2 <- function(obj){
########## 2nd FPC ##################
# define a function for the true FPC
fpc2.true <- function(x){1/sqrt(0.5)*cos(2*pi*x)}
vals <- obj$values
ef2 <- obj$fns[[order(vals, decreasing=TRUE)[2] ]]

# note: the sign of the eigenfunction may neet to be changed in order for the norm to be calculated appropriately. here both versions are computed and the minimum is returned
g <- function(x){ (fpc2.true(x) - ef2(x))^2}
h <- function(x){ (fpc2.true(x) + ef2(x))^2}
norm2 <- min(integrate(g, 0,1)$value, integrate(h, 0,1)$value)

return(norm2)

}
