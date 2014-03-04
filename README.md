Simulation Study of Eigenfunction Estimators
============================================

This project investigates and compares eigenfunction estimators. The main focus is on the nonparametric estimator developed in my dissertation, but for comparison purposes other standard estimators are considered. Currently the only other estimator considered is one described in Functional Data Analysis (Ramsay and Silverman), and implemented by the function `pca.fd()` in the R package `fda`. Their method relies on finite basis representation of curves, thus a pre-packaged set of basis functions must be chosen. The current implementation uses a B-spline basis.

The way we measure performance is by computing the (squared) L2-norm between the estimated eigenfunctions and true eigenfunctions $\int(est-truth)^2$. Only the first two eigenfunctions are use for comparison. 

How to run a simulation
-----------------------------
### 1) specify process values 

This is accomplished by creating an 'input' file, which specifies the available input parameters (e.g. number of observations per curve, 'noise' standard deviation), stores them in a list and saves the list as an `.rds` file (see `analysis/params/inputs-ind-1.R` for an example). Both the input file and corresponding output object are saved in the `analysis/params/` folder. The naming convention used is for the R files specifying inputs to begin with "input" and the list object they create to begin with "params". Thus, when a file with the pattern `input-ZZZ.R` is run, it creates the object `params-ZZZ.rds`.

### 2) Edit `main.R` to include desired simulation specifications

Simulations are run using the `run_sims()` function, which is called from within `main.R`. The file `main.R` `source()`s the required R packages as well as the `R/` folder which contains all the necessary R functions, then calls the function `run_sims()` with arguments that include the `params-ZZZ.rds` file and number of data sets to generate. There are some packages required that are not available on CRAN and need to be installed manually (see section on Loading Packages).

### 3) Run simulations by invoking the `Makefile`

Once `main.R` has been edited and saved. Type `make` into the terminal command line (with the project directory set as the the current working directory) and the simulations will be run in BATCH mode with the results saved to the `analysis/results/` folder. The simulations are run using the `nohup` (no termination upon hangup). Open the `Makefile` to see the specific commands by typing `nano Makefile` in the command line.

Loading packages that are not publicly available
-----------------------------
There are two required packages that are not publicly available (sfdasim, ssfcov2). These packages need to be saved to a folder whose path is included in your R search path. For example, I do not have install privileges on the Linux servers in the stat department, so I have saved the packages in the folder `/home/.../Rlibs` and added the line `.libPaths('/home/.../Rlibs')` to the file `/home/.Rprofile` on the stat department Linux server. 

TODO's for this project
----------------------------------

- Change basis functions in the simulations study to B-splines for the pca.fd() estimator. 





