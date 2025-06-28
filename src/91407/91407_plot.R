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

source(here("src", "91407", "91407_clean.R"))

# Transform Data -------------

data91407_longer <- pivot_longer(data91407,
                                 cols = -Jahr,
                                 names_to = "Partei",
                                 values_to = "Sitze")


data91407_longer$Partei <- factor(data91407_longer$Partei, levels = c("FDP/RDP",
                                                                      "LP/LDP",
                                                                      "Zentrum",
                                                                      "SP",
                                                                      "KVP/CVP",
                                                                      "BGP",
                                                                      "Andere"))

# Diagramm plotten -----------

plot91407 <- ggplot(data = data91407_longer,
                    aes(x = Jahr, y = Sitze, color = Partei, group = Partei)) +
  
  geom_line(linewidth = 0.561) +
  
  scale_color_manual(values = c("FDP/RDP" = "#3872B5",
                               "LP/LDP" = "#618DEA",
                               "Zentrum" = "#DEAA28", # wie EVP?
                               "BGP" = "#4B8A3E",
                               "SP" = "#F0554D",
                               "KVP/CVP" = "#D6862B",
                               "Andere" = "#777777")) +
  
  scale_x_continuous(
    breaks = data91407_longer$Jahr,
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0))
  ) +

  scale_y_continuous(
    limits = c(0, 100),
    breaks = seq(0, 100, by = 20),
    expand = expansion(mult = c(0, 0)),
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
        legend.key.width = unit(5, "mm"), # entspricht 4.5 mm
        plot.margin = margin(0.5,1.2,0,0.5, "lines"),
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1)
        )

# Export ---------------------

export_plot(plot91407, 6, 120, 60, 22, 18)