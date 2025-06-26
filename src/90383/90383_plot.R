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

source(here("src", "90383", "90383_clean.R"))

# Transform Data ------------------

data90383$Stadtviertel[1] <- "St. Alban"

data90383_longer <- data90383 %>%
  pivot_longer(
    cols = -Stadtviertel,
    names_to = "Klasse",
    values_to = "Anzahl"
  )

# Diagramm plotten -----------

plot90383 <- ggplot(data = data90383_longer,
                    aes(x = Stadtviertel, y = Anzahl, fill = Klasse)) +
  
  geom_bar(stat = "identity", position = position_fill()) +
  
  scale_fill_manual(values = c("Klasse1" = "#A5170E",
                               "Klasse2" = "#F7F056",
                               "Klasse3" = "#F7CB45",
                               "Klasse4" = "#7BAFDE",
                               "Klasse5" = "#6195CF",
                               "Klasse6" = "#90C987"),
                    labels = c("Klasse1" = "Inhaber und Leiter von Grossbetrieben, hohe Beamte,\nProfessoren, Geistliche, selbstständige Ärzte, Apotheker,\nTierärzte, Anwälte, Ingenieure, Architekten, hervorragende Künstler, Grossrentner",
                               "Klasse2" = "Mittlere und kleine Selbstständige",
                               "Klasse3" = "Mittlere Beamte und Lehrer",
                               "Klasse4" = "Unterbeamte und gelernte Arbeiter",
                               "Klasse5" = "Ungelernte Arbeiter",
                               "Klasse6" = "Häusliche Dienstboten")) +
  
  scale_x_discrete(
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0))
  ) +

  scale_y_continuous(
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
    labels = label_percent()
  ) +
  
  guides(fill = guide_legend(reverse = TRUE)) +
  
  coord_cartesian(clip = "off") +
  
  coord_flip() +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
        legend.key.width = unit(5, "mm"), # entspricht 4.5 mm
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1),
        axis.ticks.y = element_blank(),
        plot.margin = margin(0,1.5,0,0.5, "lines"),
        panel.grid.major.x = element_line(color = "black", linewidth = 0.14)
  )

# Export -----------------------

export_plot(plot90383, 6, 130, 53, 98, 22)