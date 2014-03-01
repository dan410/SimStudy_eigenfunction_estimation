Simulation Study of Eigenfunction Estimators
============================================

This project investigates and compares eigenfunction estimators. The main focus is on nonparametric estimator developed in dissertation, but for comparison purposes other standard estimators are considered. Currently the only other estimator considered is one described in Functional Data Analysis (Ramsay and Silverman), and implemented by the function `pca.fd` in the R package `fda`. 

Currenlty the way we measure performance is by computing the `L2` norm between the estimated eigenfunctions and true eigenfunctions. Only the first two eigenfunctions are use for comparison. 

File structure of the project
-----------------------------

Ultimately everything is run from `main.R`. Within `main.R` an `.rds` file consisting of a list of parameter values is read in from the params folder. The list of parameter values is ...

For example, in the params folder the file params-ind-1.R contains the code to create a list object of parameter values ("ind" indicates no spatial dependence between locations). When params-ind-1.R is run, it will produce the list object params-ind-1.rds. In main.R, the `.rds` file is read in and ... 

...In our case we are interested in computing the `L2` norm of the first two eigenfunctions. The code used for computing the `L2` norm is shown in `main.R`.

List of TODO's for this project
-------------------------------

- Change basis functions in the simulations study to B-splines for the pca.fd() estimator. 

- In the simulation study, include means as well as medians to see if there is an effect of a few outlying observations.



