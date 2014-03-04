

# load required packages 
cat("loading R packages \n")
library(ssfcov2)
library(sfdasim)
library(ggplot2)
library(fda)
library(TeachingDemos) # I use char2seed() function to set the RNG

# source required functions
path = "./R"
cat( paste("loading functions in folder", path))
for (nm in list.files("./R", pattern = "\\.[Rr]$")) {
  source(file.path(path, nm))
}

