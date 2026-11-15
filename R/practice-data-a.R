if(!require("pacman")) install.packages("pacman")
  pacman::p_load(
    googledrive, # To access data from google drive
    tidyverse,
    visdat,
    inspectdf, # remotes::install_github("alastairrushworth/inspectdf")
    gtsummary,
    haven #for importing dta file
  )

# Download data from google drive to local environment
googledrive::drive_auth() # To login to google drive (one-time login)

file_id <- as_id("1s0Xrt39eE1_WawVUPp55E5UYqH78pzbV") #file ID from sharing link (/d/#########/)

drive_download(
  file_id, 
  path = "data/raw/practice.dta",
  overwrite = TRUE
) # Download from drive to local environment

# importing data from local environment
data <- haven::read_dta("data/raw/practice.dta")

#Save data as RDS for easy manipulation
saveRDS(data, file = "data/raw/practice_data.RDS")

# importing RDS data
data <- readRDS("data/raw/practice_data.RDS")


#inspecting data to visualize errors in dataset
dim(data)
glimpse(data)
summary(data)

visdat::vis_dat(data)

inspectdf::inspect_cat(practice_data) |> 
  show_plot()

inspectdf::inspect_num(practice_data) |> 
  show_plot()

#### Answering questions from practice data questions.========
#number of participants

# data|> 
#   select(marital) |> 
#   table()

# data |> 
#   count(marital)

data |> 
  select(marital) |> 
  tbl_summary()


# data |> 
#   select(sex, urban) |> 
#   ftable() |> 
#   chisq.test()


# How many participants are included in the dataset
nrow(data)

n_distinct(data$pid) #use this if you fear repititions
# 4700

# number and percentage of participants that are female
data |> 
  count(sex, name = "frequency") |> # Number: 2425
  mutate(percent = (frequency/sum(frequency)) * 100) # Percentage: 51.6%


# number and percentage of participants that reside in urban areas
data |> 
  count(urban, name = "count") |> # Number: 2425
  mutate(percent = (count/sum(count)) * 100)

# Describe age distribution of participants using approporiate
# measure of central distribution and dispersion
data |> 
  summarise(
    mean_age = mean(age, na.rm = TRUE),
    SD_age = sd(age, na.rm = TRUE)
  )

## check skewness first and decide the best measure of central tendency to use
data |> 
  select(y_cost) |>
  summary()


# Get number of null values in a dataset hdl, crp, hbaic
data |> 
  select(y_cost, hdl, crp, hba1c) |>
  is.na() |> 
  colSums() |> 
  sort(decreasing = TRUE)

# How many participants have complete data of all four laboratory values
# and what percentage of the total sample does this represent.
non_missing_data <- data |>
  filter(if_all(c(y_cost, hdl, crp,hba1c), ~ !is.na(.x)))
# Number with complete data in all four laboratory values:3972
# Total number ofparticipants: 4700

percentage <- (n_distinct(non_missing_data) / n_distinct(data)) * 100
# percentage: 84.51064












## Code for drawing histogram for checking skewness
# ggplot(data, ggplot2::aes(x = y_cost)) +
#   geom_histogram(
#     aes(y = after_stat(density)),
#     bins = 30,
#     color = "white"
#   ) +
#   stat_function(
#     fun = dnorm,
#     args = list(
#       mean = mean(data$y_cost, na.rm = TRUE),
#       sd = sd(data$y_cost, na.rm = TRUE)
#     )
#   )





# Uploading back to google drive
# drive_upload(
#   media = "local_results.csv",
#   path = "Project Folder/", 
#   name = "results_2026-11-07.csv"
# )
