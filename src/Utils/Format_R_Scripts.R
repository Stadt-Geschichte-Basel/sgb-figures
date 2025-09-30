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

# --- 1. Package Management ---
# Ensure required packages (styler, lintr) are installed.
message("Checking for required packages: styler, lintr...")
required_packages <- c("styler", "lintr")

for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message(paste("Installing package:", pkg))
    install.packages(pkg)
  }
}

library(styler)
library(lintr)

# --- 2. Find R Files ---
# Recursively find all files ending with .R (case-insensitive) in the current directory.
project_root <- getwd()
message(paste("\nSearching for .R files in:", project_root))

r_files <- list.files(
  path = project_root,
  pattern = "\\.R$",
  recursive = TRUE,
  full.names = TRUE,
  ignore.case = TRUE
)

if (length(r_files) == 0) {
  message("No .R files found to format or lint. Exiting.")
  quit(save = "no", status = 0)
}

message(paste("Found", length(r_files), "R file(s) to process."))
print(r_files)

# --- 3. Format Files with styler ---
message("\n--- Running styler ---")
message("Formatting files... This may take a moment.")

# styler::style_files() can take a vector of file paths and will reformat them in place.
tryCatch({
  styler::style_files(r_files)
  message("Formatting complete.")
}, error = function(e) {
  message("An error occurred during styling:")
  print(e)
})


# --- 4. Lint Files with lintr ---
message("\n--- Running lintr ---")
message("Checking for style violations...")

# lintr::lint_file() returns a list of lints. We'll check each file.
# We use lapply to apply the linting function to each file and store the results.
lint_results <- lapply(r_files, lintr::lint_file)

# Consolidate and print results in a readable format.
total_lints <- 0
for (i in seq_along(lint_results)) {
  lints <- lint_results[[i]]
  if (length(lints) > 0) {
    file_path <- r_files[i]
    total_lints <- total_lints + length(lints)
    
    # Print a header for the file with issues.
    cat(sprintf("\n[!] Found %d lint(s) in: %s\n", length(lints), file_path))
    
    # Print each lint issue.
    print(lints)
  }
}

# --- 5. Final Summary ---
if (total_lints == 0) {
  message("\n✨ All files are clean. Great job! ✨")
} else {
  message(sprintf("\nFound a total of %d lint(s) across all files. Please review the output above.", total_lints))
}

message("\nScript finished.")
