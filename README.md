Simulation Study of Eigenfunction Estimators
============================================

This project investigates and compares eigenfunction estimators. The main focus is on nonparametric estimator developed in dissertation, but for comparison purposes other standard estimators are considered. Currently the only other estimator considered is one described in, Functional Data Analysis (Ramsay and Silverman), and implemented in the R package `fda`. 

Currenlty the way we measure performance is by computing the `L2` norm between the estimated eigenfunctions and true eigenfunctions. Only the first two eigenfunctions are use for comparison. 

File structure of the project
-----------------------------

Ultimately everything is run from `main.R` or file matching `main*.R`. Within `main.R` a `.rds` file consisting of a list of parameter values is read in from the `params` folder. The list of parameter values is passed to a function (e.g. `run-sims()`), which handles the actual computing of estimators. The resulting output is saved in an `.rds` file and stored in the `results` folder with a name that corresponds to the parameters used in the computation. 

Each `results` file contains the estimated values, which then be used to compute things that we are interested in. In our case we are interested in computing the `L2` norm of the first two eigenfunctions. The code used for computing the `L2` norm is shown in `main.R` and makes use of the function `L2norm.R` which contains information about the true eigenfunctions for the process used to simulate the data. 




