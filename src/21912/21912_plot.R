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

source(here("src", "21912", "21912_clean.R"))

# Plot -----------------------

plot21912 <- ggplot(data21912,
                    aes(x = Jahr, y = `Staatsausgaben pro Einwohner:in in CHF`)) +
  
  geom_bar(aes(fill = "Staatsausgaben"), stat = "identity") +
  
  scale_fill_manual(
    values = c("Staatsausgaben" = "#6195CF"),
    labels = c("Staatsausgaben\npro Einwohner:in in CHF")
  ) +
  
  scale_x_continuous(
    breaks = c(1920, 1930, 1940, 1950, 1960, 1966),
    guide = guide_axis(angle = 0),
    expand = expansion(mult = c(0, 0))
  ) +

  scale_y_continuous(
    limits = c(0, 2500),
    breaks = seq(0, 2500, by = 500),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_color_identity(
    name = "",
    breaks = c("#6195CF"),
    labels = c("Staatsausgaben in CHF pro Einwohner:in"),
    guide = "legend"
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        axis.ticks.x = element_blank(),
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1),
        legend.key.height = unit(2.05, "mm"), # entspricht 1.64mm
        legend.key.width = unit(5, "mm"), # entspricht 4mm
        plot.margin = margin(0.5,0.2,0,0, "lines"))

# Export ---------------------

export_plot(plot21912, 7, 68, 38, 37, 7)