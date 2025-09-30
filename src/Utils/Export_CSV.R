library(here)

save_clean_csv <- function(data, vol, csv_suffix = NULL) {
  # Get object name as string
  full_name <- deparse(substitute(data))
  
  # Extract the mediaID: first 5 digits + optional trailing letters
  mediaID <- sub(".*?(\\d{5}[a-zA-Z]*)$", "\\1", full_name)
  
  # Extract pure folderID: just the first 5 digits (no letter)
  folderID <- sub("^(\\d{5}).*$", "\\1", mediaID)
  
  # Build suffix part
  suffix_part <- if (!is.null(csv_suffix)) paste0("_", csv_suffix) else ""
  
  # Build folder path
  csv_folder <- here("data", "clean", paste0("Band", vol), folderID)
  
  # Create folder if needed
  if (!dir.exists(csv_folder)) {
    dir.create(csv_folder, recursive = TRUE)
  }
  
  # File name uses pure folderID + optional suffix
  csv_file <- file.path(csv_folder, paste0(folderID, suffix_part, "_Data.csv"))
  
  # Write the CSV
  write.csv(data, csv_file, row.names = FALSE)
}
