args <- commandArgs(trailingOnly = TRUE)

renv::load(".")

library(here)
library(fs)
library(jsonlite)
library(stringr)

if (length(args) != 1 || !str_detect(args[1], "^[1-9]$")) {
  stop("Bitte geben Sie eine gültige Bandnummer zwischen 1 und 9 an (z.B. 'npm run vol 8').")
}

band_num <- args[1]

if (band_num %in% c("1", "5")) {
  message(sprintf("In Band %s der Stadt.Geschichte.Basel gibt es keine mit R erzeugten Plots.", band_num))
  message("Verfügbare Daten für diesen Band können unter https://forschung.stadtgeschichtebasel.ch durchsucht werden.")
  quit(save = "no", status = 0)
}

band_name <- paste0("Band", band_num)

src_path <- here("src")
data_path <- here("data", "clean", band_name)

# collect all matching plot folders in src/ that exist in the BandX metadata folder
all_plot_dirs <- dir_ls(src_path, type = "directory", regexp = "[0-9]+$") %>%
  path_file()

band_plots <- dir_ls(data_path, type = "directory", regexp = "[0-9]+$") %>%
  path_file() %>%
  intersect(all_plot_dirs) %>%
  sort()

# extract title string from metadata json
get_title <- function(plot_id) {
  json_path <- path(data_path, plot_id, paste0(plot_id, "_Data.csv-metadata.json"))
  
  if (file_exists(json_path)) {
    json <- tryCatch(fromJSON(json_path), error = function(e) return(NULL))
    if (!is.null(json) && !is.null(json$tables$tableSchema$title)) {
      return(json$tables$tableSchema$title[[1]])
    }
  }
  
  return("[Kein Titel gefunden]")
}

# run plot scripts
for (plot_id in band_plots) {
  plot_script <- here("src", plot_id, paste0(plot_id, "_plot.R"))
  if (file.exists(plot_script)) {
    message(sprintf("Running plot script: %s", plot_script))
    tryCatch(
      {
        source(plot_script)
      },
      error = function(e) {
        message(sprintf("Fehler im Script %s: %s", plot_script, e$message))
      }
    )
  } else {
    message(sprintf("Kein Script gefunden: %s", plot_script))
  }
}

message(sprintf("\nAlle Plots aus Band %s generiert.\n", band_num))
message(sprintf("Die folgenden Plots aus Band %s sind in diesem Repository verfügbar:\n", band_num))

for (plot_id in band_plots) {
  title <- get_title(plot_id)
  cat(paste0(plot_id, " – ", title, "\n"))
}
