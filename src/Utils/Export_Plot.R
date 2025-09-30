# Packages ---------

library(here)
library(ggplot2)
library(ggpubr)

# Function to Export Plot and Legend ---------

export_plot <- function(plot, volume, plot_width_mm, plot_height_mm, 
                        legend_width_mm = NULL, legend_height_mm = NULL,
                        plot_suffix = NULL, legend_suffix = NULL) {
  
  # Extract plot name and derive mediaID
  plot_name <- deparse(substitute(plot))
  raw_mediaID <- sub("plot(\\d{5}[a-zA-Z]*)$", "\\1", plot_name)
  baseID <- sub("^(\\d{5}).*$", "\\1", raw_mediaID)  # strip any trailing letters
  
  # Folder ID for saving
  folderID <- baseID
  
  # Convert mm to inches
  plot_width_in <- plot_width_mm / 25.4
  plot_height_in <- plot_height_mm / 25.4
  
  # Output folder
  volume_folder <- paste0("Band", volume)
  media_folder <- here("output", volume_folder, folderID)
  if (!dir.exists(media_folder)) dir.create(media_folder, recursive = TRUE)
  
  # Helper: build filename with optional suffix
  build_filename <- function(id, suffix, label) {
    if (is.null(suffix)) {
      paste0(id, "_", label, ".pdf")
    } else {
      paste0(id, "_", suffix, "_", label, ".pdf")
    }
  }
  
  # ---- Export Plot ----
  plot_file <- file.path(media_folder, build_filename(baseID, plot_suffix, "Plot"))
  pdf(file = plot_file, bg = "transparent", pointsize = 6.5, colormodel = "cmyk",
      width = plot_width_in, height = plot_height_in)
  print(plot)
  dev.off()
  
  # ---- Export Legend (if present) ----
  if (!is.null(legend_width_mm) && !is.null(legend_height_mm)) {
    legend_width_in <- legend_width_mm / 25.4
    legend_height_in <- legend_height_mm / 25.4
    plot_with_legend <- plot + theme(legend.position = "bottom")
    separate_legend <- get_legend(plot_with_legend) |> as_ggplot()
    
    legend_file <- file.path(media_folder, build_filename(baseID, legend_suffix, "Legende"))
    pdf(file = legend_file, bg = "transparent", colormodel = "cmyk",
        width = legend_width_in, height = legend_height_in)
    print(separate_legend)
    dev.off()
  }
  
  message("Objekt ", baseID, ": Plot als PDF im Ordner ", here(media_folder), " gespeichert.\n",
          "Die Daten sind auch auf der Forschungsdatenplattform von Stadt.Geschichte.Basel verfügbar:\n",
          "https://forschung.stadtgeschichtebasel.ch/items/abb", folderID, ".html")
}