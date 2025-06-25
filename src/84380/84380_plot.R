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

source(here("src", "84380", "84380_clean.R"))

# Plot -----------------------

plot84380 <- ggplot() +
  geom_line(data = data84380, aes(x = Jahr, y = Eheschliessungen,
                                  color = "Eheschliessungen"),
            linewidth = 0.561) +
  
  geom_line(data = data84380, aes(x = Jahr, y = Ehescheidungen,
                                  color = "Ehescheidungen"),
            linewidth = 0.561) +

  scale_x_continuous(
    breaks = pretty_breaks(),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 3000),
    breaks = seq(0, 3000, 1000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_color_manual(values = c("Eheschliessungen" = "#6195CF",
                                "Ehescheidungen" = "#F7CB45")) +

  coord_cartesian(clip = "off") +
  
  guides(color = guide_legend(keyheight = unit(4.8, "mm"))) + # results in ca. 3mm
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,1,0,0.4, "lines")
  )

# Export -----------------------

export_plot(plot84380, 8, 120, 63, 30, 8)