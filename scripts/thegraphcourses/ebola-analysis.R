# Ebola seria leone analysis
# Tsatsu Arnong
# 18 Nov 2026

# Insatlling and calling rqquired libraries 
if(!require(pacman)) install.packages("pacman")
  pacman::p_load(
    tidyverse,
    ispectdf, #remotes::install_github("alastairrushworth/inspectdf")
    plotly,
    janitor,
    visdat,
    esquisse,
    tibble
  )

#Loading dataset
ebola_data <- read.csv("data/raw/ebola_sierra_leone.csv")

print(as_tibble(ebola_data), n = Inf) # convert to tibble if not already tibble

