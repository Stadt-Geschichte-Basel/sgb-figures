args <- commandArgs(trailingOnly = TRUE)

renv::load(".")

src_subdirs <- list.dirs(here::here("src"), full.names = FALSE, recursive = FALSE)
src_subdirs <- setdiff(src_subdirs, "Funktionen")

if (length(args) == 1) {
  plot <- args[1]
  if (plot %in% src_subdirs) {
    path <- here::here("src", plot, paste0(plot, "_plot.R"))
  } else {
    message(sprintf("Fehler: Kein Plot mit der ID '%s' gefunden.", plot))
    path <- here::here("build", "plotting_assistant.R")
  }
} else {
  path <- here::here("build", "plotting_assistant.R")
}

source(path)
