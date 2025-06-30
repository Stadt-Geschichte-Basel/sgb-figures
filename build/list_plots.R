renv::load(".")

library(here)
library(fs)
library(jsonlite)
library(stringr)

src_path <- here("src")
data_path <- here("data", "clean")

# get all folders in src/ except 'Funktionen'
plot_dirs <- dir_ls(src_path, type = "directory", regexp = "[0-9]+$") %>%
  path_file() %>%
  sort()

# extract title string from metadata json
get_title <- function(plot_id) {
  band_dirs <- dir_ls(data_path, type = "directory", regexp = "Band[2-9]$")

  for (band_path in band_dirs) {
    json_path <- path(band_path, plot_id, paste0(plot_id, "_Data.csv-metadata.json"))

    if (file_exists(json_path)) {
      json <- tryCatch(fromJSON(json_path), error = function(e) return(NULL))
      if (!is.null(json) && !is.null(json$tables$tableSchema$title)) {
        return(json$tables$tableSchema$title[[1]])
      }
    }
  }

  return("[Kein Titel gefunden]")
}

message("\nFolgende Plots sind in diesem Repository verfügbar:\n")

# print plots and titles
for (plot_id in plot_dirs) {
  title <- get_title(plot_id)
  cat(paste0(plot_id, " – ", title, "\n"))
}
