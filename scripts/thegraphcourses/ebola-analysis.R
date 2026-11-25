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

head(ebola_data)
print(as_tibble(ebola_data), n = Inf) # convert to tibble if not already tibble

# Visualize data types in data (including NAs)
visdat::vis_dat(ebola_data)
inspectdf::show_plot(inspectdf::inspect_cat(ebola_data))
inspectdf::show_plot(inspectdf::inspect_num(ebola_data))

ggplotly(
  inspectdf::show_plot(inspectdf::inspect_cat(ebola_data))
)

ggplotly(
  inspectdf::show_plot(inspectdf::inspect_num(ebola_data))
)

# Visualising data using esquise
esquisse::esquisser(ebola_data)

# visualizing cateorical data with janitor tabyl.
tabyl(ebola_data, district)
tabyl(ebola_data, sex)

# Contingency table with janitor tabyl
tabyl(ebola_data, district, sex)
tabyl(ebola_data, district, status)
