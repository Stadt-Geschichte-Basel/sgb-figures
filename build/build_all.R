renv::load(".")

library(here)

# List all subdirectories in src/, excluding "Funktionen"
src_subdirs <- list.dirs(here("src"), full.names = FALSE, recursive = FALSE)
src_subdirs <- setdiff(src_subdirs, "Funktionen")

for (plot in src_subdirs) {
  plot_script <- here("src", plot, paste0(plot, "_plot.R"))
  if (file.exists(plot_script)) {
    message(sprintf("Running plot script: %s", plot_script))
    tryCatch(
      {
        source(plot_script)
      },
      error = function(e) {
        message(sprintf("Error in script %s: %s", plot_script, e$message))
      }
    )
  } else {
    message(sprintf("No script found at %s", plot_script))
  }
}

message("\nAlle verfügbaren Abbildungen als PDF, inklusive Daten als csv-Datei mit Metadaten, gespeichert.\nDie Daten sind auch auf der Forschungsdatenplattform von Stadt.Geschichte.Basel verfügbar:\nhttps://forschung.stadtgeschichtebasel.ch/")
