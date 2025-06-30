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

source(here("src", "21892", "21892_clean.R"))

# Plot -----------------------

plot21892 <- ggplot(data = data21892) +
  
  geom_line(aes(x = Jahresende,
                y = `Öffentliches Personal auf 1000 Einwohner`,
                color = "#6195CF"),
            linewidth = 0.561) +
  
  scale_x_continuous(
    breaks = c(1912, 1920, 1930, 1940, 1950, 1963),
    limits = c(1912, 1963),
    guide = guide_axis(angle = 0),
    expand = expansion(mult = c(0, 0))
  ) +

  scale_y_continuous(
    limits = c(25, 50),
    breaks = seq(0, 50, by = 5),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_color_identity(
    breaks = c("#6195CF"),
    labels = c("Öffentliches Personal\npro 1000 Einwohner:innen"),
    guide = "legend"
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1),
        legend.key.height = unit(2.05, "mm"), # entspricht 1.64mm
        legend.key.width = unit(5, "mm"), # entspricht 4mm
        plot.margin = margin(0.5,1.2,0,0, "lines"))

# Export ---------------------

export_plot(plot21892, 7, 68, 38, 37, 7)