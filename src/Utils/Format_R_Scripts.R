# Format_R_Scripts.R
#
# This script automatically formats and lints all .R files in the current
# directory and its subdirectories.
#
# 1. It uses the `styler` package to reformat code according to the Tidyverse style guide.
# 2. It uses the `lintr` package to check for style violations and potential errors.
#
# Usage:
#   - Place this script in the root directory of your R project.
#   - Run it from the R console using: source("Format_R_Scripts.R")
#   - Or from the terminal: Rscript Format_R_Scripts.R

# --- 1. Ensure required packages are installed ---
required_packages <- c("styler", "lintr")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message(paste("Restoring package:", pkg, " from renv lockfile."))
    renv::restore()
  }
}

library(styler)
library(lintr)

# --- 2. Find all .R files ---
project_root <- getwd()
message(paste("\nSearching for .R files in:", project_root))

# Look for R files in src/ and build/ directories, excluding renv/
search_paths <- c(
  file.path(project_root, "src"),
  file.path(project_root, "build")
)
r_files <- c()

for (path in search_paths) {
  if (dir.exists(path)) {
    files <- list.files(
      path = path,
      pattern = "\\.R$",
      recursive = TRUE,
      full.names = TRUE,
      ignore.case = TRUE
    )
    r_files <- c(r_files, files)
  }
}

if (length(r_files) == 0) {
  message("No .R files found to format or lint. Exiting.")
  quit(save = "no", status = 0)
}

message(paste("Found", length(r_files), "R file(s) to process."))
print(r_files)

# --- 3. Format Files with styler ---
message("\n--- Running styler ---")
message("Formatting files... This may take a moment.")
tryCatch(
  {
    lapply(r_files, styler::style_file)
    message("Formatting complete.")
  },
  error = function(e) {
    message("An error occurred during styling:")
    print(e)
  }
)

# --- 4. Lint Files with lintr ---
message("\n--- Running lintr ---")
message("Checking for style violations...")

# Custom linters excluding line_length_linter
custom_linters <- lintr::linters_with_defaults(
  line_length_linter = NULL
)

lint_results <- lapply(r_files, function(file) {
  lintr::lint(file, linters = custom_linters)
})

# Consolidate and print results in a readable format.
total_lints <- 0
for (i in seq_along(lint_results)) {
  lints <- lint_results[[i]]
  if (length(lints) > 0) {
    file_path <- r_files[i]
    total_lints <- total_lints + length(lints)
    cat(sprintf("\n[!] Found %d lint(s) in: %s\n", length(lints), file_path))
    print(lints)
  }
}

# --- 5. Final Summary ---
if (total_lints == 0) {
  message("\n✨ All files are clean. Great job! ✨")
} else {
  message(sprintf(
    "\nFound a total of %d lint(s) across all files. Please review the output above.",
    total_lints
  ))
}

message("\nScript finished.")
