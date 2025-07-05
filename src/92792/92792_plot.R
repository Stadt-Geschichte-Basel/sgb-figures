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

source(here("src", "92792", "92792_clean.R"))

# Plot -----------------------

plot92792 <- ggplot(data92792, aes(x = `Anzahl Wohnungen`,
                                   y = reorder(Eigentümer, `Anzahl Wohnungen`))) +
  
  geom_bar(stat = "identity",
           aes(fill = "Anzahl Wohnungen")) +
  
  scale_x_continuous(
    limits = c(0, 3001.5),
    breaks = seq(0, 3000, 500),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_fill_manual(
    values = c("Anzahl Wohnungen" = "#3f7653")) + # Bandfarbe 9

  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(
    panel.grid.major.x = element_line(color = "black", linewidth = 0.14),
    panel.grid.major.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.1,1.15,0,0.4, "lines"),
    legend.position = "none",
    legend.key.width = unit(5, "mm"), # resultiert in 4.5 mm
    legend.key.height = unit(2.5, "mm"), # resultiert in 2 mm
    )

# Export ---------------------

export_plot(plot92792, 9, 144, 116, 30, 5)