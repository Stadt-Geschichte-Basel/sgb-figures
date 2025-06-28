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

source(here("src", "92492", "92492_clean.R"))

# Transform Data -------------

data92492_longer <- pivot_longer(data92492,
                                 cols = !Jahr,
                                 names_to = "Konfessionen",
                                 values_to = "Anteil")

# to force equal distribution on x-axis
data92492_longer$Jahr <- factor(data92492_longer$Jahr)

data92492_longer$Konfessionen <- factor(data92492_longer$Konfessionen,
                                        levels = c("Protestantisch",
                                                   "Katholisch",
                                                   "Christkatholisch",
                                                   "Jüdisch",
                                                   "Andere/Keine/Unbekannt"))

# Plot -----------------------

plot92492 <- ggplot(data = data92492_longer,
                    aes(x = Jahr, y = Anteil, fill = Konfessionen)) +
  
  geom_bar(stat = "identity", position = position_fill()) +
  
  scale_fill_manual(values = c("Protestantisch" = "#6195CF",
                               "Katholisch" = "#F7CB45",
                               "Christkatholisch" = "#F7F056",
                               "Jüdisch" = "#90C987",
                               "Andere/Keine/Unbekannt" = "#777777")) +
  
  scale_x_discrete(
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0))
  ) +

  scale_y_continuous(
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
    labels = label_percent()
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
        legend.key.width = unit(5, "mm"), # entspricht 4.5 mm
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1),
        axis.ticks.x = element_blank(),
        plot.margin = margin(0.5,0.15,0,0, "lines")
        )

# Export ---------------------

export_plot(plot92492, 6, 105, 72, 36, 14)