# Packages ---------

## --- Ensure required packages are installed ---
required_packages <- c("here")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message(paste("Restoring package:", pkg, " from renv lockfile."))
    renv::restore()
  }
}

library(here)

# Function to Export CSV ---------

save_clean_csv <- function(data, vol, csv_suffix = NULL) {
  # Get object name as string
  full_name <- deparse(substitute(data))

  # Extract the media_id: first 5 digits + optional trailing letters
  media_id <- sub(".*?(\\d{5}[a-zA-Z]*)$", "\\1", full_name)

  # Extract pure folder_id: just the first 5 digits (no letter)
  folder_id <- sub("^(\\d{5}).*$", "\\1", media_id)

  # Build suffix part
  suffix_part <- if (!is.null(csv_suffix)) paste0("_", csv_suffix) else ""

  # Build folder path
  csv_folder <- here("data", "clean", paste0("Band", vol), folder_id)

  # Create folder if needed
  if (!dir.exists(csv_folder)) {
    dir.create(csv_folder, recursive = TRUE)
  }

  # File name uses pure folder_id + optional suffix
  csv_file <- file.path(csv_folder, paste0(folder_id, suffix_part, "_Data.csv"))

  # Write the CSV
  write.csv(data, csv_file, row.names = FALSE)
}
