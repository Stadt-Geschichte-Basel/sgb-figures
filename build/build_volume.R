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

# Extract title string from metadata JSON
extract_title <- function(json_content) {
  json_content$tables$tableSchema$title[[1]]
}

# Collect all titles for one plot_id
get_titles_for_plot <- function(plot_id) {
  plot_folder <- path(data_path, plot_id)
  collected_titles <- character()
  
  if (!dir_exists(plot_folder)) return("[Kein Titel gefunden]")
  
  filename_pattern <- paste0("^", plot_id, "(?:_([0-9]+))?_Data\\.csv-metadata\\.json$")
  metadata_files   <- dir_ls(plot_folder, type = "file", regexp = "_Data\\.csv-metadata\\.json$")
  metadata_files   <- metadata_files[str_detect(path_file(metadata_files), filename_pattern)]
  
  if (length(metadata_files) == 0) return("[Kein Titel gefunden]")
  
  metadata_rows <- lapply(metadata_files, function(file_path) {
    base_name <- path_file(file_path)
    match_info <- str_match(base_name, filename_pattern)
    suffix_number <- ifelse(is.na(match_info[1, 2]), 0L, as.integer(match_info[1, 2]))
    
    json_content <- tryCatch(fromJSON(file_path), error = function(e) NULL)
    title <- if (!is.null(json_content)) extract_title(json_content) else NA_character_
    
    data.frame(
      suffix = suffix_number,
      title  = title,
      stringsAsFactors = FALSE
    )
  })
  
  metadata_df <- do.call(rbind, metadata_rows)
  metadata_df <- metadata_df[order(metadata_df$suffix), , drop = FALSE]
  
  titles <- metadata_df$title
  titles <- titles[!is.na(titles) & nchar(trimws(titles)) > 0]
  
  if (length(titles) == 0) "[Kein Titel gefunden]" else paste(unique(titles), collapse = " | ")
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
  titles <- get_titles_for_plot(plot_id)
  cat(paste0(plot_id, " – ", titles, "\n"))
}