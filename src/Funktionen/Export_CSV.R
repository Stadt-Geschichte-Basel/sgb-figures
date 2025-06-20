library(here)

save_clean_csv <- function(data, vol) {
  # Get object name as string
  full_name <- deparse(substitute(data))
  
  # Extract the mediaID: first 5 digits + optional trailing letters
  mediaID <- sub(".*?(\\d{5}[a-zA-Z]*)$", "\\1", full_name)
  
  # Extract folderID: just the first 5 digits
  folderID <- sub("^(\\d{5}).*$", "\\1", mediaID)
  
  # Build folder path
  csv_folder <- here("data", "clean", paste0("Band", vol), folderID)
  
  # Create folder if needed
  if (!dir.exists(csv_folder)) {
    dir.create(csv_folder, recursive = TRUE)
  }
  
  # File name uses full mediaID
  csv_file <- file.path(csv_folder, paste0(mediaID, "_Data.csv"))
  
  # Write the CSV
  write.csv(data, csv_file, row.names = FALSE)
}
