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

source(here("src", "88454", "88454_clean.R"))

# Transform Data ------------------

data88454_longer <- data88454 %>%
  pivot_longer(cols = -Jahr,
               names_to = "Einrichtung",
               values_to = "Anzahl",
               names_prefix = "'",
               names_transform = list(Jahr = as.numeric))

# Plot -----------------------

plot88454 <- ggplot(data88454_longer, aes(x = Jahr, y = Anzahl,
                                          fill = factor(Einrichtung, levels = c("Kinobesuche",
                                                                                "Museumseintritte")))) +
  
  geom_bar(stat = "identity",
           position = position_dodge()) +

  scale_x_continuous(
    breaks = c(1945, 1965, 1985, 2005, 2020),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 4500000),
    breaks = seq(0, 4500000, 500000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_fill_manual(values = c("Kinobesuche" = "#6195CF",
                               "Museumseintritte" = "#F7CB45")) +
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.width = unit(5, "mm"), # resultiert in 4.5 mm
    legend.key.height = unit(2.5, "mm"), # resultiert in 2 mm
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,0.9,0,0.4, "lines"))

# Export -----------------------

export_plot(plot88454, 8, 120, 63, 27, 6)