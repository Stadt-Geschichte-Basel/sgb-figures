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

source(here("src", "26896", "26896_clean.R"))

# Transform Data -------------

data26896_longer <- data26896 %>%
  pivot_longer(
    cols = -Jahr,
    names_to = "Staat",
    values_to = "Anzahl"
  )

# Plot -----------------------


plot26896 <- ggplot(data26896_longer, aes(x = Jahr, y = Anzahl, fill = Staat)) +
  
  geom_bar(stat = "identity", position = "stack") +
  
  scale_fill_manual(values = c("#F7CB45", "#6195CF")) +
  
  scale_x_continuous(
    breaks = seq(1930, 1960, by = 5),
    labels = seq(1930, 1960, by = 5),
    guide = guide_axis(angle = 45),
    expand = expansion(mult = c(0, 0))
  ) +
  
  scale_y_continuous(
    limits = c(0, 9000),
    breaks = seq(0, 9000, by = 1000),
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
    plot.margin = margin(0.5,0.1,0,0, "lines")
  )

# Export ---------------------

export_plot(plot26896, 7, 120, 63, 27, 7)