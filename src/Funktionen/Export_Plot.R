# Packages ---------

library(here)
library(ggplot2)
library(ggpubr)

# Function to Export Plot and Legend ---------

export_plot <- function(plot, volume, plot_width_mm, plot_height_mm, 
                        legend_width_mm = NULL, legend_height_mm = NULL) {
  
  # Extract mediaID from plot variable name
  plot_name <- deparse(substitute(plot))
  mediaID <- sub("plot(\\d{5}[a-zA-Z]*)$", "\\1", plot_name)
  
  folderID <- sub("^plot(\\d{5}).*$", "\\1", plot_name)
  
  # Convert dimensions from mm to inches
  plot_width_in <- plot_width_mm / 25.4
  plot_height_in <- plot_height_mm / 25.4

  # Define file paths
  volume_folder <- paste0("Band", volume)
  media_folder <- here("output", volume_folder, folderID)
  
  # Create folder if it does not exist
  if (!dir.exists(media_folder)) {
    dir.create(media_folder, recursive = TRUE)
  }
  
  plot_file <- file.path(media_folder, paste0(mediaID, "_Plot_OutputR.pdf"))
  
  # Export Plot
  pdf(file = plot_file, bg = "transparent", pointsize = 6.5, colormodel = "cmyk",
      width = plot_width_in, height = plot_height_in)
  print(plot)
  dev.off()
  
  # Export Legend only if both legend dimensions are provided
  if (!is.null(legend_width_mm) && !is.null(legend_height_mm)) {
    
    legend_width_in <- legend_width_mm / 25.4
    legend_height_in <- legend_height_mm / 25.4
    
    plot_with_legend <- plot + theme(legend.position = "bottom")
    
    separate_legend <- get_legend(plot_with_legend) |> as_ggplot()

    # Export Legend
    legend_file <- file.path(media_folder, paste0(mediaID, "_Legende_OutputR.pdf"))
    
    pdf(file = legend_file, bg = "transparent", colormodel = "cmyk",
        width = legend_width_in, height = legend_height_in)
    print(separate_legend)
    dev.off()
    
  }
  
  message("Objekt ", mediaID, ": Plot als PDF im Ordner ", here(media_folder), " gespeichert.\nDie Daten sind auch auf der Forschungsdatenplattform von Stadt.Geschichte.Basel verfügbar:\nhttps://forschung.stadtgeschichtebasel.ch/items/abb", folderID, ".html")
}
