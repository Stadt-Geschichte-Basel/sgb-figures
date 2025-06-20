library(here)

# wrapper to produce all files related to plot 39050
## this plot consists of multiple sub-plots: 39050a, 39050b, 39050c, 39050d
## the plot definitions are kept separate for legibility reasons
# source this file to create all plots at once

source(here("src", "39050", "39050ab_plot.R"))
source(here("src", "39050", "39050cd_plot.R"))