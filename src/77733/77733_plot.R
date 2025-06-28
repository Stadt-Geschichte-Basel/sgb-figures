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

source(here("src", "77733", "77733_clean.R"))

# Transform Data ------------------

colnames(data77733)[3] <- "Wohnbevölkerung Kanton Basel-Landschaft\n(ab 1994 mit Laufental)"

# Plot -----------------------

plot77733 <- ggplot() +
  
  geom_line(data = data77733, aes(x = Jahr, y = `Wohnbevölkerung Kanton Basel-Landschaft\n(ab 1994 mit Laufental)`,
                                                        color = "Wohnbevölkerung Kanton Basel-Landschaft\n(ab 1994 mit Laufental)"),
            linewidth = 0.561) +
  
  geom_line(data = data77733, aes(x = Jahr, y = `Wohnbevölkerung Kanton Basel-Stadt`,
                                  color = "Wohnbevölkerung Kanton Basel-Stadt"),
            linewidth = 0.561) +

  scale_x_continuous(
    breaks = pretty_breaks(),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 300000),
    breaks = seq(0, 300000, 50000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_color_manual(values = c("Wohnbevölkerung Kanton Basel-Stadt" = "#1d1d1d",
                                "Wohnbevölkerung Kanton Basel-Landschaft\n(ab 1994 mit Laufental)" = "#DC050C"),
                     breaks = c("Wohnbevölkerung Kanton Basel-Stadt",
                                "Wohnbevölkerung Kanton Basel-Landschaft\n(ab 1994 mit Laufental)")) +

  coord_cartesian(clip = "off") + 
  
  guides(color = guide_legend(keyheight = unit(4.8, "mm"))) + # results in ca. 3 mm
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.height = unit(1.64, "mm"),
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,0.9,0,0, "lines")
  )

# Export -----------------------

export_plot(plot77733, 8, 120, 63, 58.5, 10.5)