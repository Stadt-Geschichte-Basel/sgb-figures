args <- commandArgs(trailingOnly = TRUE)

renv::load(".")

if (length(args) > 0) {
  script <- args[1]
  path <- here::here("src", script, paste0(script, "_plot.R"))
} else {
  path <- here::here("build", "plotting_assistant.R")
}

source(path)
