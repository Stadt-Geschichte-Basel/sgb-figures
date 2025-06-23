library(here)

# wrapper to produce all files related to plot 80238
## this plot consists of multiple sub-plots: 80238a, 80238b, 80238c, 80238d
## the plot definitions are kept separate for legibility reasons
# source this file to create all plots at once

source(here("src", "80238", "80238a_plot.R"))
source(here("src", "80238", "80238b_plot.R"))
source(here("src", "80238", "80238c_plot.R"))
source(here("src", "80238", "80238d_plot.R"))