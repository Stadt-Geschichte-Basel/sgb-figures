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

source(here("src", "92237", "92237_clean.R"))

# Transform Data -------------

data92237_longer <- pivot_longer(data92237,
                          cols = c("Basel-Stadt", Glarus),
                          names_to = "Kanton",
                          values_to = "EW")

# Plot -----------------------

plot92237 <- ggplot(data = data92237_longer, aes(x = Jahr,
                                                 y = EW,
                                                 fill = Kanton)) +
  
  geom_bar(stat = "identity",
           position = position_dodge2(preserve = "single")) +
  
  scale_fill_manual(values = c("#F7CB45", "#6195CF")) +
  
  scale_x_continuous(
    breaks = c(1850, 1910),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0))
  ) +
  
  scale_y_continuous(
    limits = c(0, 150000),
    breaks = c(0, 30000, 50000, 100000, 150000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
    legend.key.width = unit(5, "mm"), # entspricht 4.5 mm
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    axis.ticks.x = element_blank(),
    plot.margin = margin(0.5,0.2,0,0, "lines")
)

# Export ---------------------

export_plot(plot92237, 6, 65, 50, 23, 7)