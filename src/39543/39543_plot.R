# Packages -------------------

library(here)
library(ggplot2)
library(tidyr)
library(scales)
library(dplyr)
library(zoo)

# Functions ------------------

source(here("src", "Funktionen", "Format_Theme.R"))
source(here("src", "Funktionen", "Format_Tausendertrennzeichen.R"))
source(here("src", "Funktionen", "Format_Achsenbeschriftung.R"))
source(here("src", "Funktionen", "Export_Plot.R"))

# Read Data ------------------

source(here("src", "39543", "39543_clean.R"))

# Transform Data -------------

data39543_longer <- data39543[,-2:-3]

data39543_longer <- data39543_longer %>%
  pivot_longer(
    !Startjahr,
    names_to = "Urteilstyp",
    values_to = "Anzahl"
  )

data39543_longer$Urteilstyp <- factor(data39543_longer$Urteilstyp, 
                                      levels = c("Gotteslästerung", 
                                                 "Ehrverletzung",
                                                 "Meineid",
                                                 "Ungehorsam",
                                                 "Jugenddelikt",
                                                 "Eigentum",
                                                 "Sexualdelikt",
                                                 "«Geloiff» (Tumult)",
                                                 "Totschlag",
                                                 "Wundtat"))

# Plot -----------------------

plot39543 <- ggplot(data39543_longer,
                    aes(x = Startjahr, y = Anzahl, fill = Urteilstyp)) +
  
  geom_bar(stat = "identity", position = "fill") +

    scale_fill_manual(values = c("Gotteslästerung" = "#777777",
                                "Ehrverletzung" = "#90C987",
                                "Meineid" =  "#FAE7B5",
                                "Ungehorsam" = "#F7CB45",
                                "Jugenddelikt" = "#A5170E",
                                "Eigentum" = "#E8601C",
                                "Sexualdelikt" = "#994F88",
                                "«Geloiff» (Tumult)" = "#4EB265",
                                "Totschlag" = "#b3c1d4", 
                                "Wundtat" = "#7BAFDE")) +
  
  scale_x_continuous(
    breaks = data39543$Startjahr,
    labels = data39543$Zeitraum,
    guide = guide_axis(angle = 0),
    expand = expansion(mult = c(0, 0))
  ) +

  scale_y_continuous(
    breaks = breaks_pretty(),
    labels = label_percent(),
    expand = expansion(mult = c(0, 0))
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

export_plot(plot39543, 3, 129.8, 72.2, 30, 26)