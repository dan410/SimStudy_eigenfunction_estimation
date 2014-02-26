Simulation Study of Eigenfunction Estimators
============================================

This project investigates and compares eigenfunction estimators. The main focus is on nonparametric estimator developed in dissertation, but for comparison purposes other standard estimators are considered. Currently the only other estimator considered is one described in, Functional Data Analysis (Ramsay and Silverman), and implemented in the R package `fda`. 

Currenlty the way we measure performance is by computing the `L2` norm between the estimated eigenfunctions and true eigenfunctions. Only the first two eigenfunctions are use for comparison. 

File structure of the project
-----------------------------

Ultimately everything is run from main.R or file matching main*.R. Within main.R an `.rds` file consisting of a list of parameter values is read in from the params folder. The list of parameter values is passed to a function (e.g. `run-sims()`), which handles the actual computing of estimators. The resulting output is saved in an `.rds` file and stored in the results folder with a name that corresponds to the parameters used in the computation. 

For example, in the params folder the file params-ind-1.R contains the code to create a list object of parameter values ("ind" indicates no spatial dependence between locations). When params-ind-1.R is run, it will produce the list object params-ind-1.rds. In main.R, the `.rds` file is read in and passed to the simulaton engine `run-sims()`, the ouput of which is saved in results-params-ind-1.rds. This file naming convention makes explicit which parameters were used to produce the corresponding output. 

Each results*.rds file contains the estimated values, which can then be used for further computation. In our case we are interested in computing the `L2` norm of the first two eigenfunctions. The code used for computing the `L2` norm is shown in main.R and makes use of the functions `L2norm1()` and `L2norm2()` (sourced from L2norm.R) which contain information about the true eigenfunctions for the process used to simulate the data. 




