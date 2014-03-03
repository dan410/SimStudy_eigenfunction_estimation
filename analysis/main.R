# load required packages and required functions
source("libraries/libs.R")

run_sims(n.data.sets = 3, paramsfile = "params-ind-1.rds")
run_sims(n.data.sets = 3, paramsfile = "params-dep-1.rds")