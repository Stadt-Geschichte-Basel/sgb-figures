# ggplot2-Theme für SGB-Statistiken
# Grundlagen-Theme, das je nach Bedürfnissen variiert werden kann
# basiert auf ggplot-Thema theme_grey() mit untenstehenden Änderungen.

# Verwendung im Skript: p + theme_sgb_basis() + theme(...)

# Packages ---------

## --- Ensure required packages are installed ---
required_packages <- c("ggplot2")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message(paste("Restoring package:", pkg, " from renv lockfile."))
    renv::restore()
  }
}

library(ggplot2)

# Definition des Themes ----
theme_sgb_basis <- function() {
  theme_grey() %+replace%

    theme(
      plot.title = element_blank(),
      plot.title.position = "plot", # Beschriftung an Plot-Grenzen ausrichten

      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      axis.text.x = element_text(size = 6.5, color = "black", margin = unit(c(2.2, 0, 0, 0), "pt")),
      axis.text.y = element_text(size = 6.5, color = "black", margin = unit(c(0, 0, 0, 0), "pt")),
      axis.line.x.bottom = element_line(color = "black", linewidth = 0.14),
      axis.line.y.left = element_line(color = "black", linewidth = 0.14),
      axis.ticks.x = element_line(color = "black", linewidth = 0.14),
      axis.ticks.y = element_line(color = "black", linewidth = 0.14),

      # Grid Lines formatieren
      panel.grid.major.y = element_line(color = "black", linewidth = 0.14),
      panel.grid.major.x = element_blank(),
      panel.grid.minor = element_blank(),

      # Hintergrundfarben auf Transparenz
      plot.background = element_blank(),
      panel.background = element_blank(),

      # Legende Formatieren
      legend.key = element_rect(fill = "transparent", colour = NA),
      legend.direction = "vertical",
      legend.background = element_blank(),
      legend.title = element_blank(),
      legend.text = element_text(color = "black", size = 6.5),
    )
}
