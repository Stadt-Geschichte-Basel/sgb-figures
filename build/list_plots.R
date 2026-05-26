renv::load(".")

library(here)
library(fs)
library(jsonlite)
library(stringr)

src_path <- here("src")
data_path <- here("data", "clean")

# get all folders in src/ except 'Utils'
plot_dirs <- dir_ls(src_path, type = "directory", regexp = "[0-9]+$") %>%
  path_file() %>%
  sort()

# extract title string from metadata json
extract_title <- function(json_content) {
  json_content$`dc:title`[[1]]
}

# Collect all titles for one plot_id
get_titles_for_plot <- function(plot_id) {
  band_folders <- dir_ls(data_path, type = "directory", regexp = "Band[0-9]+$")
  collected_titles <- character()

  for (band_folder in band_folders) {
    plot_folder <- path(band_folder, plot_id)
    if (!dir_exists(plot_folder)) next

    filename_pattern <- paste0("^", plot_id, "(?:_([0-9]+))?_Data\\.csv-metadata\\.json$")
    metadata_files <- dir_ls(plot_folder, type = "file", regexp = "_Data\\.csv-metadata\\.json$")
    metadata_files <- metadata_files[str_detect(path_file(metadata_files), filename_pattern)]

    if (length(metadata_files) == 0) next

    metadata_rows <- lapply(metadata_files, function(file_path) {
      base_name <- path_file(file_path)
      match_info <- str_match(base_name, filename_pattern)
      suffix_number <- ifelse(is.na(match_info[1, 2]), 0L, as.integer(match_info[1, 2]))

      json_content <- tryCatch(fromJSON(file_path), error = function(e) NULL)
      title <- if (!is.null(json_content)) extract_title(json_content) else NA_character_

      data.frame(
        suffix = suffix_number,
        title = title,
        stringsAsFactors = FALSE
      )
    })

    metadata_df <- do.call(rbind, metadata_rows)
    metadata_df <- metadata_df[order(metadata_df$suffix), , drop = FALSE]

    for (row_index in seq_len(nrow(metadata_df))) {
      title_text <- metadata_df$title[row_index]
      if (is.na(title_text) || nchar(trimws(title_text)) == 0) next
      collected_titles <- c(collected_titles, title_text)
    }
  }

  if (length(collected_titles) == 0) {
    "[Kein Titel gefunden]"
  } else {
    paste(unique(collected_titles), collapse = " | ")
  }
}

message("\nFolgende Plots sind in diesem Repository verfügbar:\n")

for (plot_id in plot_dirs) {
  titles <- get_titles_for_plot(plot_id)
  cat(paste0(plot_id, " – ", titles, "\n"))
}
