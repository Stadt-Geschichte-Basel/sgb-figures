# Packages -------------------

library(here)
library(ggplot2)
library(tidyr)
library(scales)
library(dplyr)

# Functions ------------------

source(here("src", "Funktionen", "Format_Theme.R"))
source(here("src", "Funktionen", "Format_Tausendertrennzeichen.R"))
source(here("src", "Funktionen", "Format_Achsenbeschriftung.R"))
source(here("src", "Funktionen", "Export_Plot.R"))

# Read Data ------------------

source(here("src", "90886", "90886_clean.R"))

# Transform Data -------------

data90886_longer <- pivot_longer(data90886, cols = c("1870", "1910"),
                                 names_to = "Jahr",
                                 values_to = "Anteil")

data90886_longer$Jahr <- factor(data90886_longer$Jahr, levels = rev(c("1870", "1910")))

## Reihenfolge der Branchen anpassen
data90886_longer$Branche <- factor(data90886_longer$Branche,
                                   levels = (c("Persönliche Dienste/Dienstboten",
                                               "Öffentliche Dienste",
                                               "Verkehr",
                                               "Handel",
                                               "Sonstige Gewerbe/Industrie",
                                               "Chemie",
                                               "Textilindustrie",
                                               "Bekleidung/Reinigung",
                                               "Baugewerbe",
                                               "Landwirtschaft"
                                               ))
                                   )
                                   
# Plot -----------------------

plot90886 <- ggplot(data = data90886_longer, aes(y = Jahr,
                                                 x = Anteil/100,
                                                 fill = Branche)) +

  geom_bar(stat = "identity", position = "stack") +

  scale_x_continuous(
    limits = c(0, 1),
    labels = label_percent(),
    expand = expansion(mult = c(0, 0))
  ) +
  
  scale_y_discrete(
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0)),
  ) +
  
  scale_fill_manual(values = c("Landwirtschaft" = "#90C987",
                               "Baugewerbe" = "#882E72",
                               "Bekleidung/Reinigung" = "#994F88",
                               "Textilindustrie" = "#AA6F9E",
                               "Chemie" = "#BA8DB4",
                               "Sonstige Gewerbe/Industrie" = "#D1BBD7",
                               "Handel" = "#7BAFDE",
                               "Verkehr" = "#5289C7",
                               "Öffentliche Dienste" = "#1965B0",
                               "Persönliche Dienste/Dienstboten" = "#F7CB45"),
                    guide = guide_legend(reverse = TRUE)) +
  
  coord_cartesian(clip = "off") +

  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
    legend.key.width = unit(5, "mm"), # entspricht 4.5 mm
    axis.ticks.y = element_blank(),
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    panel.grid.major.x = element_line(color = "black", linewidth = 0.14),
    panel.grid.major.y = element_blank(),
    plot.margin = margin(0,1.4,0,0, "lines")
  )

# Export ---------------------

export_plot(plot90886, 6, 120, 55, 45, 27)