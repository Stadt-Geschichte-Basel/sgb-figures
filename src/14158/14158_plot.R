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

#data14158 <- readr::read_csv(here("Band4", "14158", "14158_Data.csv"))
source(here("src", "14158", "14158_clean.R"))

# Transform Data -------------

data14158 <- data14158[, -1]
data14158_longer <- pivot_longer(data14158,
                                 cols = -Jahrhundert, names_to = "variable", values_to = "value")

# Plot -----------------------

plot14158 <- ggplot(data14158_longer, aes(x = Jahrhundert, y = value, fill = variable)) +
  
  geom_bar(stat = "identity", position = position_dodge2(reverse = TRUE)) +
  
  scale_y_continuous(
    limits = c(0, max(15000)),
    breaks = breaks_pretty(),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  ylab("") +
  ggtitle("Anzahl") +
  
  scale_fill_manual(
    values = c("#6195CF", "#F7CB45"),
    labels = c("Total Bürgerrechtsaufnahmen", "Total aufgenommene Personen")
  ) +
  
  coord_cartesian(clip = "off") +
  
  guides(color = guide_legend()) +
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.height = unit(2.05, "mm"), # entspricht 1.64mm
    legend.key.width = unit(5, "mm"), # entspricht 4mm
    axis.ticks.x = element_blank(),
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,0.9,0,0, "lines")
  )

# Export ---------------------

export_plot(plot14158, 4, 113, 57.5, 46, 8)